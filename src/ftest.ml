
(* Hello les déglingos *)

open Gfile
open Tools
open Ford_fulkerson
open Graph
open Printf

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in



  let new_graph = empty_graph in
  let new_graph = new_node new_graph 0 in 
  let new_graph = new_node new_graph 1 in
  let new_graph = new_node new_graph 2 in
  let new_graph = new_node new_graph 3 in   
  let g1 = new_arc new_graph 0 1 5
  in 
  let g2 = new_arc g1 1 2 5
  in
  let g3 = new_arc g2 0 3 5
  in
  let g4 = new_arc g3 3 2 5
  in
  let g5 = new_arc g4 1 3 5
  in
  (all_path (init_graph g5) 3 2);
  ()

(*let string_graph = gmap new_graph (string_of_int) in
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile string_graph in

  let() = export string_graph (outfile^".vg") in



  () *)

