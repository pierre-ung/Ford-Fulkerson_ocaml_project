open Graph


val all_path: (int*int) graph -> (((int*int) graph) option) list


let init_graph gr = 
	gmap gr (fun x -> (0,x))

let residual_path gr =
	gmap gr (fun (x,y) -> y-x)



(*principe de all_path:
match les arcs de sortie
	pour chaque noeud vérifie s'il est dans mémo
	si non, on all_path à partir de ce noeud, ajoute le résultat flattené au all_path des autres noeuds.
	Normalement, pas besoin de fonction intermédiaire.



*)