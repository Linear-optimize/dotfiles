local wezterm = require 'wezterm'
local c = {}
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

if wezterm.config_builder then
    c = wezterm.config_builder()
end

bar.apply_to_config(c)

c.color_scheme = 'Catppuccin Macchiato'
c.font = wezterm.font('Maple Mono Normal NF CN', {weight = 800, italic = false})
c.font_size = 14

c.background = {
    {
        source = {File = "E:/video/walls/anime/a_cartoon_of_a_girl_with_pigtails.png"},
        height = '100%',
        width = '100%',
    },
    {
        source = {Color = '#0c0c11'},
        opacity = 0.77,
        height = '100%',
        width = '100%',
    },
}

c.window_decorations = "RESIZE"
c.default_prog = {"D:/rust/.cargo/bin/nu.exe"}

return c