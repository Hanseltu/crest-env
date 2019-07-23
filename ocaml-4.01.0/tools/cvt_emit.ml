# 13 "cvt_emit.mll"
 
let first_item = ref false
let command_beginning = ref 0

let add_semicolon () =
  if !first_item
  then first_item := false
  else print_string "; "

let print_unescaped_string s =
  let l = String.length s in
  let i = ref 0 in
  while !i < l do
    if s.[!i] = '\\'
    && !i+1 < l
    && (let c = s.[!i+1] in c = '{' || c = '`') (* ` *)
    then i := !i+1;
    print_char s.[!i];
    i := !i + 1
  done

# 24 "cvt_emit.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\252\255\253\255\001\000\255\255\254\255\002\000\003\000\
    \008\000\003\000\254\255\255\255\253\255\000\000\013\000\023\000\
    ";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\003\000\255\255\255\255\255\255\255\255\
    \003\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    ";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\255\255\000\000\000\000\008\000\255\255\
    \008\000\009\000\000\000\000\000\000\000\255\255\255\255\255\255\
    ";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\008\000\000\000\000\000\008\000\000\000\000\000\
    \013\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\008\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\014\000\014\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\015\000\015\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\008\000\
    \008\000\008\000\008\000\008\000\008\000\008\000\008\000\008\000\
    \008\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\003\000\000\000\007\000\008\000\
    \004\000\005\000\011\000\008\000\007\000\008\000\000\000\000\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\008\000\000\000\000\000\000\000\008\000\000\000\008\000\
    \000\000\000\000\000\000\000\000\000\000\009\000\008\000\000\000\
    \012\000\000\000\000\000\255\255\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\010\000\255\255\000\000\000\000\000\000\000\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    ";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\013\000\255\255\255\255\007\000\255\255\255\255\
    \007\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\007\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\007\000\007\000\007\000\007\000\007\000\
    \007\000\007\000\007\000\007\000\007\000\014\000\014\000\014\000\
    \014\000\014\000\014\000\014\000\014\000\014\000\014\000\015\000\
    \015\000\015\000\015\000\015\000\015\000\015\000\015\000\015\000\
    \015\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\000\000\255\255\006\000\007\000\
    \000\000\003\000\006\000\007\000\008\000\007\000\255\255\255\255\
    \008\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\007\000\255\255\255\255\255\255\007\000\255\255\007\000\
    \255\255\255\255\255\255\255\255\255\255\006\000\007\000\255\255\
    \009\000\255\255\255\255\008\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\006\000\009\000\255\255\255\255\255\255\255\255\
    \008\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    ";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec main lexbuf =
    __ocaml_lex_main_rec lexbuf 0
and __ocaml_lex_main_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 36 "cvt_emit.mll"
        ( command_beginning := Lexing.lexeme_start lexbuf;
          first_item := true;
          print_char '(';
          command lexbuf;
          print_char ')';
          main lexbuf )
# 138 "cvt_emit.ml"

  | 1 ->
# 43 "cvt_emit.mll"
        ( print_string "`"; main lexbuf )
# 143 "cvt_emit.ml"

  | 2 ->
# 44 "cvt_emit.mll"
        ( () )
# 148 "cvt_emit.ml"

  | 3 ->
# 45 "cvt_emit.mll"
        ( print_char(Lexing.lexeme_char lexbuf 0); main lexbuf )
# 153 "cvt_emit.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_main_rec lexbuf __ocaml_lex_state

and command lexbuf =
    __ocaml_lex_command_rec lexbuf 6
and __ocaml_lex_command_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 48 "cvt_emit.mll"
        ( () )
# 164 "cvt_emit.ml"

  | 1 ->
# 49 "cvt_emit.mll"
        ( prerr_string "Unterminated `...` at character ";
          prerr_int !command_beginning;
          prerr_newline();
          exit 2 )
# 172 "cvt_emit.ml"

  | 2 ->
# 54 "cvt_emit.mll"
        ( let s = Lexing.lexeme lexbuf in
          add_semicolon();
          print_string (String.sub s 1 (String.length s - 2));
          command lexbuf )
# 180 "cvt_emit.ml"

  | 3 ->
# 62 "cvt_emit.mll"
        ( let s = Lexing.lexeme lexbuf in
          add_semicolon();
          (* Optimise one-character strings *)
          if String.length s = 1 && s.[0] <> '\\' && s.[0] <> '\''
          || String.length s = 2 && s.[0] = '\\' && s.[1] <> '`' && s.[1]<>'{'
          (* ` *)
          then begin
            print_string "emit_char '";
            print_unescaped_string s;
            print_string "'"
          end else begin
            print_string "emit_string \"";
            print_unescaped_string s;
            print_string "\""
          end;
          command lexbuf )
# 200 "cvt_emit.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_command_rec lexbuf __ocaml_lex_state

;;

# 79 "cvt_emit.mll"
 
let _ = main(Lexing.from_channel stdin)

let _ = exit (0)

# 212 "cvt_emit.ml"