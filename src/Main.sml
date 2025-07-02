local
  val args = CommandLine.arguments ()
  val paths = List.mapPartial Which.which args
in
  val _ = print (foldl (fn (s, acc) => acc ^ s ^ "\n") "" paths)
  val _ =
    if length args <> length paths then OS.Process.exit OS.Process.failure else ()
end
