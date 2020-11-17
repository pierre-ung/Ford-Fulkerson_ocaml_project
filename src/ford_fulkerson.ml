open Graph
open Tools


let init_graph (gr:int graph) = 
  gmap gr (fun x -> (0,x))

let residual_graph (gr:(int*int) graph) =
  gmap gr (fun (x,y) -> y-x)


(* on fera tourner l'algo jusqu'à ce que la tete de la blacklist soit la source*)
let find_path (gr: int graph) (src: id) (target: id) (blacklist: id list) = 
  let rec loop (actual: id) (path: id list) (min_weight: int) (potentials: int out_arcs) = 
  match potentials with
    | [] -> (actual::blacklist,[],0)
    | (next,weight)::tail -> if next = target
                             then (blacklist, target::path, (min weight min_weight))
                            else
                              if not (List.mem next blacklist)
                              then if weight > 0 
                                    then loop next (next::path) (min weight min_weight) (out_arcs gr next)
                                    else loop actual path min_weight tail
                              else loop actual path min_weight tail                                
  in loop src [src] max_int (out_arcs gr src)


let rec add_path (gr: (int*int) graph) (path: id list) (n: int) = 
  match path with
  | [target] -> gr
  | actual::next::tail -> let new_graph = add_arc gr actual next n
                          in add_path new_graph (next::tail) n




(*)
let all_path (gr: 'a graph) (src: id) (trg: id) =

  let rec aux (actual: id) (memo: id list) (path: 'a graph) (out: 'a out_arcs) = 
    match out with 
    | [] -> [None] 
    | (node, w)::t -> if List.mem node memo
      then
        [None]
      else 
      if node = trg 
      then [Some (new_arc path actual node w)]
      else 
        (List.flatten(aux node (node::memo) (new_arc path actual node w) (out_arcs gr node)))@(List.flatten (aux actual memo path t))
  in aux src [src] (clone_nodes gr) (out_arcs gr src)
*)