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

    let get ?(user_ids = []) ?(fields = []) ?name_case ?from_group_id () =
      let uri =
        let uri = Uri.add_query_param endpoint ("user_ids", user_ids) in
        let uri = Uri.add_query_param uri ("fields", fields) in
        let uri =
          match from_group_id with
          | None -> uri
          | Some from_group_id ->
              Uri.add_query_param' uri ("from_group_id", from_group_id)
        in
        let uri =
          match name_case with
          | None -> uri
          | Some name_case ->
              Uri.add_query_param uri ("name_case", [ name_case ])
        in

        uri
      in
      send_request User.users_of_yojson uri

    let first = function
      | Ok [ user ] -> Ok user
      | Ok [] -> Error "not found user"
      | Ok _ -> failwith "???"
      | Error e -> Error e

    let first_exn r = first r |> Result.get_ok
  end

  module Wall = struct
    module Endpoint = struct
      let get = Uri.with_path base_api_uri "method/wall.get"
      let get_by_id = Uri.with_path base_api_uri "method/wall.getById"
    end

    let get ?count ?offset ?filter id =
      let param =
        match id with
        | `Domain domain -> ("domain", domain)
        | `Owner_id owner_id -> ("owner_id", owner_id)
      in

      let uri =
        let uri = Uri.add_query_param' Endpoint.get param in
        let uri =
          Option.fold ~none:uri
            ~some:(fun c -> Uri.add_query_param' uri ("count", c))
            count
        in

        let uri =
          Option.fold ~none:uri
            ~some:(fun offset -> Uri.add_query_param' uri ("offset", offset))
            offset
        in

        let uri =
          Option.fold ~none:uri
            ~some:(fun filter -> Uri.add_query_param' uri ("filter", filter))
            filter
        in

        uri
      in

      send_request Wall.records_of_yojson uri

    let get_posts_by_ids ~owner_id ids =
      let params =
        List.map (fun id -> Printf.sprintf "%d_%d" owner_id id) ids
      in

      Uri.add_query_param Endpoint.get_by_id ("posts", params)
      |> send_request Wall.records_of_yojson

    let get_post_by_id ~owner_id id =
      get_posts_by_ids ~owner_id [ id ]
      |> Lwt.map (Result.map @@ fun records -> List.hd Wall.(records.items))
  end
end
