--齿轮
SMODS.Enhancement {
    key = 'gear',
    atlas = 'morede',
    order = 4,
    pos = { x = 0, y = 0 },
    config = { h_x_chips = 1, extra = { h_x_chips_base = 1, h_x_chips_mod = 0.15, } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_chips, card.ability.extra.h_x_chips_mod, card.ability.extra.h_x_chips_base } }
    end,
    update = function(self, card, dt)
        if G.hand and G.hand.cards then
            local cards = {}
            for k, v in pairs(G.hand.cards) do
                if SMODS.get_enhancements(G.hand.cards[k]).m_mj_gear then
                    cards[#cards+1] = v
                end
            end
            if #cards - 1 >= 0 then
                card.ability.h_x_chips = card.ability.extra.h_x_chips_base + (card.ability.extra.h_x_chips_mod * (#cards))
            end
        end
    end
   }