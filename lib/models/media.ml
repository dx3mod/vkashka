type size = { kind : string; [@key "type"] url : string }
[@@deriving of_yojson { strict = false }]

and photo = { sizes : size list }
