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
    key = "moretarots", 
    path = "MoreTarots.png", 
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
SMODS.current_mod.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2, shadow = true }
end
SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = localize('k_mj_about'),
            tab_definition_function = function()
                local modNodes = {}
                modNodes[#modNodes + 1] = {}
                local loc_vars = { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.4 }
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