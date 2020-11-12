# LuaStruct
A little LuaFFI wrapper for making C structs on Lua.

## Example:
```Lua
struct = require 'struct'
vec3 = struct("vec3", {
	{"x", "y", "z", type = "unsigned int"}
})

a = vec3{
	x = 100,
	y = 20,
	z = 70
}

a.x = 64
print(a.x, a.y, a.z)
```

## How to Use:
```Lua
local struct = require 'struct' -- This library returns a function that generates a struct
local <STRUCT VAR> = struct("<STRUCT NAME>", { -- Defines a new struct
	{<NEW PROPERTY(IES) VAR NAME>, type = <NEW PROPERTY C TYPE>}, -- Defines a new property
	<...>                                            -- Etc.
})

local <"INSTANCE" VAR> = <STRUCT VAR>{ -- "Instanciates" a existing C struct
	<EXISTING PROPERTY VAR NAME> = <VALUE>, -- Defines value of existing property
	<...>                                   -- Etc.
}
```

## Requirements:
LuaFFI and Lua5.1+ (LuaJIT 2+)

## How to Install:
- Download the "`struct.lua`" file and add it into your project.
- Require it
- Done!

## License:
	LuaStruct: A little LuaFFI wrapper for making structs

	ZLIB License. Copyright (c) Nelson "darltrash" Lopez

	This software is provided 'as-is', without any express or implied warranty. In no event will
	the authors be held liable for any damages arising from the use of this software.
	Permission is granted to anyone to use this software for any purpose, including
	commercial applications, and to alter it and redistribute it freely, subject to the following
	restrictions:

	1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
	2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
	3. This notice may not be removed or altered from any source distribution.
