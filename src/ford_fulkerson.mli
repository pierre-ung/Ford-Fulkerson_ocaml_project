open Graph


val init_graph: int graph -> (int*int) graph

val residual_graph: (int*int) graph -> int graph

val find_path_v1: int graph -> id -> id -> id list -> ((id list)*(id list)*int)
val find_path_v2: int graph -> id -> id -> id list -> ((id list)*(id list)*int)

val add_path: (int*int) graph -> id list -> int -> (int*int) graph

val solve_max_flow: int graph -> id -> id -> (int*int) graph
