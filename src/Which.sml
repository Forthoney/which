structure Which =
struct
  fun which cmd =
    let
      open OS.Process
      open OS.FileSys
      open OS.Path
      fun loop [] = NONE
        | loop (dir :: rest) =
            case
              Option.filter (fn path => access (path, [A_EXEC]))
                (joinDirFile {dir = dir, file = cmd})
            of
              SOME path => SOME path
            | NONE => loop rest
    in
      Option.composePartial (loop o String.fields (fn c => c = #":"), getEnv)
        "PATH"
    end
end
