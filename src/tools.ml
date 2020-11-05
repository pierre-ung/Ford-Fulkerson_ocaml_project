let clone_nodes gr = List.map (fun (a, b) -> a) gr
let gmap gr f = List.map (fun (a, b) -> (a, (List.map f b))) gr
let rec add_arc g id1 id2 n =
  assert false 
