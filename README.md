# lua-brainfuck
A horrible interpreter for brainfuck written in Lua

## Dependencies:
None! It's a standalone library.

## Usage:
```lua
local brainfuck = require("brainfuck")
local code = "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
brainfuck.execute_string(code) -- output: Hello World!
```

## Methods:
- `brainfuck.execute_string(code)`: Executes a Brainfuck code string to CLI.
- `brainfuck.execute_file(filename)`: Executes Brainfuck code from a file to CLI.
- `brainfuck.return_from_string(code)`: Returns the output of Brainfuck code as a string.
- `brainfuck.return_from_file(filename)`: Returns the output of Brainfuck code from a file as a string.
