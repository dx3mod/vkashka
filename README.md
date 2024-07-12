# vkashka

A small extensible library for working with the [VK] API (version 5.199). It doesn't cover all the functionality, but allows you to do it yourself.
<!-- Небольшая расширяемая библиотека для работы с [VK](https://vk.com/) API (версии 5.199). Сейчас она не покрывает весь функционал, но позволяет сделать вам это самостоятельно.  -->


## Quick start

```bash
# Installation of development version.
$ opam pin vkashka_lwt_unix https://github.com/dx3mod/vkashka
``` 


```ocaml
let token = Vkashka.access_token "YOUR_TOKEN"
module Vk_api = Vkashka.Api (Vkashka_lwt_unix) (val token)

Vk_api.Users.(get ~user_ids:["username"] () >|= first)
(* - : (Vkashka.User.basic, string) result = *)
```

## Implemented

#### Objects

- User
  - [x] Basic
  - [x] Optional fields A-I
  - [ ] Optional fields L-R (70%)
- [ ] Wall
  - [ ] Basic Record

#### Methods 

- [x] Users
  - [x] get
- [x] Wall
  - [x] get
  - [x] getById

## Reference 

- [VK API](https://dev.vk.com/ru/reference) official documentation 

[VK]: https://vk.com/