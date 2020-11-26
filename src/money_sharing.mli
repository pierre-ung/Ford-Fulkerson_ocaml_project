open Graph


type path = string


val money_from_file: path -> string graph

val money_write_file: path -> string graph -> unit

val money_export: string graph -> path -> unit