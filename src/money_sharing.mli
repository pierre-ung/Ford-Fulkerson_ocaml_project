open Graph


type path = string

type infos = id*string*int


val money_from_file: path -> (string graph*(infos list))

val money_write_file: path -> string graph -> unit

val money_export: string graph -> path -> unit

val print_infos_list: infos list -> unit