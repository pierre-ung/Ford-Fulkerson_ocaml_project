
(* Hello les déglingos *)

open Gfile
open Tools
open Ford_fulkerson
open Graph
open Printf
open Money_sharing

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
  (*
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in
  let solved = solve_max_flow int_graph _source _sink in
*)


  let (graph,infos) = money_from_file infile
  in
  let () = print_infos_list infos
  in 
  let int_graph = gmap graph int_of_string
  in
  let solved_graph = solve_money_sharing int_graph infos
  in


  (*
  let string_graph = gmap solved_graph (fun (a, b) -> "("^(string_of_int a)^","^(string_of_int b)^")") in
  *)



  (* Rewrite the graph that has been read. *)

  let () = money_write_file outfile solved_graph infos in

  
  let() = export_int_int_graph solved_graph (outfile^".dot") in
  


  () 
      
