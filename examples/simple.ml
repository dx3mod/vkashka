open Lwt.Syntax

let () =
  Lwt_main.run
  @@
  let token = Vkashka.access_token (Sys.getenv "TOKEN") in
  let module Vk_api = Vkashka.Make (Cohttp_lwt_unix.Client) ((val token)) in
  let* user = Vk_api.Users.(get ~user_ids:[ "username" ] () |> first_exn) in

  Lwt_fmt.printf "User : %a" Vkashka.User.pp user
