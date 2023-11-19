set debuginfod enabled off
set host-charset UTF-8
set target-charset UTF-8
set target-wide-charset UTF-8
set osabi none
set complaints 0
set confirm off
set history save on
set history filename ~/.gdb_history
set history remove-duplicates 1
define asm
  layout asm
  layout reg
end
define src
  layout src
  layout reg
end

set prompt \033[1;32m>> \033[0m
