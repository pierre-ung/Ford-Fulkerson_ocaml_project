(* Branch comment test (usr1) *)
open Graph

let clone_nodes (gr:'a graph) = 
	let nodes = n_fold gr (fun acu id -> id::acu) [] in
	List.fold_left new_node empty_graph nodes


let gmap (gr:'a graph) (f:'a->'b) = 
	let new_graph = clone_nodes gr in
	e_fold gr (fun acc id1 id2 x -> new_arc acc id1 id2 (f x)) new_graph


let rec add_arc (gr:'a graph) (id1:int) (id2:int) (n:'a) =
	match find_arc gr id1 id2 with
	| None -> new_arc gr id1 id2 n
	| _ -> e_fold gr (fun acc id3 id4 x -> 
						if id1=id3 &&
						id2=id4 then new_arc acc id1 id2 (x+n)
						else new_arc acc id3 id4 x) (clone_nodes gr)



let add_to_first (a,b) c = (a+c,b)

let rec my_add_arc (gr: (int*int) graph) (id1: id) (id2: id) (n:int) =
	match find_arc gr id1 id2 with
	| None -> new_arc gr id1 id2 (0,n)
	| _ -> e_fold gr (fun acc id3 id4 x -> 
						if id1=id3 &&
						id2=id4 then new_arc acc id1 id2 (add_to_first x n)
						else new_arc acc id3 id4 x) (clone_nodes gr)
