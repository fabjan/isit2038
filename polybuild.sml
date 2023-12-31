(*
 * Poly/ML doesn't have support for MLB files, so we need to parse them and
 * make a special file that it can build instead.
 *
 * This script parses a .mlb file and prints a list of all .sml and .sig files
 * that are referenced, recursively.
 *
 * Building:
 *   $ polyc -o polybuild polybuild.sml
 *
 * Usage:
 *   # create a top-level file
 *   $ ./polybuild <file>.mlb > build.sml
 *   # compile it
 *   $ polyc -o <output> build.sml
 *
 * Caveats:
 *   * You need a `main` function in your code for Poly/ML to find the
 *     entry point.
 *   * Spaces in filenames are not supported.
 *   * The same line cannot contain multiple files.
 *   * If your .mlb file contains a file with a top level `val _ = ...`
 *     for the main entryoint, that file should be excluded from the
 *     generated top-level file.
 *
 * See: http://mlton.org/MLBasis for details on the MLB format.
 *)

fun println x =
  TextIO.print (x ^ "\n")

fun unfold f =
  case f () of
    NONE => []
  | SOME x => x :: unfold f

fun flatMap f xs =
  List.concat (List.map f xs)

fun flatten xs =
  flatMap (fn x => x) xs

fun isInterestingFile x =
  let
    val suffixes = [".sml", ".sig", ".mlb"]
    val isPathMapped = String.isSubstring "$"
  in
    List.exists (fn s => String.isSuffix s x) suffixes
    andalso not (isPathMapped x)
  end

fun collectFiles line =
  let
    val tokens = String.tokens Char.isSpace line
    val files = List.filter isInterestingFile tokens
  in
    case files of
      [] => NONE
    | _ => SOME files
  end

fun parseMLB parent fname =
  let
    val path = OS.Path.concat (parent, fname)
    val dir = OS.Path.dir path
    val mlb = TextIO.openIn path
    val lines = unfold (fn () => TextIO.inputLine mlb)
    val _ = TextIO.closeIn mlb
    val files = List.mapPartial collectFiles lines
  in
    flatMap (visitFile dir) (flatten files)
  end

and visitFile dir file =
  case OS.Path.ext file of
    SOME "mlb" => parseMLB dir file
  | SOME "sml" => [OS.Path.concat (dir, file)]
  | SOME "sig" => [OS.Path.concat (dir, file)]
  | _ => []

fun printUse fname =
  println ("use \"" ^ (OS.Path.mkCanonical fname) ^ "\";")

fun flattenMLB fname =
  let
    val dir = OS.Path.dir fname
    val files = parseMLB dir fname
  in
    print "(* Generated by polybuild *)\n";
    List.app printUse files
  end

fun main () =
  case CommandLine.arguments () of
    [file] => flattenMLB file
  | _ => TextIO.print "Usage: polybuild <file>.mlb\n"
