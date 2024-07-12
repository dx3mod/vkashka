# vkashka

Библиотека для работы с VK API (версии 5.199). На данный момент имеет минимальный функционал, требует расширения. 
Поэтому в случае ваших задач потребуется допиливать самостоятельно.  

## Quick start

```ocaml
let token = Vkashka.access_token "YOUR_TOKEN"
module Vk_api = Vkashka.Api (Vkashka_lwt_unix) (val token)

Vk_api.Users.get_user "username"
(* - : (Vkashka.User.basic, string) result = *)
```