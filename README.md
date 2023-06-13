```
                              _/   
     _/_/_/  _/_/_/      _/_/_/    
  _/_/      _/    _/  _/    _/     
     _/_/  _/    _/  _/    _/      
_/_/_/    _/    _/    _/_/_/        

<C-e> to start a snd job from a scheme file.
vim.g.snd_keymaps = {exec='<C-e>'}
vim.g.snd_filetypes = {"*.scm"--[[ , "*.forth", "*.fth", "*.4th", "*.frt", "*.rb" ]]}
```
```lua
return {
    "salkin-mada/snd.nvim",
    enabled = true,
    config = function()
        require('snd')
    end
}
```
