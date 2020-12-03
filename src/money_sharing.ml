open Printf
open Graph
open Tools
open Ford_fulkerson

(* Format of text files:
   % This is a comment

   % Name of the persons and amount paid.
   n Pierre 10
   n Lucie 25
   n Loïc 15

   % The first node has id 0, the next is 1, and so on.

*)

type path = string

type infos = id*string*int

(* Reads a line with a node. *)
let read_node id graph line infolist =
  try Scanf.sscanf line "n %s %d" (fun name paid -> (new_node graph id, (id,name, paid)::infolist) ) 
  with e ->
    Printf.printf "Cannot read node in line - %s:\n%s\n%!" (Printexc.to_string e) line ;
    failwith "from_file"

(* Ensure that the given node exists in the graph. If not, create it. 
 * (Necessary because the website we use to create online graphs does not generate correct files when some nodes have been deleted.) *)
let ensure graph id = if node_exists graph id then graph else new_node graph id


(* Reads a comment or fail. *)
let read_comment graph line =
  try Scanf.sscanf line " %%" graph
  with _ ->
    Printf.printf "Unknown line:\n%s\n%!" line ;
    failwith "from_file"


let money_from_file (path: path) =

  let infile = open_in path in

  (* Read all lines until end of file. 
   * n is the current node counter. *)
  let rec loop n graph infolist =
    try
      let line = input_line infile in

      (* Remove leading and trailing spaces. *)
      let line = String.trim line in

      let (n2, graph2, infolist2) =
        (* Ignore empty lines *)
        if line = "" then (n, graph, infolist)

        (* The first character of a line determines its content : n or comment. *)
        else match line.[0] with
          | 'n' -> let readed = read_node n graph line infolist 
      				in (n+1, fst readed, snd readed)

          (* It should be a comment, otherwise we complain. *)
          | _ -> (n, read_comment graph line, infolist)
      in      
      loop n2 graph2 infolist2

    with End_of_file -> (graph,infolist) (* Done *)
  in

  let (final_graph, infolist) = loop 0 empty_graph [] in

  close_in infile ;
  (final_graph,infolist)


let get_name_of_id infos_list id = 
	let rec loop = function
		| [] -> failwith "No id for name"
		| (id1,name,paid)::reste -> if id1 = id then name else loop reste
	in loop infos_list



let money_write_file path graph infos_list =

  (* Open a write-file. *)
  let ff = open_out path in
  let size = List.length infos_list in
  (* Write in this file. *)
  fprintf ff "%% This is the solution for money sharing problem\n\n" ;

  (* Write all names, and what they have to pay. *)
  e_iter graph (fun id1 id2 to_pay -> if (id1 <> size && id2 <> size && id1 <> (size+1) && id2 <> (size+1) && to_pay <> 0. )
									then fprintf ff "%s owes %.2f$ to %s\n" (get_name_of_id infos_list id1) to_pay (get_name_of_id infos_list id2)  );

  

  fprintf ff "\n%% End of debts\n" ;

  close_out ff ;
  ()



let print_infos_list (infos_list: infos list) = 
	let rec loop = function
		| [] -> Printf.printf "\n%!"
		| (id,name,paid)::reste -> let () = Printf.printf "Name : %s, id : %d, paid : %d\n%!" name id paid
											in loop reste
	in loop infos_list



let compute_sum (infos_list: infos list) = List.fold_left (fun acc (id,name,paid) -> paid+acc) 0 infos_list 


let compute_diff (infos_list: infos list) = 
	let total = compute_sum infos_list in
	let perPerson = total / (List.length infos_list) in 
	List.fold_left (fun acc (id,name,paid) -> (id, (paid-perPerson) )::acc ) [] infos_list


let money_init_graph (gr: int graph) (diff_list: (id*int) list ) = 
	let complete_sub_graph = complete_subgraph gr in
	let size = List.length diff_list in
	let final_graph = new_node (new_node complete_sub_graph size) (size+1) in 
		n_fold final_graph (fun acc id -> if (id <> size && id <> (size+1)) then
											let score = List.assoc id diff_list in 
												if score < 0 then 
													new_arc acc size id (abs score)
												else new_arc acc id (size+1) score
										else acc) final_graph

let solve_money_sharing (gr:int graph) (infos_list: infos list) = 
	let algo_graph = money_init_graph gr (compute_diff infos_list) in
	let size = List.length infos_list in
	solve_max_flow algo_graph size (size+1)