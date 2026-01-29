# Reborn Esp Library
- This is an esp library i made using billboardguis (mostly for gradienting)
- Probably has detection issues (no coregui)
- Will get improved in time.

# Define the main library
```lua
local RebornLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/priestwillbe/reborn-esp-library/refs/heads/main/main.lua"))()
```

# Create Box ESP
```lua
RebornLib:CreateBoxEsp(player, Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 0, 0))
```

# Create Health Bar
```lua
RebornLib:CreateHealthBar(player, Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 0, 0))
```
# Create Name
```lua
RebornLib:CreateNameEsp(player)
```


Currently doesn't have an option to destroy the esp elements cuz im lazy (which means this is untoggleable)
