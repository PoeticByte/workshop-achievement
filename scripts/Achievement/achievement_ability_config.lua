local achievement_ability_config = {
    ability_cost =
    {
        {ability = "speedup", cost = 15, default_value = 0,},
        {ability = "damageup", cost = 10, default_value = 0,},
        {ability = "absorbup", cost = 15, default_value = 0,},
        {ability = "crit", cost = 20, default_value = 0,},
        {ability = "thornss", cost = 40, default_value = 0,canswitch = true,},
        {ability = "electric", cost = 88, default_value = 0,canswitch = true,},
        {ability = "firmarmor", cost = 25, default_value = 0,},
        {ability = "woodieability", cost = 50, default_value = false,},
        {ability = "healthregen", cost = 25, default_value = 0,},
        -- 植物人能力(Wormwood基底): plantfriendfn 已给 plantkin(造活木/荆棘/堆肥包)+healonfertilize。这里再授予 Wormwood 技能树:
        -- 造物分支(builder_skill,TECH.NONE,Route B 自动可造) + farm 识别/快采安全标签。排除开花bloom(需 bloomness 角色组件)与暗影/月亮阵营。
        {ability = "plantfriend", cost = 40, default_value = false,canswitch = true, skilltree = {char = "wormwood", skills = {
            "wormwood_saplingcrafting","wormwood_berrybushcrafting","wormwood_juicyberrybushcrafting",
            "wormwood_reedscrafting","wormwood_lureplantbulbcrafting","wormwood_syrupcrafting",
            "wormwood_mushroomplanter_ratebonus1","wormwood_mushroomplanter_ratebonus2","wormwood_mushroomplanter_upgrade",
            "wormwood_moon_cap_eating",
            "wormwood_identify_plants2","wormwood_blooming_farmrange1",
        }}},
        {ability = "fireflylight", cost = 50, default_value = false,canswitch = true,},
        {ability = "nomoist", cost = 25, default_value = false,canswitch = true,},
        {ability = "doubledrop", cost = 80, default_value = false,},
        {ability = "goodman", cost = 50, default_value = false,},
        {ability = "fishmaster", cost = 40, default_value = false,},
        {ability = "pickmaster", cost = 40, default_value = false,},
        {ability = "chopmaster", cost = 40, default_value = false,},
        {ability = "goldminer", cost = 30, default_value = false,},
        {ability = "cookmaster", cost = 40, default_value = false,canswitch = true,},
        {ability = "buildmaster", cost = 88, default_value = false,},
        {ability = "refresh", cost = 60, default_value = false,},
        {ability = "icebody", cost = 50, default_value = false,},
        -- 火焰免疫(Willow基底): firebodyfn 已给 pyromaniac(造打火机+伯尼)/bernieowner/火免疫。这里再授予 Willow 技能树:
        -- 打火机/火焰(打火机读持有者技能,Route B 同步)+ 伯尼升级。排除暗影/月亮阵营(与现有 aligned 能力重叠)。
        {ability = "firebody", cost = 40, default_value = false, skilltree = {char = "willow", skills = {
            -- 打火机/火焰
            "willow_controlled_burn_1","willow_controlled_burn_2","willow_controlled_burn_3",
            "willow_attuned_lighter","willow_embers","willow_fire_burst","willow_fire_ball","willow_fire_frenzy",
            "willow_lightradius_1","willow_lightradius_2",
            -- 伯尼
            "willow_bernieregen_1","willow_bernieregen_2","willow_berniesanity_1","willow_berniesanity_2","willow_bernieai",
            "willow_berniespeed_1","willow_berniespeed_2","willow_berniehealth_1","willow_berniehealth_2","willow_burnignbernie",
        }}},
        {ability = "supply", cost = 50, default_value = false,},
        {ability = "reader", cost = 75, default_value = false,},
        {ability = "justicerain", cost = 20, default_value = false,},
        {ability = "jump", cost = 50, default_value = false,canswitch = true,},
        {ability = "level", cost = 0, default_value = true,canswitch = true,},
        -- 工程科技=薇诺娜工程: 授予全部薇诺娜技能树技能(建筑升级/暗影月亮对齐/便携/黑暗免疫/传送 + 解锁 builder_skill 配方)。
        -- 桥接服务端 _achiv_skills + 客户端经 currentfastbuild netvar 反查(见 modmain),官方配方(含遥控器/眼镜/储物机器人/传送)自动可造。
        {ability = "fastbuild", cost = 70, default_value = false, skilltree = {char = "winona", skills = {
            -- lowshelf
            "winona_spotlight_heated","winona_spotlight_range","winona_portable_structures","winona_gadget_recharge","winona_battery_idledrain",
            -- midshelf
            "winona_catapult_speed_1","winona_catapult_speed_2","winona_catapult_speed_3",
            "winona_catapult_aoe_1","winona_catapult_aoe_2","winona_catapult_aoe_3",
            "winona_battery_efficiency_1","winona_battery_efficiency_2","winona_battery_efficiency_3",
            "winona_catapult_volley_1","winona_catapult_boost_1",
            -- charlie(暗影)
            "winona_shadow_1","winona_shadow_2","winona_shadow_3","winona_charlie_1","winona_charlie_2",
            -- wagstaff(月亮)
            "winona_lunar_1","winona_lunar_2","winona_lunar_3","winona_wagstaff_1","winona_wagstaff_2",
        },
        -- TECH.LOST 配方(builder_skill 放行后仍被科技门挡住,因 LOST=MAGIC/SCIENCE/ANCIENT各10不可达):
        -- 授予时 builder:AddRecipe 加入已学列表绕过科技门(官方 winona.lua 用 RemoveRecipe 反向门控同理),收回时 RemoveRecipe。
        recipes = {"winona_storage_robot", "winona_telebrella", "winona_teleport_pad_item"}}},
        -- 灵魂跳跃(Wortox基底): 已复刻灵魂系统(击杀生成灵魂 wortox_soul_common + 灵魂跳跃)。这里再授予 Wortox 技能树:
        -- 治疗者/灵魂护盾/振奋(nice)+ 偷窃/灵魂诱饵/抓取袋/灵魂罐(naughty)。物品(灵魂罐/抓取袋/复活器)经 builder_skill+Route B 可造。
        -- 排除: souljar_2(onactivate 调 Wortox 专属 DoCheckSoulsAdded 会崩)、排箫(需 timer 组件,非Wortox没有)、暗影/月亮阵营(重叠)。
        {ability = "soulhopcopy", cost = 55, default_value = false, skilltree = {char = "wortox", skip_generic_remove = true, skills = {
            "wortox_lifebringer_1","wortox_lifebringer_2","wortox_lifebringer_3",
            "wortox_soulprotector_1","wortox_soulprotector_2","wortox_soulprotector_3","wortox_soulprotector_4",
            "wortox_liftedspirits_1","wortox_liftedspirits_2","wortox_liftedspirits_3","wortox_liftedspirits_4",
            "wortox_nabbag","wortox_souljar_1","wortox_souljar_3",
            "wortox_thief_1","wortox_thief_2","wortox_thief_3","wortox_thief_4",
            "wortox_souldecoy_1","wortox_souldecoy_2","wortox_souldecoy_3",
        }}},
        {ability = "morestrongstomach", cost = 25, default_value = false,},
        {ability = "shadowsubmissive", cost = 45, default_value = false,canswitch = true,},
        {ability = "eventtechnology", cost = 30, default_value = false,},
        {ability = "murlocdisguise", cost = 45, default_value = false,canswitch = true,},
        {ability = "fastcollection", cost = 35, default_value = false,},
        -- 灵魂伙伴(Wendy基底): 已给 ghostlybond(阿比盖尔)+elixirbrewer。这里再授予 Wendy 技能树: 姊妹龛/灵药/小阿比/幽花/墓碑/阿比指令升级。
        -- 排除: wendy_sisturn_2(onactivate 调 sanityauraadjuster,非Wendy无此组件会崩)、暗影/月亮阵营(重叠)。skip_generic_remove=true(有手写Remove含阿比清理)。
        {ability = "ghostly_friend", cost = 70, default_value = false, skilltree = {char = "wendy", skip_generic_remove = true, skills = {
            "wendy_sisturn_1","wendy_sisturn_3",
            "wendy_potion_container","wendy_potion_revive","wendy_potion_duration","wendy_potion_yield",
            "wendy_avenging_ghost",
            "wendy_smallghost_1","wendy_smallghost_2","wendy_smallghost_3",
            "wendy_ghostflower_butterfly","wendy_ghostflower_hat","wendy_ghostflower_grave",
            "wendy_gravestone_1","wendy_makegravemounds",
            "wendy_ghostcommand_1","wendy_ghostcommand_2","wendy_ghostcommand_3",
        }}},
        {ability = "waxwellfriend", cost = 50, default_value = false,},
        {ability = "flashy", cost = 20, default_value = false,canswitch = true,},
        -- 无畏(Walter基底): warlter_common_postinit 已给 woby/弹弓/基础弹药/pebblemaker。这里再授予 Walter 技能树技能:
        -- 弹弓改装+多弹种(builder_skill,TECH.NONE,Route B 客户端同步即可造)、Woby 升级、露营通用项。排除暗影/月亮阵营(与 mod 现有 aligned 能力重叠)。
        -- skip_generic_remove=true: fearless 有手写 fearlessRemove(woby清理+1.5s延迟防竞态),不走 resetbuff 通用 Remove 循环,改由延迟路径 revoke。
        {ability = "fearless", cost = 50, default_value = false, skilltree = {char = "walter", skip_generic_remove = true, skills = {
            -- 弹弓改装
            "walter_slingshot_modding","walter_slingshot_handles","walter_slingshot_bands","walter_slingshot_frames",
            -- 弹药
            "walter_ammo_shattershots","walter_ammo_lucky","walter_ammo_utility","walter_ammo_efficiency","walter_ammo_bag",
            -- Woby
            "walter_woby_sprint","walter_woby_dash","walter_woby_endurance","walter_woby_taskaid","walter_woby_foraging","walter_woby_itemfetcher",
            -- 露营
            "walter_camp_fire","walter_camp_rope","walter_camp_firstaid","walter_camp_walterhat","walter_camp_wobytreat","walter_camp_wobyholder","walter_camp_wobycourier",
        }}},
        {ability = "ancientstation", cost = 20, default_value = false,},
        {ability = "autorepair", cost = 40, default_value = false,},
        {ability = "magicpepair", cost = 30, default_value = false,},
        {ability = "moonstone", cost = 20,default_value = false,},
        {ability = "timemanager", cost = 88, default_value = false,},
        {ability = "alchemytechnology", cost = 35, default_value = false,},
        {ability = "lunaraligned", cost = 40, default_value = false,},
        {ability = "shadowaligned", cost = 40, default_value = false,},
        -- ===== 技能树移植能力 (Phase 0 原型) =====
        -- 驭火大师: 火把时长/亮度(wilson_torch_1..6) + 扔火把(wilson_torch_7,火把本身已可投掷,只需 modmain 接 TOSS 点动作)。
        {ability = "wilson_torch", cost = 15, default_value = false, skilltree = {char = "wilson", skills = {"wilson_torch_1","wilson_torch_2","wilson_torch_3","wilson_torch_4","wilson_torch_5","wilson_torch_6","wilson_torch_7"}},},
        -- 瓦尔基里军备(Wigfrid 军备分支): 全新独立纯技能树能力(无现成基底)。装备类齐装可移植: 闪电长矛/指挥官头盔/战斗圆盾(均 builder_skill+TECH.NONE,Route B 可造)+ 升级 + 位面防御 + 护甲牛鞍。
        -- 排除战歌/灵感分支(需 Wigfrid 专属 inspiration 子系统,mod 未实现)、beefalo_1(onactivate 调 _riding_music 网变会崩)、beefalo_3(需灵感)、暗影/月亮阵营。
        {ability = "wigfridgear", cost = 40, default_value = false, skilltree = {char = "wathgrithr", skills = {
            "wathgrithr_arsenal_spear_3","wathgrithr_arsenal_spear_4","wathgrithr_arsenal_spear_5",
            "wathgrithr_arsenal_helmet_1","wathgrithr_arsenal_helmet_2","wathgrithr_arsenal_helmet_3","wathgrithr_arsenal_helmet_4","wathgrithr_arsenal_helmet_5",
            "wathgrithr_arsenal_shield_1","wathgrithr_arsenal_shield_2","wathgrithr_arsenal_shield_3",
            "wathgrithr_combat_defense",
            "wathgrithr_beefalo_2","wathgrithr_beefalo_saddle",
        }}},
    },
    ability_ratio=
    {
        ["thornss"] = 1,
        ["electric"] = 1,
        ["firmarmor"] = 1,
        ["woodieability"] = TUNING.WILSON_HUNGER_RATE*.02,
        ["healthregen"] = .2,
        ["plantfriend"] = .2,
        ["speedup"] = .05,
        ["damageup"] = .05,
        ["absorbup"] = .05,
        ["crit"] = 5,
    },
    attributes_cost = 
    {
        ["hungerup"] = 1,
        ["sanityup"] = 1,
        ["healthup"] = 1,
    },
    
}
local modname = KnownModIndex:GetModActualName("New Achievement")
local cost_ratio  = GetModConfigData("abilityifficulty",modname)
local function PretreatmentAchievementAbilityConfig()
    achievement_ability_config.id2ability = {}
    for _,v in ipairs(achievement_ability_config.ability_cost) do
        v.cost = math.ceil(v.cost * cost_ratio)
        achievement_ability_config.id2ability[v.ability] = v
    end
end
PretreatmentAchievementAbilityConfig()
return achievement_ability_config