open Common
open Media

module Record = struct
  type t = {
    id : id;
    owner_id : id;
    from_id : id;
    created_by : id option; [@default None]
    date : unixtime;
    edited : unixtime option; [@default None]
    text : string;
    kind : string; [@key "type"]
    attachments : Attachment.t list; [@default []]
  }
  [@@deriving of_yojson { strict = false }]
end

type records = { count : int; [@default -1] items : Record.t list }
[@@deriving of_yojson { strict = false }]
