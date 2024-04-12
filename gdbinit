set debuginfod enabled off
set confirm off
set history save on
set history filename ~/.gdb_history
set history remove-duplicates 1
set auto-complete on
define asm
  layout asm
  layout reg
end
define src
  layout src
  layout reg
end

set prompt \033[1;32m>> \033[0m
