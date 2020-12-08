open Gfile
open Tools
open Ford_fulkerson
open Graph
open Printf
open Money_sharing

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 3 then
    begin
      Printf.printf "\nUsage: %s infile outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;


  (* Arguments are : infile(1) outfile(2) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(2)
  in
  let (graph,infos) = money_from_file infile
  in
  let () = print_infos_list infos
  in 
  let infos = List.map (fun (id,name,paid) -> (id,name,(paid*100)) ) infos 
  in 
  let int_graph = gmap graph int_of_string
  in 
  let solved_graph = solve_money_sharing int_graph infos
  in
  let final_graph = gmap solved_graph (fun (x,y) -> cents_to_float x)
  in

  (* Write the graph corresponding to the solved money_sharing graph *)

  let () = money_write_file outfile final_graph infos in


  let final_graph = gmap final_graph string_of_float in

  let() = export final_graph (outfile^".dot") in



  () 

