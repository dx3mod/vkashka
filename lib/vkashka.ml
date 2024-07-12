module User = Models.User
module Wall = Models.Wall

module type Http_client = Http_client.S
module type Token = Token.S

let access_token token =
  (module struct
    let access_token = token
  end : Token)

module Api (Client : Http_client) (T : Token) = struct
  let version = "5.199"

  let base_api_uri =
    Uri.add_query_params'
      (Uri.of_string "https://api.vk.com/")
      [ ("access_token", T.access_token); ("v", version) ]

  let send_request of_yojson uri =
    Client.post uri |> Lwt.map (Response.parse_json of_yojson)

  module Users = struct
    let endpoint = Uri.with_path base_api_uri "method/users.get"

    let get ?(user_ids = []) () =
      Uri.add_query_param endpoint ("user_ids", user_ids)
      |> send_request User.users_of_yojson

    let get_user id =
      get ~user_ids:[ id ] ()
      |> Lwt.map @@ function
         | Ok [ user ] -> Ok user
         | Ok [] -> Error "not found user"
         | Ok _ -> failwith "???"
         | Error e -> Error e

    let get_user_exn id =
      get ~user_ids:[ id ] ()
      |> Lwt.map @@ function
         | Ok [ user ] -> user
         | Ok _ -> failwith "not found user"
         | Error msg -> failwith msg
  end

  module Wall = struct
    module Endpoint = struct
      let get = Uri.with_path base_api_uri "method/wall.get"
      let get_by_id = Uri.with_path base_api_uri "method/wall.getById"
    end

    let get id =
      let param =
        match id with
        | `Domain domain -> ("domain", domain)
        | `Owner_id owner_id -> ("owner_id", owner_id)
      in

      Uri.add_query_param' Endpoint.get param
      |> send_request Wall.records_of_yojson

    let get_by_ids ~owner_id ids =
      let params =
        List.map (fun id -> Printf.sprintf "%d_%d" owner_id id) ids
      in

      Uri.add_query_param Endpoint.get_by_id ("posts", params)
      |> send_request Wall.records_of_yojson

    let get_by_id ~owner_id id =
      get_by_ids ~owner_id [ id ]
      |> Lwt.map (Result.map @@ fun records -> List.hd Wall.(records.items))
  end
end
