(* Branch comment test (usr1) *)
open Graph

let clone_nodes (gr:'a graph) = 
	let nodes = n_fold gr (fun acu id -> id::acu) [] in
	List.fold_left new_node empty_graph nodes


let gmap (gr:'a graph) (f:'a->'b) = 
	e_iter gr (fun id1 id2 x -> f (id2,x))	




let rec add_arc g id1 id2 n =
  assert false 
