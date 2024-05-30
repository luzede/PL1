open Str
open Printf
open Scanf
open Queue

let read_input filename =
  let ic = open_in filename in
  let n = int_of_string (input_line ic) in
  let grid = Array.make_matrix n n 0 in
  for i = 0 to n - 1 do
    let line = input_line ic in
    let nums = Str.split (Str.regexp " +") line in
    List.iteri (fun j num -> grid.(i).(j) <- int_of_string num) nums
  done;
  close_in ic;
  (n, grid)

let directions = [|
  (-1, 0); (1, 0); (0, -1); (0, 1);
  (-1, -1); (-1, 1); (1, -1); (1, 1)
|]

let in_bounds n x y = x >= 0 && x < n && y >= 0 && y < n

let bfs n grid =
  let start = (0, 0) in
  let goal = (n-1, n-1) in
  let visited = Array.make_matrix n n false in
  let queue = create () in
  let path = Hashtbl.create 100 in

  add (start, []) queue;
  visited.(0).(0) <- true;

  let rec search () =
    if is_empty queue then None
    else
      let ((x, y), moves) = take queue in
      if (x, y) = goal then Some (List.rev moves)
      else
        let current_cars = grid.(x).(y) in
        Array.iter (fun (dx, dy) ->
          let nx, ny = x + dx, y + dy in
          if in_bounds n nx ny && not visited.(nx).(ny) && grid.(nx).(ny) < current_cars then
            let direction =
              match dx, dy with
              | -1, 0 -> "N"
              | 1, 0 -> "S"
              | 0, -1 -> "W"
              | 0, 1 -> "E"
              | -1, -1 -> "NW"
              | -1, 1 -> "NE"
              | 1, -1 -> "SW"
              | 1, 1 -> "SE"
              | _ -> failwith "Invalid direction"
            in
            visited.(nx).(ny) <- true;
            add ((nx, ny), direction :: moves) queue;
        ) directions;
        search ()
  in
  search ()

  let () =
  let (n, grid) = read_input Sys.argv.(1) in
  match bfs n grid with
  | Some moves -> 
    let moves_string = "[" ^ (String.concat "," moves) ^ "]" in
    printf "%s" moves_string
  | None -> printf "IMPOSSIBLE"
