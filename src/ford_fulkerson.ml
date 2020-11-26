open Graph
open Tools



let init_graph (gr:int graph) = 
  gmap gr (fun x -> (0,x))

let residual_graph (gr:(int*int) graph) =
  let res_graph = gmap gr (fun (x,y) -> y-x)
in e_fold res_graph (fun acc id1 id2 n -> new_arc acc id2 id1 0) res_graph
(* for every edge in the graph, we create its back-edge, of value 0*)

(* we'll be calling that function multiple times, until it returns a blacklist containing the src id*)
(* the intern loop variable 'path' is used to return the path, but also as a memo list not to loop in the graph *)



let find_path (gr: int graph) (src: id) (target: id) (blacklist: id list) = 
  let rec loop (actual: id) (path: id list) (min_weight: int) (potentials: int out_arcs) = 
  match potentials with
    | [] -> (path,0) (*No path has been found, head of path will be added to blacklist*)
    | (next,weight)::tail ->
        if (not (List.mem next path) && not (List.mem next blacklist) && weight > 0) (* if i can go that way *)
        then 
          if next = target 
          then (target::path, (min weight min_weight)) (* path as been found *)
          else loop next (next::path) (min weight min_weight) (out_arcs gr next) (* on my way to find the path*)
        else loop actual path min_weight tail (* try next out_arc *)
  in loop src [src] max_int (out_arcs gr src)



let add_flow_on_path (gr: int graph) (path: id list) (n: int) = 
  let rec loop temp_gr = function
    | [] -> temp_gr
    | [target] -> temp_gr
    | actual::next::tail -> let added_going_flow = add_arc temp_gr actual next (-n)
                            in let added_back_flow = add_arc added_going_flow next actual n
                            in loop added_back_flow (next::tail)
  in loop gr path

                          




let merge_initial_and_residual (initial_gr: int graph) (residual_graph: int graph) =
  e_fold initial_gr (fun acc id1 id2 n -> match find_arc residual_graph id1 id2 with 
                                          | None -> failwith "Errors have been done"
                                          | Some x -> my_add_arc acc id1 id2 (n-x) ) (init_graph initial_gr)





(* Note on below function : gr and temp_gr are semanticaly different.
    gr is the initial graph with the capacities given by the user to be solved, 
    and temp_gr is the intermediate reidual_graph with flow that can still be added.*)

let solve_max_flow (gr: int graph) (src: id) (target: id) = 
  let rec loop (temp_gr: int graph) (blacklist: id list) = 
    if List.hd blacklist = src then (merge_initial_and_residual gr temp_gr)
    else let  (path, weight_to_add) = find_path temp_gr src target blacklist
    (* Path is given as a List going from the target to the source. eg: T-N3-N2-N1-S*)
          in
            if List.hd path <> target (* Path could reach the target *)
            then loop temp_gr ((List.hd path)::blacklist)
            else
            (*else, compute the new graph and use either new_blacklist or blacklist, they are the same*)
              let new_graph = add_flow_on_path temp_gr (List.rev path) weight_to_add 
              in loop new_graph [-1]
  in loop (residual_graph (init_graph gr)) [-1]

  (*We add -1 to the blacklist to ease the program's writing.
    So that, the List.hd matching on first call doesn't throw an exception.
    Otherwise, some conditional work has to be done, and i didn't manage to make it smart in a functional-programming way.*)

