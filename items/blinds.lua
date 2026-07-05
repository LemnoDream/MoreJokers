--羊
SMODS.Blind {
    key = "sheep",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 0 },
    boss = { min = 5 },
    boss_colour = HEX("ffffff"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card then
                local card = context.debuff_card
                if card.ability and card.ability.set == "Enhanced" then
                    return {
                        debuff = true
                    }
                end
            end
        end
    end
}
--雨
SMODS.Blind {
    key = "rain",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 1 },
    boss = { min = 5 },
    boss_colour = HEX("9cbdbaff"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand then
                local card = context.other_card or context.card
                if card.ability and card.ability.set == "Enhanced" then
                    return {
                        stay_flipped = true
                    }
                end
            end
        end
        if context.blind_disabled then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].facing == 'back' then
                    G.hand.cards[i]:flip()
                end
            end
            for _, playing_card in pairs(G.playing_cards) do
                playing_card.ability.wheel_flipped = nil
            end
        end
    end
}