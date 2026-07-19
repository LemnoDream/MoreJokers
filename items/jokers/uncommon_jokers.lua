--迈达斯小丑
SMODS.Joker {
   key = 'midas_joker',
   blueprint_compat = false,
   perishable_compat = false,
   eternal_compat = true,
   config = { extra = { dollars = 1 } },
   rarity = 2,
   atlas = 'morejokers',
	pos = { x = 1, y = 0 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		local gold_tally = 0
		if G.playing_cards then
		for _, playing_card in ipairs(G.playing_cards) do
		if SMODS.has_enhancement(playing_card, 'm_gold') then gold_tally = gold_tally + 1 end
		end
	end
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars * gold_tally } }
    end,
        calc_dollar_bonus = function(self, card)
        local gold_tally = 0
        for _, playing_card in ipairs(G.playing_cards) do
        if SMODS.has_enhancement(playing_card, 'm_gold') then gold_tally = gold_tally + 1 end
        end
        return gold_tally > 0 and card.ability.extra.dollars * gold_tally or nil
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_gold') then
                return true
            end
        end
        return false
    end
}
--后悔药
SMODS.Joker {
    key = "regret_med",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 6,
    pos = { x = 5, y = 0 },
    config = { extra = { Xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		end
        if context.setting_blind then
            ease_discard(-G.GAME.current_round.discards_left, nil, true)
            return {
                    message = localize('k_mj_regret_ex')
            }
        end
    end
}
--暴躁小丑
SMODS.Joker {
    key = "irritable_joker",
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 8, y = 0 },
    config = { extra = { Xmult = 1, Xmult_gain = 0.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, card.ability.extra.Xmult + math.max(0, card.ability.extra.Xmult_gain * (G.playing_cards and (G.GAME.starting_deck_size - #G.playing_cards) or 0)), G.GAME.starting_deck_size } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult + math.max(0, card.ability.extra.Xmult_gain * (G.GAME.starting_deck_size - #G.playing_cards))
            }
        end
    end
}
--会员卡
SMODS.Joker {
    key = "vip_card",
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 9, y = 0 },
    config = { extra = { Xmult = 1, Xmult_gain = 0.5, dollars = 25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.dollars, card.ability.extra.Xmult + card.ability.extra.Xmult_gain * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.extra.dollars)
            }
        end
    end
  }
--全家桶
SMODS.Joker {
    key = "all_in_one",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = false,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 7, y = 1 },
    config = { extra = { odds = 8, mult = 10, chips = 80, d_size = 1, hands = 1 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'all_in_one')
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.d_size, card.ability.extra.hands, numerator, denominator } }
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
            if SMODS.pseudorandom_probability(card, 'all_in_one', 1, card.ability.extra.odds) then
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
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
               }
           end
       end
      }
--万能+4
SMODS.Joker {
   key = 'wild_4',
   blueprint_compat = true,
   perishable_compat = false,
   eternal_compat = true,
   config = { extra = { mult = 4 } },
   rarity = 2,
   atlas = 'morejokers',
	pos = { x = 2, y = 1 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		
		local wild_tally = 0
		if G.playing_cards then
		for _, playing_card in ipairs(G.playing_cards) do
		if SMODS.has_enhancement(playing_card, 'm_wild') then wild_tally = wild_tally + 1 end
		end
	end
	return { vars = {card.ability.extra.mult, card.ability.extra.mult * wild_tally } }
end,
        calculate = function(self, card, context)
        if context.joker_main then
            local wild_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_wild') then wild_tally = wild_tally + 1 end
            end
            return {
                mult = card.ability.extra.mult * wild_tally,
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end
}
--安卡
SMODS.Joker {
    key = "anka",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = false,
    rarity = 2,
    atlas = 'morejokers',
    cost = 5,
    pos = { x = 0, y = 2 },
    config = { extra = { hands = 2 } },
    calculate = function(self, card, context)
    if context.after and not context.blueprint and G.GAME.current_round.hands_left == 0 then
        SMODS.destroy_cards(card, nil, nil, true)
        ease_hands_played(card.ability.extra.hands)
                return {
                    message = localize('k_mj_continue_ex')
                }
            end
        end
     }
--小筹
SMODS.Joker {
   key = 'jochips',
   blueprint_compat = true,
   perishable_compat = false,
   eternal_compat = true,
   config = { extra = { chips = 0, chips_mod = 5, chips_gain = 0 } },
   rarity = 2,
   atlas = 'morejokers',
	pos = { x = 9, y = 1 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
		
		local bonus_tally = 0
		if G.playing_cards then
		for _, playing_card in ipairs(G.playing_cards) do
		if SMODS.has_enhancement(playing_card, 'm_bonus') then bonus_tally = bonus_tally + 1 end
		end
	end
	return { vars = {card.ability.extra.chips, card.ability.extra.chips_mod, card.ability.extra.chips_gain, card.ability.extra.chips_mod * bonus_tally, card.ability.extra.chips_gain + (card.ability.extra.chips_mod * bonus_tally) } }
end,
        calculate = function(self, card, context)
            local bonus_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_bonus') then bonus_tally = bonus_tally + 1 end
            end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain + card.ability.extra.chips_mod * bonus_tally
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_bonus') then
                return true
            end
        end
        return false
    end
}
--怀表
SMODS.Joker {
    key = "watch",
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 1, y = 2 },
    config = { extra = { chips_mod = 0.2, chips = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod, card.ability.extra.chips * G.GAME.round } }
    end,
    calculate = function(self, card, context)
    if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Planet' or
      context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Tarot' or
      context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Spectral' then
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
      return {
              message = localize { type = 'variable', key = 'a_chips_mod', vars = { card.ability.extra.chips_mod } },
              colour = G.C.BLUE
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * G.GAME.round
            }
        end
    end
}
--事不过三
SMODS.Joker {
    key = "every_three",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 4, y = 3 },
    config = { extra = { Xmult = 1, Xmult_gain = 0.3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult, } }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
        if card.ability.extra.Xmult + card.ability.extra.Xmult_gain > 3 then
            card.ability.extra.Xmult = 1
                return {
                    message = localize('k_reset')
                }
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult_gain } },
                    colour = G.C.RED,
                    delay = 0.2
                }
            end
        end
            if context.joker_main then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
     }
--三日凌空
SMODS.Joker {
    key = "three_sun",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 5, y = 3 },
    config = { extra = { mult = 2, chips = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
            if context.joker_main then
            local text = G.FUNCS.get_poker_hand_info(G.play.cards)
            if text and G.GAME.hands[text] then
                return {
                    mult = card.ability.extra.mult * G.GAME.hands[text].level,
                    chips = card.ability.extra.chips * G.GAME.hands[text].level
                }
            end
        end
    end
}
--金苹果
SMODS.Joker {
    key = "golden_apple",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'morejokers',
    pos = { x = 2, y = 3 },
    config = { extra = { mult = 0, chips = 0, chips_mod = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.chips_mod } }
    end,
    calculate = function(self, card, context)
    local reset = false
       if context.after and not context.blueprint then
        reset = true
    end
        if reset then
        if card.ability.extra.mult > 1 and card.ability.extra.chips > 1 then
        card.ability.extra.mult = 0 
        card.ability.extra.chips = 0
            return {
                    message = localize('k_reset')
            }
        end
    else
        if context.discard and not context.blueprint then
        card.ability.extra.mult = card.ability.extra.mult + 3
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                    delay = 0.2
                }
            end
        end
        if context.joker_main then
        return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
   end
}
--白昼
SMODS.Joker {
    key = "come",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'morejokers',
    pos = { x = 8, y = 3 },
    config = { extra = { Xmult = 4 } },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.j_mj_go
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
    if context.after and not context.blueprint then
        G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                    card:set_ability('j_mj_go')
                    card:juice_up(0.8, 0.8)
                    play_sound('tarot1')
                    return true;
                end
            }))
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
--黑夜
SMODS.Joker {
    key = "go",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'morejokers',
    pos = { x = 9, y = 3 },
    config = { extra = { Xmult = 0.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
    if context.after and not context.blueprint then
        G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                    card:set_ability('j_mj_come')
                    card:juice_up(0.8, 0.8)
                    play_sound('tarot1')
                    return true;
                end
            }))
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
--口香糖
SMODS.Joker {
    key = "gum",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'morejokers',
    pos = { x = 0, y = 4 },
    config = { extra = { dollars = 6, odds = 6 } },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.ml_eternal
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'gum')
        return { vars = { card.ability.extra.dollars, numerator, denominator } }
    end,
    calc_dollar_bonus = function(self, card)
         return card.ability.extra.dollars
     end,
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
    local available_cards = {}
        for _, v in ipairs(G.jokers.cards) do
            if v.config.center.eternal_compat and not SMODS.is_eternal(v, card) and not v.ability.perishable then 
                available_cards[#available_cards+1] = v 
            end
        end
        if SMODS.pseudorandom_probability(card, 'gum', 1, card.ability.extra.odds) then
           SMODS.destroy_cards(card, nil, nil, true)
           if #available_cards > 0 then
            local selected_card = pseudorandom_element(available_cards, pseudoseed("mj"))
            selected_card:set_eternal(true)
            selected_card:juice_up()
            play_sound("gold_seal", 1.2, 0.7)
			return {
				    message = localize('k_mj_stick_ex')
				}
			end
	    else
			return {
					message = localize('k_safe_ex')
				}
		    end
		end
	end
}
--偏执
SMODS.Joker {
    key = "paranoia",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 3, y = 4 },
    config = { extra = { Xmult = 3, Xmult_loss = 1 } },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.j_madness
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_loss } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local reset = false
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for handname, values in pairs(G.GAME.hands) do
                if handname ~= context.scoring_name and values.played >= play_more_than and SMODS.is_poker_hand_visible(handname) then
                    reset = true
                    break
                end
            end
        if card.ability.extra.Xmult - card.ability.extra.Xmult_loss <= 1 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        card:set_ability('j_madness')
                        card:juice_up(0.8, 0.8)
                        return true
                    end
                }))
                return {
                    message = localize('k_mj_crazy_ex')
                }
            else
        if reset then
        card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_loss
                return {
                    ease_dollars(-G.GAME.dollars, true),
                    message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.Xmult_loss } },
                    colour = G.C.RED,
                    delay = 0.2
                }
            end
        end
    end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
                }
            end
        end
    }
--方块小丑
SMODS.Joker {
    key = "cube",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 6,
    pos = { x = 2, y = 4 },
    pixel_size = { h = 71 },
    config = { extra = { Xmult = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand then
            local rank_sum = 0
            for _, scoring_card in ipairs(context.scoring_hand) do
                local rank_value = scoring_card:get_id()
                if rank_value > 0 then
                    rank_sum = rank_sum + rank_value
                end
            end
            if rank_sum == 16 then
            return {
                Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}
--点石成金
SMODS.Joker {
    key = "rock_gold",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 6,
    pos = { x = 5, y = 4 },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local stone = false
        if context.scoring_hand and #context.scoring_hand > 0 then
          for k, v in ipairs(context.scoring_hand) do
            if v.config.center == G.P_CENTERS.m_stone and not v.debuff then
                    v:set_ability(G.P_CENTERS.m_gold, nil, true)
                    stone = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                        if v and not v.removed then
                           v:juice_up()
                        end
                            return true
                        end
                    }))
                end
            end
        end
            if stone then
                return {
                    message = localize('k_gold'),
                    colour = G.C.MONEY
                }
            end
        end
    end
}
--命运之丑
SMODS.Joker {
    key = "joker_of_fortune",
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 6, y = 4 },
    config = { extra = { Xmult = 1.75, Xmult_gain = 0.75, Xmult_loss = 0.1 } },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, card.ability.extra.Xmult_loss } }
    end,
    calculate = function(self, card, context)
    if context.pseudorandom_result and context.result and context.identifier == 'wheel_of_fortune' and not context.blueprint then
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
        return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult_gain } },
                colour = G.C.RED
        }
    else
    if card.ability.extra.Xmult > 1 and context.pseudorandom_result and not context.result and context.identifier == 'wheel_of_fortune' then 
        card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_loss
        return {
                message = localize { type = 'variable', key = 'a_xmult_minus', vars = { card.ability.extra.Xmult_loss } }
                }
            end
        end
    if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
                }
            end
        end
    }
--回收利用
SMODS.Joker {
    key = "recycle",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 6, y = 0 },
    config = { extra = { dollars = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
    if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Planet' or
      context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Tarot' or
      context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Spectral' then
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            return {
                dollars = card.ability.extra.dollars,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}
--无忧旋律
SMODS.Joker {
    key = "carefree_melody",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 7, y = 4 },
    config = { extra = { odds = 7, odds_mod = 0, hands = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, card.ability.extra.odds_mod, card.ability.extra.hands } }
    end,
    calculate = function(self, card, context)
    if context.before and not context.blueprint then
    if SMODS.pseudorandom_probability(card, 'mj_carefree_melody', card.ability.extra.odds_mod, card.ability.extra.odds) then
     card.ability.extra.odds_mod = 0
     ease_hands_played(card.ability.extra.hands)
                return {
                    message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } }
                }
            else
            card.ability.extra.odds_mod = card.ability.extra.odds_mod + 1
            return {
                    message = localize('k_mj_probability_increase_ex'),
                    colour = G.C.BULE
                }
            end
        end
    end
 }
--棒球
SMODS.Joker {
    key = "baseba",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'morejokers',
    pos = { x = 6, y = 3 },
    config = { extra = { chips = 30, Xchips = 1.5 } },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.j_baseball
        return { vars = { card.ability.extra.Xchips, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") and next(SMODS.find_card('j_baseball')) then
            return {
                xchips = card.ability.extra.Xchips
            }
    end
        if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") and not next(SMODS.find_card('j_baseball')) then
            return {
                 chips = card.ability.extra.chips
            }
        end
    end        
}
--发令
SMODS.Joker {
    key = "issue_order",
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    atlas = 'morejokers',
    cost = 6,
    pos = { x = 7, y = 3 },
    calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.end_of_round and G.GAME.current_round.discards_used == 0 then
    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Spectral',
                            key_append = 'mj_issue_order'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end
}
--亡命之徒
SMODS.Joker {
	key = 'desperado',
	blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
	config = { extra = { Xmult = 4 } },
	rarity = 2,
	atlas = 'morejokers',
	pos = { x = 3, y = 0 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult
			}
		end
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                        G.GAME.current_round.hands_left = 1
                    return true
                end
             }))
            return {
                    message = localize('k_mj_last'),
                    colour = G.C.BLUE
                }
        end
    end
}