type 'a t = { response : 'a } [@@deriving of_yojson]

let parse_json p input =
  let parser = of_yojson p in
  Yojson.Safe.from_string input
  |> parser
  |> Result.map (fun resp -> resp.response)
