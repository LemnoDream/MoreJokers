return {
    misc={
          v_dictionary={
               a_chips_mod = "+#1#筹码",
               a_xchips = "X#1#筹码",
               a_discards="弃牌次数+#1#",
               },
          dictionary={
               k_mj_about = "关于",
               k_mj_last = "最后一次！",
               k_mj_stick_ex = "黏住了！",
               k_mj_crazy_ex = "疯掉了…！",
               k_mj_kachan_ex = "咔哒！",
               k_mj_destroy_ex = "毁灭了…",
               k_mj_continue_ex = "游戏继续！",
               k_mj_regret_ex = "别后悔！",
               k_mj_destroies_ex = "摧毁！",
               k_mj_high_crash_ex = "坠毁了！",
               k_mj_probability_increase_ex = "概率增加！",
               k_mj_keep_moving = "继续前进！",
               k_mj_wheel = "+1命运之轮！",
               },
          challenge_names={
               c_mj_scratcher = '刮刮乐',
               },
          labels={
                  mj_destroies="摧毁",
                  mj_sequins="亮片",
               },
          },
    descriptions={
    Joker={
            j_mj_cavendish={
                name="卡文迪什",
                text={
                    "{X:mult,C:white}X#1#{}倍率",
                    "回合结束时",
                    "有{C:green}#2#/#3#{}的几率",
                    "摧毁此牌",
                },
            },
            
            j_mj_banana_king={
                name="香蕉王",
                text={
	                 "{X:mult,C:white} X#1# {}倍率",
			         "回合结束时",
			         "有{C:green} #2#/#3# {}的机率",
			         "摧毁此牌",
                },
            },
            
	        j_mj_labyrinth={
	            name="迷宫",
                text = {
                       "击败{C:attention}Boss盲注时",
                       "给予{X:mult,C:white} X#1# {}倍率",
                       "{C:inactive}（当前为{} {X:mult,C:white}X#2#{} {C:inactive}倍率）{}",
                },
            },
            
            j_mj_width={
                name = '宽体小丑',
                text = {
                       "小丑牌槽位{C:attention}+2",
                       "手牌上限{C:red}#2#",
                       "{C:inactive}“比例正确”",
                },
            },
            
            j_mj_very_joker={
                name = '小丑模板',
                text = {
                       "如果没有{C:attention}除本小丑外{}的其他小丑牌",
                       "在选择{C:attention}盲注{}时",
                       "生成{C:attention}1张{}{C:uncommon}罕见{}或{C:rare}稀有{}{C:attention}小丑牌{}",
                },
            },
            
            j_mj_steamed_bun={
                name = '馒头',
                text = {
                        "{C:blue}+#4#{}出牌次数",
                        "回合结束时",
                        "有{C:green}#5#/#6#{}的机率",
                        "摧毁此牌",
                },
            },
            
            j_mj_steamed_stuffed={
                name = '包子',
                text = {
                        "{C:red}+#1#{}弃牌次数",
                        "回合结束时",
                        "有{C:green}#2#/#3#{}的机率",
                        "摧毁此牌",
                },
            },
            
            j_mj_dumplings={
                name = '饺子',
                text = {
                        "{C:blue}+#1#{}出牌次数",
                        "{C:red}+#2#{}弃牌次数",
                        "回合结束时",
                        "有{C:green}#3#/#4#{}的机率",
                        "摧毁此牌"
                },
            },
            
            j_mj_accident={
                name = '幸运四叶草',
                text = {
                        "使用{C:tarot}塔罗牌{}时",
                        "有{C:green}#1#/#2#{}的概率",
                        "获得一张{C:tarot}命运之轮",
                        "{C:inactive}（必须有空位）",
                },
            },
            
            j_mj_almond_water={
                name = '杏仁水',
                text = {
                        "如果{C:attention}疯狂{}或{C:attention}偏执{}在小丑槽中",
                        "离开商店时",
                        "将它们变为{C:attention}正常小丑{}",
                        "{C:inactive}（一瓶只能变化一张）",
                },
            },
            
            j_mj_retro={
                name="复古小丑",
                text = {
			            "每有一张{C:attention}小丑牌",
			            "{C:chips}+#1#{}筹码",
		                "{C:inactive}（当前为{}{C:chips}+#2#{}{C:inactive}筹码）{}",
	            },
            },
            
            j_mj_blue_card={
                name="蓝牌",
                text = {
			            "当跳过任一{C:attention}补充包{}时",
			            "这张小丑牌获得{C:chips}+#1#{}筹码",
		                "{C:inactive}（当前为{}{C:chips}+#2#{}{C:inactive}筹码）{}",
	            },
            },
            
            j_mj_normal={
                name="正常小丑",
                text = {
                        "{X:mult,C:white}X#1#{}倍率",
			            "{X:chips,C:white}X#2#{}筹码",
	            },
            },
            
            j_mj_midas_joker={
                name = '迈达斯小丑',
                text = {
                        "每个回合结束时",
                        "你的{C:attention}完整牌组{}内的每张{C:attention}黄金牌",
                        "使你获得{C:money}$#1#",
                        "{C:inactive}（当前{}{C:money}$#2#{}{C:inactive}）{}",
                },
            },
            
            j_mj_desperado={
                name = '亡命之徒',
	        	text = {
	            		"选择{C:attention}盲注{}后",
	            		"将出牌次数设为{C:red}1",
		            	"{X:mult,C:white}X#1#{}倍率",
	        	},
        	},
        	
        	j_mj_regret_med={
        	    name = '后悔药',
        		text = {
	            		"选择{C:attention}盲注{}后",
	            		"{C:attention}失去所有弃牌次数",
	            		"{X:mult,C:white}X#1#{}倍率",
	        	},
        	},
        	
        	j_mj_irritable_joker={
	        	name = '暴躁小丑',
	        	text = {
		            	"在你的牌组中",
		            	"每比完整的{C:attention}#4#{}张牌少一张",
	            	    "就获得{X:mult,C:white}X#2#{}倍率",
		                "{C:inactive}（当前为{}{X:mult,C:white}X#3#{}{C:inactive}倍率）{}",
	        	},
        	},
        	
        	j_mj_all_in_one={
        	    name = '全家桶',
	        	text = {
	            		"{C:mult} +#1# {} 倍率",
	            		"{C:chips} +#2# {} 筹码",
	            		"{C:red} +#3# {} 弃牌次数",
	            		"{C:blue} +#4# {} 出牌次数",
	            		"回合结束时",
	            		"有{C:green}#5#/#6# {} 的机率",
	            		"摧毁此牌",
	        	},
        	},
        	
        	j_mj_wild_4={
        	    name = '万能+4',
                text = {
                        "{C:attention}完整牌组{}内每拥有一张",
                        "{C:attention}万能牌",
                        "{C:mult}+#1#{}倍率",
                        "{C:inactive}（当前为{} {C:red}+#2#{} {C:inactive}倍率）{}",
                },
            },
            
            j_mj_anka={
                name = '安卡',
                text = {
                        "如果出牌次数为{C:attention}0",
                        "则{C:blue}+2{}出牌次数",
                        "{C:red}自毁",
                },
            },
            
            j_mj_jochips={
                name = '小筹',
                text = {
                        "回合结束时",
                        "获得{C:chips}+#5#{}筹码",
                        "{C:attention}完整牌组{}内每拥有一张",
                        "{C:attention}奖励牌",
                        "使这一数值{C:chips}+#2#{}",
                        "{C:inactive}（当前为{} {C:blue}+#1#{} {C:inactive}筹码）{}",
                },
            },
            
            j_mj_watch={
                name = '怀表',
                text = {
                        "每个回合数给予",
                        "{C:chips}+#1#{}筹码",
                        "每使用一张{C:attention}消耗牌",
                        "使这一数值{C:chips}+#2#",
                        "{C:inactive}（当前为{}{C:chips}+#3#{}{C:inactive}筹码）{}",
                },
            },
            
            j_mj_every_three={
                name = '事不过三',
                text = {
                        "{X:mult,C:white}X#2#{}倍率",
                        "每弃掉一张牌",
                        "增加{X:mult,C:white}X#1#{}倍率",
                        "如果大于{X:mult,C:white}X3{}倍率则重置",
                },
            },
            
            j_mj_three_sun={
                name = '三日凌空',
                text = {
                        "牌型等级每级给予",
                        "{C:mult}+#2#{}倍率",
                        "{C:chips}+#1#{}筹码",
                },
            },
            
            j_mj_baseba={
                name="棒球",
                text = {
			            "每张{C:common}普通{}小丑牌",
			            "会给予{C:chips}+#2#{}筹码",
			            "如果{C:attention}棒球卡{}在小丑槽中",
			            "每张{C:common}普通{}小丑牌",
			            "会给予{X:chips,C:white}X#1#{}筹码",
	            },
            },
            
            j_mj_golden_apple={
                name="金苹果",
                text = {
			            "每{C:attention}弃掉一张牌",
			            "获得{C:mult}+3{}倍率",
			            "{C:inactive}（当前为{}{C:mult}+#1#{}{C:inactive}倍率）{}",
		                "和{C:chips}+8{}筹码",
		                "{C:inactive}（当前为{}{C:chips}+#2#{}{C:inactive}筹码）{}",
		                "出牌后重置",
	            },
            },
            
            j_mj_come={
                name="白昼",
                text = {
			            "{X:mult,C:white}X#1#{}倍率",
			            "出牌后变为",
			            "{C:attention}黑夜",
	            },
            },
            
            j_mj_go={
                name="黑夜",
                text = {
			            "{X:mult,C:white}X#1#{}倍率",
			            "出牌后变为",
			            "{C:attention}白昼",
	            },
            },
            
            j_mj_gum={
                name="口香糖",
                text = {
			            "在回合结束时",
			            "获得{C:money}$#1#",
			            "有{C:green}#2#/#3#{}的机率",
			            "摧毁此牌",
			            "并随机给予一张小丑牌",
			            "{C:attention}永恒卡{}贴纸",
	            },
            },
            
            j_mj_vip_card={
                name = '会员卡',
        		text = {
            			"每拥有{C:money}$#2#",
            		    "{X:red,C:white}X0.5{}倍率",
            		    "{C:inactive}（当前为{}{X:mult,C:white}X#3#{}{C:inactive}倍率）{}"
        		},
        	},
        	
        	j_mj_recycle={
        	    name = '回收利用',
                text = {
                        "使用任意{C:attention}消耗牌{}时",
                        "获得{C:money}$#1#",
                },
            },
            
            j_mj_paranoia={
        	    name = '偏执',
                text = {
                        "连续打出你",
                        "最常用的{C:attention}牌型{}时",
                        "{X:mult,C:white}X#1#{}倍率",
                        "失败会将资金变为{C:money}$0",
                        "并失去{X:mult,C:white}X#2#{}倍率",
                        "失去全部倍率时",
                        "变为{C:attention}疯狂{}",
                },
            },
            
            j_mj_cube={
                name="方块小丑",
                text = {
			            "如果打出的计分牌",
			            "点数总和为{C:attention}16",
		                "{X:mult,C:white}X#1#{}倍率",
	            },
            },
            
            j_mj_rock_gold={
                name="点石成金",
                text = {
			            "打出的所有{C:attention}石头牌",
                        "在计分时",
                        "变为{C:attention}黄金牌",
	            },
            },
            
            j_mj_joker_of_fortune={
                name="命运之丑",
                text = {
			            "{C:attention}命运之轮{}每生效一次",
                        "{X:mult,C:white}X#2#{}倍率",
                        "每失效一次",
                        "失去{X:mult,C:white}X#3#{}倍率",
                        "{C:inactive}（当前为{X:mult,C:white}X#1#{}{C:inactive}倍率）{}",
	            },
            },
            
            j_mj_sisyphus={
                name = '西西弗斯',
                text = {
                        "弃牌时",
                        "如果弃牌和出牌次数为{C:attention}1{}",
                        "给予{C:blue}+1{}弃牌次数并",
                        "失去{C:money}1$",
                        "{s:0.8,C:inactive}“我们必须想象”",
                        "{s:0.8,C:inactive}“西西弗斯是幸福的”",
                },
            },
            
            j_mj_solar_system={
                name = '太阳系',
                text = {
                        "如果在出牌时",
                        "资金多于或等于{C:money}$#1#",
                        "则获得你打出的牌型的{C:planet}星球牌",
                        "{C:inactive}（必须有空位）",
                        "所需资金回合结束时增加{C:money}$#2#",
                        "到达{C:money}$100{}时自毁",
                },
            },
            
            j_mj_alone={
                name = '孤者',
	           	text = {
	            	    "如果打出的牌型为",
	            	    "{C:attention}高牌",
	            	    "{X:mult,C:white}X#1#{}倍率并",
	            	    "增加{X:mult,C:white}X#2#{}倍率",
	        	},
        	},
        	
        	j_mj_pyramid={
        	    name = '金字塔',
                text = {
                        "每有一张打出{C:attention}A{}计分时",
                        "这张小丑获得",
                        "{X:mult,C:white}X#1#{}倍率",
                        "除{C:attention}A{}和{C:attention}K{}以外的任一牌计分时",
                        "重置倍率",
                        "{C:inactive}（当前为{X:mult,C:white}X#2#{}{C:inactive}倍率）",
                },
            },
            
            j_mj_space_elevator={
                name = '陨石',
        		text = {
            			"升级每回合",
            			"第一次{C:attention}出牌的",
            			"牌型的等级",
            			"{C:attention}#2#{}回合后坠毁",
	        	},
	        },
	        
	        j_mj_issue_order={
	            name = '发令',
                text = {
                        "如果在回合结束时",
                        "没有使用弃牌，则生成",
                        "一张{C:spectral}幻灵牌",
                        "{C:inactive}（必须有空位）",
                },
            },
            
            j_mj_missed_print={
                name="漏印小丑",
                text = {
			            "{X:mult,C:white}",
	            },
            },
            
            j_mj_finger_doctor={
                name="手指医生",
                text = {
			            "在离开商店时",
			            "清除右侧小丑牌的",
			            "{C:attention}易腐{}和{C:attention}摧毁{}贴纸",
	            },
            },
            
            j_mj_sommers={
                name = '萨默斯',
                text = {
                        "每使用一张{C:spectral}幻灵牌",
                        "给予{X:mult,C:white}X#1#{}倍率",
                        "{C:inactive}（当前为{}{X:mult,C:white}X#2#{}{C:inactive}倍率）{}",
                },
            },
            
            j_mj_jimbo={
                name = '金宝',
                text = {
                        "每第{C:attention}4{}次出牌时",
                        "给予{X:mult,C:white}X#1#{}倍率",
                        "{C:inactive}（当前为{}{X:mult,C:white}X#2#{}{C:inactive}倍率）{}",
                        "{C:inactive}（#4#）",
       
                },
            },
            
            j_mj_carefree_melody={
                name = '无忧小丑',
                text = {
                        "出牌后有{C:green}#2#/#1#{}的概率",
                        "{C:blue}+#3#{}出牌次数",
                        "若没触发",
                        "则增加概率",
                        "触发后概率{C:attention}重置{}",
                },
            },
    },

    Back={
            b_mj_normal={
                name = '普通牌组',
                text = {
                        "无任何增益或减益",
                },
            },
    },    
         
    Enhanced={
            m_mj_soil={
                name = '泥土牌',
		        text = {
			            "{C:mult}+#1#{}倍率",
			            "无点数无花色",
		        },
		    },
	},

    Tarot={
           c_mj_ace_of_pentacles={
                name = '星币首牌',
        		text = {
            			"增强{C:attention}#1#{}张选定卡牌成为",
            			"{C:attention}泥土牌",
        		},
           },
    },
--幻灵牌           
    Spectral={
          c_mj_ascend={
                name = '超度',
        		text = {
            			"随机摧毁一张{C:attention}小丑牌",
            			"手牌上限{C:blue}+1",
        		},
       	  },
    },
--盲注       	  
    Blind={
          bl_mj_sheep={
                name = '羊',
        		text = {
            			"所有增强牌",
            			"都被削弱",
        		},
          },
        		
          bl_mj_rain={
                name = '雨',
                text = {
                        "所有增强牌都是",	
                        "以背面朝上的方式抽取",
                },	
          },
    },
    Edition={
          e_mj_sequins={
                name = "亮片",
                text = {
                        "{X:chips,C:white}X#1#{}筹码",
                },
          },
    },
    
    Stake={
          stake_mj_jimb={
                name = "金宝注",
                text = {
                    "商店里有可能出现{C:attention}摧毁{}小丑牌",
                    "{C:inactive,s:0.8}（回合结束时有{C:green,s:0.8}1/5{C:inactive,s:0.8}的概率随机摧毁左边或右边的小丑牌）",
                    "{C:inactive,s:0.8}（无视永恒）{C:inactive,s:0.8}",
                    '{s:0.8}之前的所有赌注也都起效'
                },    
          },
    },
    
    Other={
           mj_jimb_sticker={
                name = "金宝标贴",
                text = {
                    "使用这张小丑牌",
                    "在{C:attention}金宝注",
                    "难度下获胜",
                },
           },
            
           mj_destroies={
                name="摧毁",
                text={
                    "在回合结束时",
                    "有{C:green}#1#/5{}的概率",
                    "随机摧毁一张左边或右边的{C:attention}小丑牌",
                    "{C:inactive}（无视永恒）{C:inactive}",
                },
           },                                
    },
    
    Mod={
            mj = {
                name = "更多小丑",
                text = {
                    "新增{C:blue}45{}张小丑牌、{C:spectral}1{}张幻灵牌、{C:money}2{}个Boss盲注和{C:attention}1{}个没用牌组",
                    "另外还有全新的赌注——{C:red}金{}{C:blue}宝{}注和全新的{C:black}负面{}贴纸",
                    " ",
                    "{C:green}美术＆小丑设计",
                    "一只鸡昊",
                    " ",
                    "{C:attention}代码",
                    "Ldream",
                    " ",
                    "{C:dark_edition}特别感谢",
                    "一只鸡昊",
                    "ARandomMod",
                    "All in jest",
                    "Cryptid",
                    "Maximus",
                    "Ortalab",
                    "Wormhole",
                },
            },
            
            About = {
                name = "About",
                text = {
                   "嗯…很久之前就有做模组的想法了，但碍于技术原因，拖了很久才基本完成。",
                   "由于是代码萌新，有的代码甚至是其他模组搬的，我都标在{C:dark_edition}特别感谢{}里面了，{Cattention}谢谢你们！",
                   " ",
                   "由于{C:green}小丑设计(一只鸡昊){}和{C:blue}我(Ldream){}玩的游戏真的很杂，所以说里面有各种客串的小丑。",
                   " ",
                   "美术是由{C:blue}我(Ldream){}和{C:green}一只鸡昊{}共同完成，不得不说真的很{C:money}拉{}啊…勉强能看吧。",
                   "因为基本没接触过像素画，已经尽力了…{C:red}Sorry。",
                   " ",
                   "真的很喜欢这款游戏，现在正在为所有{C:blue}小丑{}贴{C:money}金标，",
                   "很{C:attention}难{}…你们不要去试。",
                   " ",
                   "以后说不定会支持{C:attention}多语言{}呢？",
                   " ",
                   "享受这个模组！",
                   
                },
            },
    },
    
    Tag={
          tag_mj_sequins={
                name = '亮片标签',
                text = {
                    '商店里的下一张',
                    '基础版本小丑牌',
                    '将会免费且变为{C:dark_edition}亮片{}',
                },
            },
       },
   },
}