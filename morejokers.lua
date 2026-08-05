local mj_config = SMODS.current_mod.config or {}
SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 32,
    py = 32,
    atlas_table = "ASSET_ATLAS"
})
SMODS.Atlas({
    key = "morejokers", 
    path = "MoreJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})
SMODS.Atlas({
    key = "blinds", 
    path = "blinds.png", 
    px = 34,
    py = 34, 
    atlas_table = "ANIMATION_ATLAS",
    frames = 21
})
SMODS.Atlas({
    key = "morespectral", 
    path = "MoreSpectral.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})
SMODS.Atlas({
    key = "morede", 
    path = "morede.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})
SMODS.Atlas({
    key = "finger_doctor", 
    path = "finger doctor.png", 
    px = 71,
    py = 95, 
    atlas_table = "ANIMATION_ATLAS",
    frames = 3
})
SMODS.Sound({
      key = "ascend",
      path = "ascend.ogg"
})
SMODS.Sound({
      key = "kachan",
      path = "ka-chan.wav"
})
SMODS.Sound({
      key = "loopingrooms",
      path = "loopingrooms.ogg"
})
assert(SMODS.load_file("items/jokers/common_jokers.lua"))()
assert(SMODS.load_file("items/jokers/uncommon_jokers.lua"))()
assert(SMODS.load_file("items/jokers/rare_jokers.lua"))()
assert(SMODS.load_file("items/jokers/legend_jokers.lua"))()
assert(SMODS.load_file("items/consumables/spectral.lua"))()
assert(SMODS.load_file("items/blinds.lua"))()
assert(SMODS.load_file("items/backs.lua"))()
assert(SMODS.load_file("items/challenges.lua"))()
assert(SMODS.load_file("items/stakes.lua"))()
assert(SMODS.load_file("items/sticker.lua"))()
assert(SMODS.load_file("items/enhancements.lua"))()
assert(SMODS.load_file("items/consumables/tarot.lua"))()
assert(SMODS.load_file("backrooms.lua"))()
SMODS.current_mod.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2, shadow = true }
end
SMODS.current_mod.menu_cards = function()
	return {
		{ key = 'c_mj_ascend' },
	}
end
SMODS.current_mod.config_tab = function()
	mj_nodes = {
		{
			n = G.UIT.R,
			config = { align = "cm" },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = localize("mj_set_music"),
							colours = { G.C.WHITE },
							shadow = true,
							scale = 0.6,
						}),
					},
				},
			},
		},
	}
	settings = { n = G.UIT.C, config = { align = "tm", padding = 0 }, nodes = {} }
	settings.nodes[#settings.nodes + 1] = create_toggle({
		active_colour = G.C.RED,
		label = localize("mj_m_0"),
		ref_table = mj_config.mj,
		ref_value = "level0_music",
	})
	settings.nodes[#settings.nodes + 1] = create_toggle({
		active_colour = G.C.RED,
		label = localize("mj_m_invert"),
		ref_table = mj_config.mj,
		ref_value = "trevni_cisum",
	})
	settings.nodes[#settings.nodes + 1] = create_toggle({
		active_colour = G.C.RED,
		label = localize("mj_m_matrix"),
		ref_table = mj_config.mj,
		ref_value = "matrix",
	})
	config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
	mj_nodes[#mj_nodes + 1] = config
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = mj_nodes,
	}
end
SMODS.current_mod.extra_tabs = function()
	return {
        {
            label = localize('k_mj_about'),
            tab_definition_function = function()
                local modNodes = {}
                modNodes[#modNodes + 1] = {}
                local loc_vars = { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1 }
                localize { type = 'descriptions', key = 'About', set = 'Mod', nodes = modNodes[#modNodes], vars = loc_vars.vars, scale = loc_vars.scale, text_colour = loc_vars.text_colour, shadow = loc_vars.shadow }
                modNodes[#modNodes] = desc_from_rows(modNodes[#modNodes])
                modNodes[#modNodes].config.colour = loc_vars.background_colour or modNodes[#modNodes].config.colour
                return {
                    n = G.UIT.ROOT,
                    config = {
                        emboss = 0.05,
                        minh = 6,
                        r = 0.1,
                        minw = 6,
                        align = "tm",
                        padding = 0.2,
                        colour = G.C.BLACK
                    },
                    nodes = modNodes
                }
            end
        }
    }
end