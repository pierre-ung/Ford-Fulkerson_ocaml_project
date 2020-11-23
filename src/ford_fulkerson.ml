open Graph
open Tools



let init_graph (gr:int graph) = 
  gmap gr (fun x -> (0,x))

let residual_graph (gr:(int*int) graph) =
  gmap gr (fun (x,y) -> y-x)


let find_in_arcs gr node_id =
  n_fold gr (fun acc id -> 
      let out = out_arcs gr id in
      try
        (id, snd (List.find (fun x -> (fst x) = node_id) out))::acc
      with
      |Not_found -> acc)
    []


(* we'll be calling that function multiple times(List.mem node_id (List.map (fst) (out_arcs gr id)))), until it returns a blacklist containing the src id*)
(* the intern loop variable 'path' is used to return the path, but also as a memo list not to loop in the graph *)


let find_path_v1 (gr: int graph) (src: id) (target: id) (blacklist: id list) = 
  let rec loop (actual: id) (path: id list) (min_weight: int) (potentials: int out_arcs) =
    match potentials with
    | [] -> (actual::blacklist,[],0)
    | (next,weight)::tail -> if List.mem next path
      then loop actual path min_weight tail
      else
      if next = target
      then (blacklist, target::path, (min weight min_weight))
      else
      if not (List.mem next blacklist)
      then if weight > 0 
        then loop next (next::path) (min weight min_weight) (out_arcs gr next)
        else loop actual path min_weight tail
      else loop actual path min_weight tail                                
  in loop src [src] max_int (out_arcs gr src)



let find_path_v2 (gr: int graph) (src: id) (target: id) (blacklist: id list) = 
  let rec loop (actual: id) (path: id list) (min_weight: int) (potentials: int out_arcs) = 
    match potentials with
    | [] -> (actual::blacklist,[],0)
    | (next,weight)::tail ->
      if (not (List.mem next path) && not (List.mem next blacklist) && weight > 0) (* if i can go that way *)
      then 
        if next = target 
        then (blacklist, List.rev (target::path), (min weight min_weight)) (* path as been found *)
        else loop next (next::path) (min weight min_weight) (out_arcs gr next) (* on my way to find the path*)
      else loop actual path min_weight tail (* try next out_arc *)
  in loop src [src] max_int (out_arcs gr src)



let add_path (gr: (int*int) graph) (path: id list) (n: int) = 
  let rec loop temp_gr = function
    | [target] -> temp_gr
    | actual::next::tail -> let new_graph = my_add_arc temp_gr actual next n
      in loop new_graph (next::tail)
  in loop gr path


let solve_max_flow (gr: int graph) (src: id) (target: id) = 
  let rec loop (temp_gr: (int*int) graph) (blacklist: id list) = 
    if List.hd blacklist = src then temp_gr
    else let (new_blacklist, path, weight_to_add) = find_path_v2 (residual_graph temp_gr) src target blacklist
      in 
      if path = []
      (*if no path, re-use the same graph with new blacklist*)
      then loop temp_gr new_blacklist 
      else
        (*else, compute the new graph and use either new_blacklist or blacklist, they are the same*)
        let new_graph = add_path temp_gr path weight_to_add 
        in loop new_graph blacklist
  in loop (init_graph gr) [-1]
(*We add -1 to the blacklist to easy the program's writing.
  So that, the List.hd matching on first call doesn't throw an exception.
  Otherwise, some conditional work has to be done, and i didn't manage to make it smart in a functional-programming way.*)
