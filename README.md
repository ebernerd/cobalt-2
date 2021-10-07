![](https://i.imgur.com/wZFbuS0.png)
# Cobalt 2
## [Documentation](https://eric99b.gitbook.io/cobalt2) | [Discord](https://discord.gg/ZdhMJJ5) | [Releases](https://github.com/ebernerd/cobalt-2/releases)
Cobalt 2 is a callback wrapper for ComputerCraft, and is the successor to [Cobalt](https://github.com/ebernerd/cobalt).

Cobalt 2 offers new features, improves (heavily) on existing functionality, and aims to remove bloat from Cobalt 1. I must admit when I developed the original Cobalt 3 years ago, I was rushed and was more focussed on the UI engine over the wrapper itself.

I have built/tested this on CraftOS v1.7+

## Getting Started
[*Read full section*](https://eric99b.gitbook.io/cobalt2/getting-started)  
Clone the Github repo into your desired destination folder. Alternatively, you can use the Releases and download the entire repo as a zip. Extract (and ideally, rename) that folder to where you'd like. The default is `/cobalt`. If you wish to install it elsewhere, ensure to update the path in the configuration file.

### Hello World Program
```lua
local cobalt = dofile("/cobalt/init.lua")

function cobalt.draw()
    cobalt.graphics.print("Hello world!", 2, 1)
end

-- Start Cobalt's cycle
cobalt.init()
```
