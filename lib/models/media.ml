type size = { kind : string; [@key "type"] url : string }
[@@deriving of_yojson { strict = false }]

and photo = { sizes : size list }

module Attachment = struct
  type t = Photo of photo | Other of string

  let of_yojson : Yojson.Safe.t -> _ = function
    | `Assoc [ ("type", `String kind); (_, json) ] -> (
        match kind with
        | "photo" -> photo_of_yojson json |> Result.map (fun p -> Photo p)
        | other -> Ok (Other other))
    | _ -> Error "invalid attachment"
end