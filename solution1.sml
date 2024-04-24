fun parse file =
        let
            (* A function to read an integer from specified input. *)
            fun readInt input =
                    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

            (* Open input file. *)
            val inStream = TextIO.openIn file

            (* Read an integer and consume newline. *)
            val N = readInt inStream
            val _ = TextIO.inputLine inStream

            (* A function to read N integers from te open file. *)
            fun readInts 0 acc = acc
                | readInts n acc = readInts (n-1) (readInt inStream :: acc)
        in
            (N, readInts N [])
        end;

fun sum nil = 0
    | sum (h::t) = h + sum t;

fun solve (nil, s, s_c) = s_c
    | solve(arr, s, s_c) =
        let
            fun reverse xs =
                    let
                        fun rev (nil, z) = z
                            | rev (y::ys, z) = rev (ys, y::z)
                    in 
                        rev (xs, nil)
                    end;
            val reversed_arr = reverse arr;
            val head = hd arr;

            fun abs x = if x < 0 then ~x else x;
            fun abs_diff (x, y) = abs (x - y);
            fun min (x, y) = if x < y then x else y;


            fun solve2 (nil, s, s_c) = s_c
                | solve2(arr, s, s_c) =
                    let
                        val head = hd arr;
                        val tail = tl arr;
                    in
                        min (abs_diff (s, s_c), solve2 (tail, (s-head), (s_c+head)))
                    end;

            val min_val = solve2 (reversed_arr, s, s_c)
        in
            min (min_val, solve(tl arr, (s-head), (s_c+head)))
        end;


(* A function to solve it in Linear time, not entirely linear since it has to find the element
but it is much better than the previous solution. This takes at most N^2 but the previous one took N^3 *)
fun min (x, y) = if x < y then x else y;
fun abs x = if x < 0 then ~x else x;
fun solvelinear (arr, len, i, j, s, s_c) = 
    if i >= len then s_c else
    if j >= len andalso s > s_c then s_c else
    if s = s_c then 0 else
    let
        val abs_diff = abs (s - s_c);
        val (i, ith) = if s < s_c then (i+1, List.nth(arr, i)) else (i, 0)
        val (j, jth) = if s > s_c then (j+1, List.nth(arr, j)) else (j, 0)
    in
        min (abs_diff, solvelinear (arr, len, i, j, s+ith-jth, s_c-ith+jth))
    end;


fun fairseq fileName =
        let
            val (N, in_array) = parse fileName;
            (* val solution = solve(in_array, sum in_array, 0) *)
            val solution2 = solvelinear(in_array, N, 0, 0, sum in_array, 0)
        in
            print (Int.toString solution2)
        end;
