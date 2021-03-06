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
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in

  let initial_graph = solve_max_flow int_graph _source _sink


  in

  let string_graph = gmap initial_graph (fun (a, b) -> "("^(string_of_int a)^","^(string_of_int b)^")") in
  let () = write_file outfile string_graph in

  let() = export string_graph (outfile^".dot") in



  () 