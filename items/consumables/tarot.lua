SMODS.Atlas({
    key = "moretarots", 
    path = "MoreTarots.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})
--星币首牌
SMODS.Consumable {
    key = 'aopentacles',
    set = 'Tarot',
    atlas = 'moretarots',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_mj_gear' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
   }