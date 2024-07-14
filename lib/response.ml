type error = { code : int; [@key "error_code"] msg : string [@key "error_msg"] }
[@@deriving of_yojson { strict = false }]

exception Api_error of error
exception Parse_error of string

let parse_json p input =
  match Yojson.Safe.from_string input with
  | `Assoc [ ("error", error) ] -> (
      match error_of_yojson error with
      | Error parse_err -> raise (Parse_error parse_err)
      | Ok api_err -> raise (Api_error api_err))
  | `Assoc [ ("response", response) ] -> (
      match p response with
      | Error parse_err -> raise (Parse_error parse_err)
      | Ok response -> response)
  | _ -> failwith "unknown response"
