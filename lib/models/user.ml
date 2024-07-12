(** https://dev.vk.com/ru/reference/objects/user *)

open Common

type t = {
  id : id;
  first_name : string;
  last_name : string;
  deactivated : bool option; [@default None]
  is_closed : bool;
      (** Скрыт ли профиль пользователя настройками приватности. *)
  can_access_closed : bool;
      (**  Может ли текущий пользователь видеть профиль при is_closed = 1 (например, он есть в друзьях). *)
}
[@@deriving of_yojson]
(** Basic information about user. *)

and deactivated = Deleted | Banned

type users = t list [@@deriving of_yojson]
