(** https://dev.vk.com/ru/reference/objects/user *)

open Common
open Media

type deactivated = Deleted | Banned

let deactivated_of_yojson = function
  | `String "deleted" -> Ok Deleted
  | `String "banned" -> Ok Banned
  | _ -> Error "invalid deactivated value"

type blacklisted = bool

let blacklisted_of_yojson = int_to_bool_of_yojson ~typ:"blacklisted"

type t = {
  id : id;
  first_name : string;
  last_name : string;
  deactivated : deactivated option; [@default None]
  is_closed : bool;
  can_access_closed : bool;
  about : string option; [@default None]
  status : string option; [@default None]
  activities : string option; [@default None]
  bdate : string option; [@default None]
  blacklisted : blacklisted option; [@default None]
  blacklisted_by_me : blacklisted option; [@default None]
  books : string option; [@default None]
  can_post : can option; [@default None]
  can_see_all_posts : can option; [@default None]
  can_see_audio : can option; [@default None]
  can_send_friend_request : can option; [@default None]
  can_write_private_message : can option; [@default None]
  career : career list; [@default []]
  city : city option; [@default None]
  common_count : int option; [@default None]
  contacts : contact list; [@default []]
  counters : counters option; [@default None]
  country : country option; [@default None]
  (* crop_photo : crop_photo option; [@default None] *)
  domain : string option; [@default None]
  university : int option; [@default None]
  university_name : string option; [@default None]
  faculty : int option; [@default None]
  faculty_name : string option; [@default None]
  graduation : int option; [@default None]
  followers_count : int option; [@default None]
  friend_status : int option; [@default None]
  games : string option; [@default None]
}
[@@deriving of_yojson { strict = false }]

and career = {
  group_id : id;
  string : string;
  country_id : id;
  city_id : id;
  city_name : string;
  from : int;
  until : int;
  position : string;
}

and contact = {
  mobile_phone : string option; [@default None]
  home_phone : string option; [@default None]
}

and counters = {
  albums : int;
  videos : int;
  audios : int;
  photos : int;
  notes : int;
  friends : int;
  gifts : int;
  groups : int;
  online_friends : int;
  mutual_friends : int;
  user_videos : int;
  user_photos : int;
  followers : int;
  pages : int;
  subscriptions : int;
}

and crop_photo = { photo : Photo.t }

type users = t list [@@deriving of_yojson]
