# vkashka

A small wrapper-library for the [VK] API (version 5.199). It's not complete, but you can extend it yourself. Builds on the [Cohttp] and [Lwt] abstractions in an implementation-independent way.

## Quick start

Installation of development version.
```bash
$ opam pin vkashka.dev https://github.com/dx3mod/vkashka.git
``` 

Example of use with the cohttp-lwt-unix backend:
```ocaml
open Lwt.Syntax

let () =
  Lwt_main.run @@

  let token = Vkashka.access_token "YOUR_TOKEN" in
  let module Vk_api = Vkashka.Make (Cohttp_lwt_unix.Client) ((val token)) in

  let* user = Vk_api.Users.(get ~user_ids:[ "username" ] () |> first_exn) in

  Lwt_fmt.printf "User : %a" Vkashka.User.pp user
```

See also the [`examples/`](./examples/) directory for more references.

## Documentation 

Lookup documentation using the [`odig`](https://github.com/b0-system/odig):
```bash
odig doc vkashka
```

Tutorial in Russian on [ocamlportal.ru](https://ocamlportal.ru/libraries/web/vkashka)


## Related

- [repostbot](https://github.com/dx3mod/repostbot) &mdash; real-world example

## Reference 

- [VK API](https://dev.vk.com/ru/reference) official documentation 

## Implemented

#### Objects

- User
  - [x] Basic
  - [x] Optional fields A-I
  - [ ] Optional fields L-R (70%)
- [x] Basic Wall Record

#### Methods 

- [ ] Users
  - [x] get
- [ ] Wall
  - [x] get (partial)
  - [x] getById (partial)

[VK]: https://vk.com/
[Cohttp]: https://github.com/mirage/ocaml-cohttp
[Lwt]: https://github.com/ocsigen/lwt
