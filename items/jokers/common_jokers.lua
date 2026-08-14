--卡文迪什重做
SMODS.Joker:take_ownership ('cavendish', {
    loc_vars = function(self, info_queue)
        return { key = 'j_mj_cavendish' }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'mj_cavendish', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.cavendish_extinct = true
                return {
                    message = localize('k_extinct_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,
    in_pool = function(self, args)
        return G.GAME.pool_flags.gros_michel_extinct
    end
})
--香蕉王
SMODS.Joker {
	key = 'banana_king',
	blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
	yes_pool_flag = 'cavendish_extinct',
	config = { extra = { Xmult = 1000, odds = 10000 } },
	rarity = 1,
	atlas = 'morejokers',
	pos = { x = 1, y = 1 },
	cost = 4,
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = false,
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'banana_king')
		return { vars = { card.ability.extra.Xmult, numerator, denominator } }
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and not context.repetition and not context.blueprint then
			if SMODS.pseudorandom_probability(card, 'banana_king', 1, card.ability.extra.odds) then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = localize('k_extinct_ex')
				}
			else
				return {
					message = localize('k_safe_ex')
				}
			end
		end
	if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		end
	end,
    in_pool = function(self, args)
        return G.GAME.pool_flags.cavendish_extinct
    end
}
--迷宫
SMODS.Joker {
    key = "labyrinth",
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 1,
    atlas = 'morejokers',
    cost = 5,
    pos = { x = 3, y = 1 },
    config = { extra = { xmult = 1, xmult_gain = 0.3 } },
      loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            return {
                message = localize('k_upgrade_ex')
            }
        end
       if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
--小丑模板
SMODS.Joker {
    key = "very_joker",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,  
    rarity = 1,
    atlas = 'morejokers',
    cost = 6,
    pos = { x = 8, y = 1 },
    pixel_size = { h = 95 * 0.66, w = 71 * 0.6 },
    config = { extra = { creates = 1, odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'very_joker')
        return { vars = { numerator, denominator } }
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.creates } }
    end,
    calculate = function(self, card, context)
       if #G.jokers.cards == 1 then
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(card.ability.extra.creates,
                G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function()
                    for _ = 1, jokers_to_create do
                  if SMODS.pseudorandom_probability(card, 'very_joker', 2, card.ability.extra.odds) then
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Uncommon',
                            play_sound('tarot1'),
                        }
                        else
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'Rare',
                            play_sound('tarot1'),
                        }
                     end
                     return true
                 end
              end
           }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end
    end
 end
}
--馒头
SMODS.Joker {
    key = "steamed_bun",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = false,
    rarity = 1,
    atlas = 'morejokers',
    cost = 4,
    pos = { x = 4, y = 2 },
    config = { extra = { odds = 3, hands = 1 } },
    no_pool_flag = 'steamed_bun_extinct',
        loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'steamed_bun')
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.d_size, card.ability.extra.hands, numerator, denominator } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'steamed_bun', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.steamed_bun_extinct = true
                return {
                   message = localize('k_eaten_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end
  }     
--包子
SMODS.Joker {
    key = "steamed_stuffed",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = false,
    rarity = 1,
    atlas = 'morejokers',
    cost = 5,
    pos = { x = 0, y = 3 },
    config = { extra = { odds = 3, d_size = 1 } },
    yes_pool_flag = 'steamed_bun_extinct',
    no_pool_flag = 'steamed_stuffed_extinct',
        loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'steamed_bun')
        return { vars = { card.ability.extra.d_size, numerator, denominator } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
        ease_discard(card.ability.extra.d_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'steamed_stuffed', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.steamed_stuffed_extinct = true
                return {
                    message = localize('k_eaten_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end
  }
--饺子
SMODS.Joker {
    key = "dumplings",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = false,
    rarity = 1,
    atlas = 'morejokers',
    cost = 6,
    pos = { x = 1, y = 3 },
    config = { extra = { odds = 100, d_size = 2, hands = 1 } },
    yes_pool_flag = 'steamed_stuffed_extinct',
        loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'steamed_bun')
        return { vars = { card.ability.extra.d_size, card.ability.extra.hands, numerator, denominator } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
        ease_discard(card.ability.extra.d_size)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'dumplings', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
    end
   }
--幸运四叶草
SMODS.Joker {
    key = "accident",
    config = { extra = { odds = 2 } },
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 1,
    atlas = 'morejokers',
    cost = 4,
    pos = { x = 6, y = 2 },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'j_accident' .. G.GAME.round_resets.ante)
            info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.ability.set == "Tarot" and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, 'accident' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
                            key = 'c_wheel_of_fortune'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_mj_wheel'),
                    colour = G.C.PURPLE
                }
            end
        end
    end
}
--复古小丑
SMODS.Joker {
    key = "retro",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 1,
    atlas = 'morejokers',
    cost = 4,
    pos = { x = 7, y = 2 },
    config = { extra = { chips = 15 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips * (G.jokers and #G.jokers.cards or 0) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * #G.jokers.cards,
                chip_message = {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
					colour = G.C.CHIPS
				}
            }
        end
    end,
}
--蓝牌
SMODS.Joker {
    key = "blue_card",
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'morejokers',
    pos = { x = 1, y = 4 },
    config = { extra = { chips_mod = 15, chips = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_mod, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.skipping_booster and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                message = localize { type = 'variable', key = 'a_chips_mod', vars = { card.ability.extra.chips_mod } },
                colour = G.C.BLUE,
                delay = 0.45
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                chip_message = {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
					colour = G.C.CHIPS
				}
            }
        end
    end,
}
--正常小丑
SMODS.Joker {
    key = "normal",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 1,
    atlas = 'morejokers',
    cost = 4,
    pos = { x = 7, y = 0 },
    config = { extra = { Xmult = 3, Xchips = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xchips } }
    end,
    in_pool = function()
        return false
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult,
                xchips = card.ability.extra.Xchips
            }
        end
    end,
}
--杏仁水
SMODS.Joker {
    key = "almond_water",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = false,
    rarity = 1,
    atlas = 'morejokers',
    cost = 4,
    pos = { x = 5, y = 2 },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.j_madness
    info_queue[#info_queue + 1] = G.P_CENTERS.j_mj_paranoia
    info_queue[#info_queue + 1] = G.P_CENTERS.j_mj_normal
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
     if context.ending_shop and not context.individual and not context.repetition and not context.blueprint and next(SMODS.find_card('j_madness')) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local nor = SMODS.find_card('j_madness')[1]
                        nor:set_ability(G.P_CENTERS['j_mj_normal'])
                        nor:juice_up(0.8, 0.8)
                        return true;
                    end
                }))
             return {
                    SMODS.destroy_cards(card, nil, nil, true),
                    message = localize('k_drank_ex')
                }
            end
            if context.ending_shop and not context.individual and not context.repetition and not context.blueprint and next(SMODS.find_card('j_mj_paranoia')) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local norm = SMODS.find_card('j_mj_paranoia')[1]
                        norm:set_ability(G.P_CENTERS['j_mj_normal'])
                        norm:juice_up(0.8, 0.8)
                        return true;
                    end
                }))
             return {
                    SMODS.destroy_cards(card, nil, nil, true),
                    message = localize('k_drank_ex')
                }
            end
        end,
    in_pool = function(self, args)
        return next(SMODS.find_card('j_madness')) or next(SMODS.find_card('j_mj_paranoia'))
    end
}
--同质化
SMODS.Joker {
    key = "homogenization",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 1,
    atlas = 'morejokers',
    cost = 5,
    pos = { x = 3, y = 5 },
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}

local card_set_cost_value_ref = Card.set_cost_value
function Card:set_cost_value()
    card_set_cost_value_ref(self)
    if next(SMODS.find_card("j_mj_homogenization")) then
        if (self.ability.set == 'Joker' or (self.ability.set == 'Booster' )) then self.cost = 5 end
    end
end
--老花眼
SMODS.Joker {
    key = "presbyopia",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 1,
    atlas = 'morejokers',
    cost = 6,
    pos = { x = 8, y = 5 },
    calculate = function(self, card, context)
    if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
    local faces = false
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_face() then
                    faces = true
                    break
                end
            end
            if faces then
            local enhancement = SMODS.poll_enhancement { guaranteed = true, options = cen_pool, key = "mj_presbyopia_card" }
            for k, v in pairs(context.scoring_hand) do
                v:set_ability(enhancement, true)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
            end
            return {
                message = localize('k_mj_enhancement'),
                colour = G.C.FILTER,
                card = card
                }
            end
        end
    end
}