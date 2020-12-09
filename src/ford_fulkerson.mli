open Graph

(*

------- Those functions are internal to the package.
		We let them here for further tests	---------------

val init_graph: int graph -> (int*int) graph

val residual_graph: (int*int) graph -> int graph

val find_path: int graph -> id -> id -> id list -> ((id list)*int)

val add_flow_on_path: int graph -> id list -> int -> int graph

val merge_initial_and_residual: int graph -> int graph -> (int*int) graph  
*)

val solve_max_flow: int graph -> id -> id -> (int*int) graph