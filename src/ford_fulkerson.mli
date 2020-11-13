open Graph


val init_graph: int graph -> (int*int) graph

val residual_path: (int*int) graph -> int graph

val all_path: (int*int) graph -> id -> id -> (((int*int) graph) option) list
