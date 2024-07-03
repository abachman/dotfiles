-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.color_scheme = 'AdventureTime'
config.font = wezterm.font 'Monaspace Krypton Var'
config.font_size = 14.0


-- and finally, return the configuration to wezterm
return config
