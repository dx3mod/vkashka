module type S = sig
  val get : Uri.t -> string Lwt.t
  val post : Uri.t -> string Lwt.t
end
