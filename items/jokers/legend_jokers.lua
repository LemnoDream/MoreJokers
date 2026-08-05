--萨默斯
SMODS.Joker {
    key = "sommers",
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = false,
    rarity = 4,
    atlas = 'morejokers',
    cost = 20,
    pos = { x = 4, y = 1 },
    soul_pos = { x = 5, y = 1 },
    config = { extra = { Xmult = 1, Xmult_mod = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Spectral' then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
            }
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
--金宝
SMODS.Joker {
    key = "jimbo",
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = false,
    rarity = 4,
    atlas = 'morejokers',
    cost = 20,
    pos = { x = 2, y = 2 },
    soul_pos = { x = 3, y = 2 },
    config = { extra = { Xmult = 1, Xmult_gain = 1, every = 3, loyalty_remaining = 3 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult_gain,
                card.ability.extra.Xmult,
                card.ability.extra.every + 1,
                localize { type = 'variable', key = (card.ability.extra.loyalty_remaining == 0 and 'loyalty_active' or 'loyalty_inactive'), vars = { card.ability.extra.loyalty_remaining } }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.loyalty_remaining = (card.ability.extra.every - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) %
                (card.ability.extra.every + 1)
            if not context.blueprint then
                if card.ability.extra.loyalty_remaining == 0 then
                    local eval = function(card) return card.ability.extra.loyalty_remaining == 0 and not G.RESET_JIGGLES end
                    juice_card_until(card, eval, true)
                end
                if context.before and card.ability.extra.loyalty_remaining == card.ability.extra.every then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                    return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                    }
                end
            end
        end
            if context.joker_main then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
    }
--基金会
SMODS.Joker {
    key = "foundation",
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = false,
    rarity = 4,
    atlas = 'morejokers',
    cost = 20,
    pos = { x = 2, y = 6 },
    soul_pos = { x = 3, y = 6 },
    config = { extra = { Xmult = 1, Xmult_gain = 1, odds = 3 } },
    loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'foundation')
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, numerator, denominator } }
	end,
	calculate = function(self, card, context)
    if context.setting_blind and not card.getting_sliced or context.end_of_round and context.game_over == false and not card.getting_sliced then
            local my_ra = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_ra = i; break end
            end
            if not my_ra then return end
            local left_card = G.jokers.cards[my_ra - 1]
            local right_card = G.jokers.cards[my_ra + 1]
    if SMODS.pseudorandom_probability(card, 'foundation', 1, card.ability.extra.odds) then
    if left_card and not left_card.ability.eternal then
        G.E_MANAGER:add_event(Event({
            func = function()
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                left_card.getting_sliced = true
                SMODS.destroy_cards({left_card}, nil, true)
                play_sound('slice1', 0.96, 0.65)
                card:juice_up(0.5, 0.5)
                return true
            end
          }))
            return {
                message = localize('k_mj_destroies_ex'),
                colour = G.C.RED
            }
        end
    end
end
        if context.joker_main then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
    }