open Graph
open Tools


let init_graph (gr:int graph) = 
  gmap gr (fun x -> (0,x))

let residual_graph (gr:(int*int) graph) =
  gmap gr (fun (x,y) -> y-x)


(* we'll be calling that function multiple times, until it returns a blacklist containing the src id*)
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
          then (blacklist, target::path, (min weight min_weight)) (* path as been found *)
          else loop next (next::path) (min weight min_weight) (out_arcs gr next) (* on my way to find the path*)
        else loop actual path min_weight tail (* try next out_arc *)
  in loop src [src] max_int (out_arcs gr src)



let add_path (gr: (int*int) graph) (path: id list) (n: int) = 
  let rec loop gr1 = function
    | [] -> gr
    | [target] -> gr1
    | actual::next::tail -> let new_graph = my_add_arc gr actual next n
                            in loop new_graph (next::tail)
  in loop gr path

                          