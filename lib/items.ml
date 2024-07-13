let first xs = Lwt.map (function [] -> None | u :: _ -> Some u) xs
let first_exn xs = Lwt.map List.hd xs
