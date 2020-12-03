open Graph

val clone_nodes: 'a graph -> 'b graph
val gmap: 'a graph -> ('a -> 'b) -> 'b graph
val add_arc: int graph -> id -> id -> int -> int graph

val my_add_arc: (int*int) graph -> id -> id -> int -> (int*int) graph
val print_int_list: int list -> unit

val complete_subgraph: int graph -> int graph

val cents_to_float: int -> float