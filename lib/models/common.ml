type id = int [@@deriving of_yojson]
type unixtime = int [@@deriving of_yojson]

type city = { id : id; title : string } [@@deriving of_yojson]
and country = city

let int_to_bool_of_yojson ~typ (json : Yojson.Safe.t) =
  match json with
  | `Int 0 -> Ok false
  | `Int 1 -> Ok true
  | _ -> Error (Printf.sprintf "invalid %s value" typ)

type can = bool

let can_of_yojson = int_to_bool_of_yojson ~typ:"can"
