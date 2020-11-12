--[[
    LuaStruct: A little LuaFFI wrapper for making structs

    ZLIB License. Copyright (c) Nelson "darltrash" Lopez

    This software is provided 'as-is', without any express or implied warranty. In no event will 
    the authors be held liable for any damages arising from the use of this software.

    Permission is granted to anyone to use this software for any purpose, including 
    commercial applications, and to alter it and redistribute it freely, subject to the following 
    restrictions:

    1.  The origin of this software must not be misrepresented; 
        you must not claim that you wrote the original software. 
        If you use this software in a product, an acknowledgment 
        in the product documentation would be appreciated but is not required.

    2.  Altered source versions must be plainly marked as such, 
        and must not be misrepresented as being the original software.

    3.  This notice may not be removed or altered from any source distribution.
]]


assert(pcall(require, "ffi"), "LuaStruct requires LuaFFI to work!")
ffi = require 'ffi'

local structs = {}

return function(name, structdef)
    assert(type(name) == "string", 
        "Argument #1 expected to be a String, Got "..type(name)
    )
    assert(type(structdef) == "table", 
        "Argument #2 expected to be a Table, Got "..type(name)
    )

    assert(not name:find("%s"), "Name must not contain any spaces!")
    assert(not structs[name], "Struct '"..name.."' was already defined!")
    structs[name] = true

    local data = ""
    for _, v in ipairs(structdef) do
        assert(v.type, "Definition must contain type! Example: {'x', type = 'int'}")
        assert(not v.type:gsub("%s", ""):find("%W"), ("'%s' haves non-valid characters!"):format(v.type))
        data = data .. v.type .. " "
        for k2, v2 in ipairs(v) do
            assert(not v2:gsub("%*", ""):find("%W"), ("'%s' haves non-valid characters!"):format(v2))
            data = data .. v2 .. ", " 
        end
        data = data:sub(1, -3) .. "; "
    end

    ffi.cdef("typedef struct { "..data.." } "..name..";")

    return loadstring("return function(...)\nreturn ffi.new('"..name.."', ...)\nend")()
end
