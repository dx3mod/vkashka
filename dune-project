(lang dune 3.16)

(name vkashka)
(version 0.1.0)

(generate_opam_files true)

(source
 (github dx3mod/vkashka))

(authors "Mihail Lopatin <dx3mod@bk.ru>")
(maintainers "Mihail Lopatin <dx3mod@bk.ru>")

(license MIT)

; (documentation https://url/to/documentation)

(package
 (name vkashka)
 (synopsis "A minimal VK API wrapper")
 (description "A small extensible library for working with the VK API")
 (depends ocaml dune lwt cohttp cohttp-lwt ppx_deriving_yojson)
 (tags
  (api vk web)))