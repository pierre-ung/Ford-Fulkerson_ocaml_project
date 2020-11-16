open Graph
open Tools


let init_graph gr = 
  gmap gr (fun x -> (0,x))

let residual_graph gr =
  gmap gr (fun (x,y) -> y-x)



(*principe de all_path:
  match les arcs de sortie
  pour chaque noeud vérifie s'il est dans mémo
  si non, on all_path à partir de ce noeud, ajoute le résultat flattené au all_path des autres noeuds.
  Normalement, pas besoin de fonction intermédiaire.
*)

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





















