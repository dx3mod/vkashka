module User = Models.User

module type Http_client = Http_client.S
module type Token = Token.S

module Api (Client : Http_client) (T : Token) = struct
  let base_api_uri = Uri.of_string "https://api.vk.com/"
  let version = "5.199"

  let base_params uri =
    Uri.add_query_params' uri
      [ ("access_token", T.access_token); ("v", version) ]

  let send_request of_yojson uri =
    Client.post uri |> Lwt.map (Response.parse_json of_yojson)

  module Users = struct
    let endpoint = Uri.with_path base_api_uri "method/users.get" |> base_params

    let get ?(user_ids = []) () =
      Uri.add_query_param endpoint ("user_ids", user_ids)
      |> send_request User.basic_of_yojson

    let get_user_exn ~by:id =
      let id =
        match id with `Id id -> string_of_int id | `Name name -> name
      in

      get ~user_ids:[ id ] () |> Lwt.map (Result.map List.hd)
  end
end
