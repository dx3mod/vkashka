module Photo = struct
  type t = { sizes : size list }

  and size = { kind : string; [@key "type"] url : string }
  [@@deriving of_yojson { strict = false }]
end

module Attachment = struct
  type t = Photo of Photo.t | Other of string

  let of_yojson : Yojson.Safe.t -> _ = function
    | `Assoc [ ("type", `String kind); (_, json) ] -> (
        match kind with
        | "photo" -> Photo.of_yojson json |> Result.map (fun p -> Photo p)
        | other -> Ok (Other other))
    | _ -> Error "invalid attachment"
end
