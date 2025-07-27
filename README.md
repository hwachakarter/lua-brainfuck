# lua-brainfuck
A horrible interpreter for brainfuck written in Lua

## Dependencies:
- ascii.lua (included)
- [ready_table](https://github.com/hwachakarter/lua-ready-table)

## Usage:
```lua
local brainfuck = require("brainfuck")
local code = "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
local output = brainfuck.execute_string(code)
print(output)  -- Output: Hello World!
```

## Methods:
- `brainfuck.execute_string(code)`: Executes a Brainfuck code string to CLI.
- `brainfuck.execute_file(filename)`: Executes Brainfuck code from a file to CLI.
- `brainfuck.return_from_string(code)`: Returns the output of Brainfuck code as a string.
- `brainfuck.return_from_file(filename)`: Returns the output of Brainfuck code from a file as a string.

## Hint:
- Don't use this interpreter for anything serious. It sucks.