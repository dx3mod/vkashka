module Photo = struct
  type t = { sizes : size list }

  and size = { kind : string; [@key "type"] url : string }
  [@@deriving of_yojson { strict = false }, show]
end

module Video = struct
  type t = { preview : image list [@key "image"] }
  [@@deriving of_yojson { strict = false }, show]

  and image = {
    height : int;
    width : int;
    url : string;
    with_padding : int; [@default 1]
  }
end

module Attachment = struct
  type t = Photo of Photo.t | Video of Video.t | Other of string
  [@@deriving show]

  let of_yojson : Yojson.Safe.t -> _ = function
    | `Assoc [ ("type", `String kind); (_, json) ] -> (
        match kind with
        | "photo" -> Photo.of_yojson json |> Result.map (fun p -> Photo p)
        | "video" -> Video.of_yojson json |> Result.map (fun v -> Video v)
        | other -> Ok (Other other))
    | _ -> Error "invalid attachment"
end
