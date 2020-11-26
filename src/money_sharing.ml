open Printf
open Graph

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


let money_from_file path =

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




let money_write_file path graph =

  (* Open a write-file. *)
  let ff = open_out path in

  (* Write in this file. *)
  fprintf ff "%% This is a graph.\n\n" ;

  (* Write all nodes (with fake coordinates) *)
  n_iter_sorted graph (fun id -> fprintf ff "n %.1f 1.0\n" (float_of_int id)) ;
  fprintf ff "\n" ;

  (* Write all arcs *)
  e_iter graph (fun id1 id2 lbl -> fprintf ff "e %d %d %s\n" id1 id2 lbl) ;

  fprintf ff "\n%% End of graph\n" ;

  close_out ff ;
  ()



let money_export gr file = 
  let ff = open_out file in 
  fprintf ff "digraph finite_state_machine {
                  rankdir=LR;
                  size=\"8,5\"
                  node [shape = circle];";
  e_iter gr (fun id1 id2 lbl -> fprintf ff "%d -> %d [label = \"%s\"];\n" id1 id2 lbl) ;
  fprintf ff "}"




let print_infos_list infos = 
	let rec loop = function
		| [] -> Printf.printf "\n%!"
		| (id,name,paid)::reste -> let () = Printf.printf "Name : %s, id : %d, paid : %d\n%!" name id paid
											in loop reste
	in loop infos