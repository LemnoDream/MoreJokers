--太阳系
SMODS.Joker {
    key = "solar_system",
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
    rarity = 3,
    atlas = 'morejokers',
    cost = 8,
    pos = { x = 3, y = 3 },
    config = { extra = { dollars = 0, dollars_gain = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_gain } }
    end,
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
        if card.ability.extra.dollars + card.ability.extra.dollars_gain >= 100 then
         SMODS.destroy_cards(card, nil, nil, true)
               return {
                    message = localize('k_mj_destroy_ex'),
                    colour = G.C.RED,
                }
            else
         card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_gain
                return {
                    message = '+5$',
                    colour = G.C.MONEY
                }
            end
        else
        if context.joker_main and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if G.GAME.dollars >= card.ability.extra.dollars then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                func = function()
                    if G.GAME.last_hand_played then
                        local _planet = 0
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == G.GAME.last_hand_played then
                                _planet = v.key
                            end
                        end
                        SMODS.add_card({ key = _planet })
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end
            }))
                return {
                    message = localize('k_plus_planet'),
                    colour = G.C.SECONDARY_SET.Planet
                }
                end
            end
        end
    end
}
--金字塔
SMODS.Joker {
    key = "pyramid",
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 8,
    pos = { x = 2, y = 0 },
    config = { extra = { Xmult_gain = 0.2, Xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult_gain, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
          if context.individual and context.cardarea == G.play and context.other_card:get_id() < 13 then
                if card.ability.extra.Xmult > 1 then
                card.ability.extra.Xmult = 1
                SMODS.calculate_effect({ message = localize('k_reset'), },
                context.blueprint_card or card)
                end
            else
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and not context.blueprint then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
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
--宽体小丑
SMODS.Joker {
    key = "width",
    blueprint_compat = false,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'morejokers',
    pos = { x = 6, y = 1 },
    display_size = { w = 71 * 2, h = 95 * 0.7 },
    config = { extra = { h_size = -4, slots = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots, card.ability.extra.h_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
        G.hand:change_size(-card.ability.extra.h_size)
    end,
   }
--漏印小丑
SMODS.Joker {
    key = "missed_print",
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 7,
    atlas = 'morejokers',
    pos = { x = 8, y = 2 },
    config = { extra = { max = 5, min = 1 } },
    loc_vars = function(self, info_queue, card)
        local r_Xmults = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_Xmults[#r_Xmults + 1] = tostring(i)
        end
        local loc_mult = ' ' .. (localize('k_mult')) .. ' '
        local main_start = {
            { n = G.UIT.T, config = { text = '  X', colour = G.C.XMULT, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_Xmults, colours = { G.C.RED }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'ifelse()', colour = G.C.ORANGE }, { string = 'M@&#()', colour = G.C.RED }, { string = 'J@&#()', colour = G.C.RED }, { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { main_start = main_start }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = pseudorandom('mj_missed_print', card.ability.extra.min, card.ability.extra.max)
            }
        end
    end
}
--手指医生
SMODS.Joker {
    key = "finger_doctor",
    blueprint_compat = false,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 7,
    atlas = 'finger_doctor',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    in_pool = function(self, args)
        for k, v in pairs(G.jokers.cards) do
            if v and v.ability then
                if v.ability.perishable or v.ability.mj_destroies then
                    return true
                end
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i; break end
            end
            if not my_pos then return end
            local right_card = G.jokers.cards[my_pos + 1]
            if right_card and right_card.ability.perishable then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mj_kachan')
                        right_card:juice_up(0.3, 0.5)
                        right_card:remove_sticker('perishable')
                        right_card:remove_sticker('mj_destroies')
                        return true
                    end
                }))
                return {
                    message = localize('k_mj_kachan_ex'),
                    colour = G.C.BLUE
                }
            end
            if right_card and right_card.ability.mj_destroies then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('mj_kachan')
                        right_card:juice_up(0.3, 0.5)
                        right_card:remove_sticker('perishable')
                        right_card:remove_sticker('mj_destroies')
                        return true
                    end
                }))
                return {
                    message = localize('k_mj_kachan_ex'),
                    colour = G.C.BLUE
                }
            end
        end
    end
}
--陨石
SMODS.Joker {
    key = "space_elevator",
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
    rarity = 3,
    atlas = 'morejokers',
    cost = 8,
    pos = { x = 4, y = 0 },
    config = { extra = { upgrade_level = 1, rounds_left = 12 } },
    loc_vars = function(self, info_queue, card)
        local extra = (card and card.ability and card.ability.extra) and card.ability.extra or self.config.extra
        return { vars = { extra.upgrade_level, card.ability.extra.rounds_left } }
    end,
    calculate = function(self, card, context)
    if context.before and G.GAME.current_round.hands_played == 0 then
        return {
           level_up = true,
           message = localize('k_upgrade_ex')
        }
    end
    if context.end_of_round and context.game_over == false and not context.repetition and not context.blueprint then
            if card.ability.extra.rounds_left - 1 <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_mj_high_crash_ex'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
                return {
                    message = card.ability.extra.rounds_left .. '',
                    colour = G.C.ORANGE
                    }
                end
            end
        end
    }
--孤者
SMODS.Joker {
    key = "alone",
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'morejokers',
    pos = { x = 0, y = 1 },
    config = { extra = { Xmult = 1, Xmult_gain = 0.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and context.scoring_name == 'High Card' then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        if context.joker_main and context.scoring_name == 'High Card' then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end
}
--西西弗斯
SMODS.Joker {
    key = "sisyphus",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 9, y = 2 },
    config = { extra = { d_size = 1, d_remaining = 1, h_remaining = 1, dollars = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.d_size, card.ability.extra.d_remaining, card.ability.extra.h_remaining, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
    if context.pre_discard and G.GAME.current_round.discards_left == card.ability.extra.d_remaining and
      G.GAME.current_round.hands_left == card.ability.extra.h_remaining and not
      context.blueprint then
            ease_discard(card.ability.extra.d_size)
            ease_dollars(-card.ability.extra.dollars)
                return {
                    message = localize('k_mj_keep_moving')
                }
            end
        end
    }