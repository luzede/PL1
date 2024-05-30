(* Function to convert a number to a specified base *)
fun convert_to_base(num, base) =
    let
        fun convert(num, acc) =
            if num = 0 then
                acc
            else
                convert(num div base, (num mod base)::acc)
    in
        convert(num, [])
    end;

(* Function to check if all digits in the list are the same *)
fun same_digits([]) = true
  | same_digits([_]) = true
  | same_digits(x::y::xs) = (x = y) andalso same_digits(y::xs);

(* Function to find the minimum base for a given number *)
fun find_min_base(num) =
    let
        val limit = num div 2
        fun check_base(base) =
            if base > limit then base
            else if same_digits(convert_to_base(num, base)) then base
            else check_base(base + 1)
    in
        check_base(2)
    end;

(* Function to find minimum bases for a list of decimal numbers *)
fun minbases(numbers : int list) =
    let
        fun min_base_helper([], acc) = List.rev acc
          | min_base_helper(x::xs, acc) = min_base_helper(xs, find_min_base(x)::acc)
    in
        min_base_helper(numbers, [])
    end;
