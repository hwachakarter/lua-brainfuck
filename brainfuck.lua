local brainfuck = {}

-- asks input from user
-- returns 0 if invalid input
local function ask_input()
    io.write('\n[brainfuck] input symbol: ')
    local symbol = string.byte(io.read(), 1, 1)
    if symbol then
        return symbol
    else
        return 0
    end
end

-- the thing that runs brainfuck itself
-- * Arg 1: string to runs
-- * Arg 2: mode (defaults to 'cli')
-- Mode can be 'cli' or 'str', str returns a string, 'cli' outputs the result in real time
local function interpret(str, mode)
    -- if str is empty - leave
    if str == '' then
        return
    end

    -- default mode 'cli'
    mode = mode or 'cli'

    -- throw error if incorrect mode
    if (mode ~= 'cli') and (mode ~= 'str') then
        error('Invalid interpret mode!', 2)
    end

    local result_string = ''         -- string that will be returned if mode is 'str'
    local pointer = 1                -- poiner on data in stack
    local stack = {} -- stack with values
    local loops = {} -- array with loops
    local skipping = 0               -- skipping tells at what loop stack pos was skipping started
    local pos = 0                    -- starts at 1 because increases at the start
    repeat
        pos = pos + 1
        stack[pointer] = stack[pointer] or 0     -- init data in stack under the pointer
        local symbol = string.sub(str, pos, pos) -- current symbol
        -- if no skipping is happening check standard symbols
        if skipping == 0 then
            if symbol == '>' then
                pointer = pointer + 1
            elseif symbol == '<' then
                if pointer > 1 then
                    pointer = pointer - 1
                end
            elseif symbol == '+' then
                stack[pointer] = stack[pointer] + 1
                -- jump back to 0
                if stack[pointer] == 255 + 1 then
                    stack[pointer] = 0
                end
            elseif symbol == '-' then
                -- jump to 255
                stack[pointer] = stack[pointer] - 1
                if stack[pointer] == 0 - 1 then
                    stack[pointer] = 255
                end
            elseif symbol == '.' then
                -- output
                if mode == 'cli' then
                    io.write(string.format("%c", stack[pointer]))
                elseif mode == 'str' then
                    result_string = result_string .. string.format("%c", stack[pointer])
                end
            elseif symbol == ',' then
                -- input
                stack[pointer] = ask_input()
            end
        end
        -- loop check
        if symbol == '[' then
            -- add the start of the loop to the loops stack
            table.insert(loops, pos)
            -- set skipping for this loop if empty and skipping didn't start earlier
            if (stack[pointer] == 0) and (skipping == 0) then
                skipping = #loops
            end
        elseif symbol == ']' then
            if stack[pointer] ~= 0 then
                -- set position at the start of a loop
                pos = loops[#loops]
            else
                -- stop skipping if the loop that started skipping ended
                if skipping == #loops then
                    skipping = 0
                end
                -- remove loop because it ended
                table.remove(loops)
            end
        end
    until pos == #str
    return result_string
end

-- runs string and outputs to console
-- * Arg 1: string
-- * Arg 2: don't create new line (defaults to false)
function brainfuck.execute_string(str, no_new_line)
    -- create new line if needed
    interpret(str, 'cli')
    if not no_new_line then
        io.write('\n')
    end
end

-- runs file and outputs to console
-- * Arg 1: file name
-- * Arg 2: don't create new line (defaults to false)
function brainfuck.execute_file(file_name, no_new_line)
    local file = io.open(file_name, "r")
    -- if file doesn't exist
    if not file then
        error('File ' .. file_name .. ' not found', 2)
    else
        brainfuck.execute_string(file:read('a'), no_new_line)
    end
end

-- runs string and returns result as string
-- * Arg 1: string
function brainfuck.return_from_string(str)
    return interpret(str, 'str')
end

-- runs file and returns result as string
-- * Arg 1: file name
function brainfuck.return_from_file(file_name)
    local file = io.open(file_name, "r")
    -- if file doesn't exist
    if not file then
        error('File ' .. file_name .. ' not found', 2)
    else
        return brainfuck.return_from_string(file:read('a'))
    end
end

return brainfuck
