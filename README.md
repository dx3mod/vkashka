# vkashka

Библиотека для работы с VK API (версии 5.199). На данный момент имеет минимальный функционал, требует расширения. 
Поэтому в случае ваших задач потребуется допиливать самостоятельно.  

## Quick start

```ocaml
module Vk_api = Vkashka.Api (Vkashka_lwt_unix) (struct
 let access_token = "TOKEN"  
end);;

Vk_api.Users.get_user "username"
(* - : (Vkashka.User.basic, string) result = *)
```