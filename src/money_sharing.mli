open Graph


type path = string

type infos = id*string*int


val money_from_file: path -> (string graph*(infos list))

val money_write_file: path -> float graph -> infos list ->unit

val print_infos_list: infos list -> unit

val compute_diff: infos list -> (id*int) list

val money_init_graph: int graph -> (id*int) list -> int graph 

val solve_money_sharing: int graph -> infos list -> (int*int) graph