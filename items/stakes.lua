SMODS.Atlas({
    key = 'stake',
    path = 'stake.png',
    px = '29',
    py = '29'
})

SMODS.Atlas({
    key = 'sticker',
    path = 'sticker.png',
    px = 71,
    py = 95
})

SMODS.Stake({
    key = "jimb",
    applied_stakes = { "gold" },
    above_stake = 'gold',
    prefix_config = { applied_stakes = { mod = false } },
    atlas = 'stake',
    pos = { x = 0, y = 0 },
    shiny = true,
    sticker_pos = { x = 0, y = 0 },
    sticker_atlas = 'sticker',
    colour = HEX('ffffff'),
    modifiers = function()
    G.GAME.modifiers.enable_mj_destroies_in_shop = true
    end,
})