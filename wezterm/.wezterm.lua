-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.font = wezterm.font("Jet Brains Mono Nerd Font")
config.font_size = 15.0
config.color_scheme = "carbonfox"
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
