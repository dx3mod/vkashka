type error = { error_code : int; error_msg : string }
[@@deriving of_yojson { strict = false }]

exception Response_error of error
exception Parse_error of string

let parse_json p input =
  match Yojson.Safe.from_string input with
  | `Assoc [ ("error", error) ] -> (
      match error_of_yojson error with
      | Error err -> raise (Parse_error err)
      | Ok resp_err -> raise (Response_error resp_err))
  | `Assoc [ ("response", response) ] -> (
      match p response with
      | Error err -> raise (Parse_error err)
      | Ok response -> response)
  | _ -> failwith "unknown response"
