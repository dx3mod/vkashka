# vkashka

A small wrapper-library for the [VK] API (version 5.199). It's not complete, but you can extend it yourself. Builds on the [Cohttp] and [Lwt] abstractions in an implementation-independent way.

## Quick start

```bash
# Installation of development version.
$ opam pin vkashka https://github.com/dx3mod/vkashka
``` 

```ocaml
(* use any cohttp compatible implementation *)
#require "cohttp-lwt-unix";;
```

```ocaml
let token = Vkashka.access_token "YOUR_TOKEN"
module Vk_api = Vkashka.Api (Cohttp_lwt_unix.Client) (val token)

Vk_api.Users.(get ~user_ids:["username"] () >|= first)
(* - : (Vkashka.User.t, string) result *)
```

## Documentation 

- Tutorial in Russian on [ocamlportal.ru](https://ocamlportal.ru/libraries/web/vkashka)

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

## Reference 

- [VK API](https://dev.vk.com/ru/reference) official documentation 

[VK]: https://vk.com/
[Cohttp]: https://github.com/mirage/ocaml-cohttp
[Lwt]: https://github.com/ocsigen/lwt