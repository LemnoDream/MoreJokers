SMODS.Sticker {
    key = "destroies",
    atlas = "sticker",
    pos = { x = 1, y = 0 },
    badge_colour = HEX("6b3c85ff"),
    sets = { Joker = true },
    needs_enable_flag = true,
    should_apply = function(self, card, center, area, bypass_roll)
        return (area == G.pack_cards or area == G.shop_jokers) and card.ability.set == "Joker" and pseudorandom(pseudoseed("destroies"..G.GAME.round_resets.ante)) < 0.15 and G.GAME.modifiers.enable_mj_destroies_in_shop
    end,
    loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal }, }
	end,
	calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
    if pseudorandom("destroies") < G.GAME.probabilities.normal / 5 then
        local rr = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					rr = i
					break
				end
			end
			local lc = { "left", "right" }
			local choosencard = pseudorandom_element(lc, pseudoseed("destroies"))
	        if rr then
			if choosencard == "left" and G.jokers.cards[rr - 1] ~= nil then
				G.jokers.cards[rr - 1]:start_dissolve({ HEX("ff0000ff") }, nil, 1)
				return {
                    message = localize('k_mj_destroies_ex')
                }
			elseif choosencard == "right" and G.jokers.cards[rr + 1] ~= nil then
				G.jokers.cards[rr + 1]:start_dissolve({ HEX("ff0000ff") }, nil, 1)
			return {
                    message = localize('k_mj_destroies_ex')
                    }
                end
            end
	    end
    end
end
}