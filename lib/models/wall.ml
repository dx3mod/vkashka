open Common

module Record = struct
  type size = { kind : string; [@key "type"] url : string }
  [@@deriving of_yojson { strict = false }]

  and photo = { sizes : size list }

  type attachment = Photo of photo | Other of string

  let attachment_of_yojson : Yojson.Safe.t -> _ = function
    | `Assoc [ ("type", `String kind); (_, json) ] -> (
        match kind with
        | "photo" -> photo_of_yojson json |> Result.map (fun p -> Photo p)
        | other -> Ok (Other other))
    | _ -> Error "invalid attachment"

  type t = {
    id : id;
    owner_id : id;
    from_id : id;
    created_by : id option; [@default None]
    date : unixtime;
    text : string;
    kind : string; [@key "type"]
    attachments : attachment list; [@default []]
  }
  [@@deriving of_yojson { strict = false }]
end

type records = { count : int; [@default -1] items : Record.t list }
[@@deriving of_yojson { strict = false }]
