SMODS.Consumable {
    key = 'ascend',
    set = 'Spectral',
    atlas = 'morespectral',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.MoreJokers_asc_minus or 1 } }
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        local deletable_jokers = {}
        for _, joker in ipairs(G.jokers.cards) do
            if joker.ability.set == 'Joker' and not SMODS.is_eternal(joker) then
                deletable_jokers[#deletable_jokers + 1] = joker
            end
        end
            if #deletable_jokers == 0 then return end
            local joker_to_destroy = pseudorandom_element(deletable_jokers, 'mj_ascend')
            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                        play_sound('mj_ascend')
                        G.GAME.MoreJokers_asc_minus = G.GAME.MoreJokers_asc_minus or 1
                        G.hand:change_size(G.GAME.MoreJokers_asc_minus)
                        card:juice_up(0.3, 0.5)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
        delay(0.3)
    end  
end,
    can_use = function(self, card)
        if not G.jokers or not G.jokers.cards then return false end
        for _, joker in ipairs(G.jokers.cards) do
            if joker.ability.set == 'Joker' and not SMODS.is_eternal(joker) then
                return true
            end
        end
        return false
    end
}