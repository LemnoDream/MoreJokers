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
        return { vars = { colours = { HEX('9453B8FF'), HEX('687EE7FF') } } }
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
--太阳
SMODS.Joker {
    key = "sun",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = false,
    rarity = 3,
    atlas = 'morejokers',
    cost = 8,
    pos = { x = 8, y = 4 },
    calculate = function(self, card, context)
    if context.selling_self then
      if G.STAGE == G.STAGES.RUN then 
        G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false; end
    else
    if context.joker_type_destroyed then
      local this_card = context.blueprint_card or card
      if context.card == this_card then
      if G.STAGE == G.STAGES.RUN then 
        G.STATE = G.STATES.GAME_OVER; G.STATE_COMPLETE = false; end
    end
    end
    if context.setting_blind then
            if (G.GAME.blind:get_type() == 'Small' or G.GAME.blind:get_type() == 'Big' or G.GAME.blind.boss) then
                return {     
                    func = function()
                        if G.GAME.blind.in_blind then       
                            G.GAME.blind.chips = G.GAME.blind.chips * 0.5
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            G.HUD_blind:recalculate()
                            return true
                        end
                    end
                }
            end
       end
  end
  end
}
--不再有梦
SMODS.Joker {
    key = "dream_no_more",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 1, y = 5 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_negative', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_negative' } } }
    end,
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
        G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag({ key = 'tag_negative' })
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    card:juice_up(0.5, 0.5)
                    return true
                end)
            }))
            return {
                message = localize('k_mj_knight'),
                colour = G.C.DARK_EDITION
            }
        end
    end,
}
--阈界
SMODS.Joker {
    key = "threshold",
    blueprint_compat = true,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 8,
    pos = { x = 6, y = 5 },
    config = { extra = { Xmult = 1, Xmult_gain = 0.25, Xmult_egg = 3.01, h_remaining = 0, odds = 100 } },
    loc_vars = function(self, info_queue, card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'threshold')
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, card.ability.extra.h_remaining, numerator, denominator, colours = { HEX('D4C600FF') } } }
    end,
    set_ability = function(self, card, initial)
        card:set_eternal(true)
    end,
    calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and G.GAME.current_round.hands_left == card.ability.extra.h_remaining then
    if SMODS.pseudorandom_probability(card, 'mj_threshold', 1, card.ability.extra.odds) then
         card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_egg
         play_sound('mj_loopingrooms')
         return {
            message = localize('k_mj_egg'),
            colours = G.C.GOLD
         }
    else
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
        return {
            message = localize('k_upgrade_ex'),
            colours = G.C.GOLD
        }
    end
end
    if context.joker_main then
         return {
             xmult = card.ability.extra.Xmult,
             }
         end
     end
    }
--地狱狂徒
SMODS.Joker {
    key = "hellraier",
    blueprint_compat = false,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 8,
    pos = { x = 7, y = 5 },
    pixel_size = { h = 90, w = 65 },
    config = { extra = { h_remaining = 3, hands = -1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_remaining, card.ability.extra.hands, colours = { HEX('42E900FF') } } }
    end,
    calculate = function(self, card, context)
    if context.joker_main and G.GAME.current_round.hands_left >= card.ability.extra.h_remaining then
        ease_hands_played(card.ability.extra.hands)
        return {
             score = G.GAME.blind.chips / 2
            }
        end
    end
   }
--颠倒
SMODS.Joker {
    key = "invert",
    blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 3,
    pos = { x = 9, y = 5 },
    loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
        return { vars = { } }
    end,
    set_ability = function(self, card, initial)
    local edition = { negative = true}
    card:set_edition(edition, true)
    card:set_eternal(true)
    end,
    calculate = function(self, card, context)
    if context.buying_card and context.card and context.card.ability.consumeable and not context.blueprint then
    if not context.card.edition then
        G.E_MANAGER:add_event(Event({
        func = function()
        if context.card and not context.card.removed then
          card:juice_up()
          context.card:set_edition({ negative = true }, true)
          end
          return true
      end
      }))
         return {
             message = localize('k_mj_negative'),
             colour = G.C.DARK_EDITION
              }
          end
      end
  end
}
--献祭
SMODS.Joker {
    key = "sacrifice",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 8,
    pos = { x = 0, y = 6 },
    calculate = function(self, card, context)
    if context.selling_card then
       return {
             score = G.GAME.blind.chips / 10
            }
        end
    end
   }
--矩阵
SMODS.Joker {
    key = "matrix",
    blueprint_compat = true,
	perishable_compat = true,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 8,
    pos = { x = 1, y = 6 },
    config = { extra = { cumulative = 0, cumulative_gain = 1, Xmult = 1, Xmult_gain = 0.1, Xmult_mod = 0.3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cumulative, card.ability.extra.cumulative_gain, card.ability.extra.Xmult, card.ability.extra.Xmult_gain, card.ability.extra.Xmult_mod, colours = { HEX('A8A8A8FF') } } }
    end,
    set_ability = function(self, card, initial)
        card:set_eternal(true)
    end,
    calculate = function(self, card, context)
    if context.pre_discard or context.before and not context.blueprint then
        card.ability.extra.cumulative = card.ability.extra.cumulative + card.ability.extra.cumulative_gain
    end
    if context.pre_discard and not context.blueprint then
    if card.ability.extra.cumulative >= 15 and card.ability.extra.cumulative < 60 and not context.blueprint then
    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
         return {
             message = localize('k_upgrade_ex'),
             colour = G.C.WHITE
         }
    end
    if card.ability.extra.cumulative >= 60 and not context.blueprint then
    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
         return {
             message = localize('k_upgrade_ex'),
             colour = G.C.WHITE
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
--莱尼虫
SMODS.Joker {
    key = "rhyniognatha",
    blueprint_compat = false,
	perishable_compat = false,
	eternal_compat = true,
    rarity = 3,
    atlas = 'morejokers',
    cost = 7,
    pos = { x = 5, y = 5 },
    config = { extra = { odds = 15, ddos = 0 } },
    loc_vars = function(self, info_queue, card)
    local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.ddos, card.ability.extra.odds, 'rhyniognatha')
        return { vars = { card.ability.extra.ddos, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            local my_ra = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_ra = i; break end
            end
            if not my_ra then return end
            local left_card = G.jokers.cards[my_ra - 1]
            local right_card = G.jokers.cards[my_ra + 1]
            if SMODS.pseudorandom_probability(card, 'rhyniognatha', card.ability.extra.ddos, card.ability.extra.odds) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local edition = { negative = true}
                                right_card:set_edition(edition, true)
                                right_card:juice_up(0.8, 0.5)
                                card.ability.extra.ddos = 0
                                return true
                            end
                        }))
                        return {
                              message = localize('k_reset'),
                              colour = G.C.RED
                        }
                    end
                if left_card and not left_card.ability.eternal then
                G.E_MANAGER:add_event(Event({
                    func = function()
                    card.ability.extra.ddos = card.ability.extra.ddos + 1
                        left_card.getting_sliced = true
                        SMODS.destroy_cards({left_card}, nil, true)
                        play_sound('slice1', 0.96, 0.65)
                        card:juice_up(0.5, 0.5)
                        return true
                    end
                 }))
                    return {
                          message = localize('k_mj_probability_increase_ex'),
                          colour = G.C.GREEN
                        }
                    end
               end
          end
        }