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

            (* A function to read N integers from the open file. *)
            fun readInts 0 acc = acc
                | readInts n acc =
                    let
                        val i = readInt inStream
                    in
                        if i = 0 then readInts n (i :: acc)
                        else readInts (n - 1) (i :: acc)
                    end;
        in
            (N, readInts N [])
        end;

(* A datatype for the binary tree *)
datatype 'a tree = Null | Node of 'a * 'a tree * 'a tree

(* Function to build the tree from pre-order traversed list and popping elements
out of list, which can only be done by using ref, in reality we are assigning
new list to the box the reference points to.*)
fun build_tree (l: int list ref) =
    if null (!l) then Null
    else
        let
            val h = hd (!l)
            (* We can't do "l := tl (!l)" because it throws an error
            and the only way this works is by using "val _ = l := tl (!l)" *)
            val _ = l := tl (!l)
        in
            if h = 0 then Null
            else Node (h, build_tree l, build_tree l)
        end

(* Function to print the tree in in-order traversal *)
fun inorder (Null) = []
  | inorder (Node (x, l, r)) = (inorder l) @ [x] @ (inorder r);

fun reverse xs =
    let
        fun rev (nil, z) = z
            | rev (y::ys, z) = rev (ys, y::z)
    in 
        rev (xs, nil)
    end;

(* Function to arrange_tree the tree in lexicographically minimal in-order traversal*)
fun arrange_tree (Null) = (Null, NONE)
    | arrange_tree (Node (x, l, r)) =
        let
            val (l', minl) = arrange_tree l
            val (r', minr) = arrange_tree r
        in  
            case (minl, minr) of
                (NONE, NONE) => (Node (x, l', r'), SOME x)
              | (NONE, SOME minr) => if minr < x then (Node (x, r', l'), SOME minr)
                                        else (Node (x, l', r'), SOME x)
              | (SOME minl, NONE) => if minl < x then (Node (x, l', r'), SOME minl)
                                        else (Node (x, r', l'), SOME x)
              | (SOME minl, SOME minr) =>
                  if minr < minl then (Node (x, r', l'), SOME minr)
                  else (Node (x, l', r'), SOME minl)
        end

(* Function to print the list *)
fun printList xs = print (String.concatWith " " (map Int.toString xs));


fun arrange fileName =
    let
        val (N, l) = parse fileName;

        (* Creating a reference to the list *)
        val l = ref (reverse l);

        (* Building the tree *)
        val tree = build_tree l;

        (* Arranging the tree *)
        val (tree, _) = arrange_tree tree;
    in
        printList (inorder tree)
    end;