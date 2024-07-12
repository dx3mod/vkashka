open Lwt
open Cohttp_lwt_unix

let get uri =
  Client.get uri >>= fun (_, body) -> body |> Cohttp_lwt.Body.to_string

let post uri =
  Client.post uri >>= fun (_, body) -> body |> Cohttp_lwt.Body.to_string
