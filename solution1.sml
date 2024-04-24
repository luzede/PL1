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




fun fairseq fileName =
        let
            val (N, in_array) = parse fileName;
            val solution = solve(in_array, sum in_array, 0)
        in
            print (Int.toString solution)
        end;
