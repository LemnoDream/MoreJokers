local mj_config = SMODS.current_mod.config or {}
--阈界
SMODS.Sound({
    vol = 10,
    pitch = 1,
    key = "music_backrooms",
    path = "backrooms.wav",
    select_music_track = function()
    return next(find_joker("j_mj_threshold"))
		and mj_config.mj
		and mj_config.mj.level0_music
		and 200
	end,
})
--矩阵
SMODS.Sound({
    vol = 0.6,
    pitch = 0.7,
    key = "music_matrix",
    path = "matrix.ogg",
    select_music_track = function()
    return next(find_joker("j_mj_matrix"))
		and mj_config.mj
		and mj_config.mj.matrix
		and 175
	end,
})
--颠倒
SMODS.Sound({
    vol = 0.6,
    pitch = 0.7,
    key = "music_cisum",
    path = "cisum.ogg",
    select_music_track = function()
    return next(find_joker("j_mj_invert"))
		and mj_config.mj
		and mj_config.mj.trevni_cisum
		and 150
	end,
})