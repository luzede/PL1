5;
5+10;
fun square x = x * x;

fun max a b =
        if a > b then a else b;

max 5 10;
nil;
[];

let
    val rec f =
        fn x => if null x then nil
            else (hd x + 3) :: f (tl x)
in
    f
end
[1,2,3,4];

fun fact 0 = 1
    | fact n = n * fact (n - 1);

fact(5);

fun halve nil = (nil, nil)
    | halve [a] = ([a], nil)
    | halve (a::b::cs) =
        let
            val (x, y) = halve cs
        in
            (a::x, b::y)
        end;

halve [1,2,3,4,5,6,7,8,9,10];

(* Sort a list of integers. *)
fun mergeSort nil = nil
    | mergeSort [e] = [e]
    | mergeSort theList =
        let
            (* From the given list make a pair of lists
* (x,y), where half the elements of the
* original are in x and half are in y. *)
            fun halve nil = (nil, nil)
                | halve [a] = ([a], nil)
                | halve (a::b::cs) =
                    let
                        val (x, y) = halve cs
                    in
                        (a::x, b::y)
                    end
            (* Merge two sorted lists of integers into
* a single sorted list. *)
            fun merge (nil, ys) = ys
                | merge (xs, nil) = xs
                | merge (x::xs, y::ys) =
                    if x < y then x :: merge(xs, y::ys)
                    else y :: merge(x::xs, ys)
            val (x, y) = halve theList
        in
            merge (mergeSort x, mergeSort y)
        end;

mergeSort [9,8,7,6,5,4,3,2,1,0];

fun power _ 0 = 1
    | power x n = x * power x (n-1);

power 2 10;

datatype day = M | Tu | W | Th | F | Sa | Su;

type complex = {
        real: real,
        imaginary: real
    };

fun addComplex (x: complex, y: complex): complex = {
            real = #real x + #real y,
            imaginary = #imaginary x + #imaginary y
        };

fun getImaginary (x: complex) = #imaginary x;


val n: complex = {real = 1.0, imaginary = 2.0};
val m: complex = {real = 3.0, imaginary = 4.0};

addComplex (n, m);

getImaginary n;

case floor 3.5 of
    3 => "three"
| 4 => "four"
| _ => "neither";

(* If true, the second expression is not evaluated *)
true orelse 1 div 0 = 0;


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
            val left_head = hd arr;
            val right_head = hd reversed_arr;

            fun abs x = if x < 0 then ~x else x;
            fun abs_diff (x, y) = abs (x - y);
            fun min (x, y) = if x < y then x else y;
        in
            min (abs_diff (s, s_c), min (solve(tl arr, (s-left_head), (s_c+left_head)), solve(tl reversed_arr, (s-right_head), (s_c+right_head))))
        end;

val f1 = [1,2,3,4];
(* 1 3 4 2 5 *)
val f2 = [1,3,4,2,5];
(* 1 17 5 2 42 *)
val f3 = [1,17,5,2,42];

solve(f1, sum f1, 0);
solve(f2, sum f2, 0);
solve(f3, sum f3, 0);



fun solve2 (nil, s, s_c) = s_c
    | solve2 (arr, s, s_c) =
        let
            val reversed_arr = reverse arr;
            val left_head = hd arr;
        in
        end




