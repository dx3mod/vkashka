(lang dune 3.16)

(name vkashka)

(generate_opam_files true)

(source
 (github dx3mod/vkashka))

(authors "Mihail Lopatin <dx3mod@bk.ru>")
(maintainers "Mihail Lopatin <dx3mod@bk.ru>")

(license MIT)

; (documentation https://url/to/documentation)

(package
 (name vkashka)
 (synopsis "A minimal VK API wrapper.")
 (depends ocaml dune lwt cohttp ppx_deriving_yojson)
 (tags
  (api vk web)))

(package
 (name vkashka_lwt_unix)
 (depends vkashka lwt cohttp-lwt-unix))