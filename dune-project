(lang dune 3.16)

(name vkashka)

(version 0.2)

(generate_opam_files true)

(source
 (github dx3mod/vkashka))

(authors "Mikhail Lopatin <dx3mod@bk.ru>")

(maintainers "Mikhail Lopatin <dx3mod@bk.ru>")

(license MIT)

; (documentation https://url/to/documentation)

(package
 (name vkashka)
 (synopsis "A minimal VK API wrapper")
 (description "A small extensible library for working with the VK API")
 (depends ocaml dune lwt cohttp cohttp-lwt ppx_deriving_yojson ppx_deriving)
 (tags
  (api vk web)))
