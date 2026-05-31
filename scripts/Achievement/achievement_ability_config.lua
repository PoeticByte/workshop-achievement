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
        {ability = "plantfriend", cost = 40, default_value = false,canswitch = true,},
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
        {ability = "firebody", cost = 40, default_value = false,},
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
        {ability = "soulhopcopy", cost = 55, default_value = false,},
        {ability = "morestrongstomach", cost = 25, default_value = false,},
        {ability = "shadowsubmissive", cost = 45, default_value = false,canswitch = true,},
        {ability = "eventtechnology", cost = 30, default_value = false,},
        {ability = "murlocdisguise", cost = 45, default_value = false,canswitch = true,},
        {ability = "fastcollection", cost = 35, default_value = false,},
        {ability = "ghostly_friend", cost = 70, default_value = false,},
        {ability = "waxwellfriend", cost = 50, default_value = false,},
        {ability = "flashy", cost = 20, default_value = false,canswitch = true,},
        {ability = "fearless", cost = 50, default_value = false,},
        {ability = "ancientstation", cost = 20, default_value = false,},
        {ability = "autorepair", cost = 40, default_value = false,},
        {ability = "magicpepair", cost = 30, default_value = false,},
        {ability = "moonstone", cost = 20,default_value = false,},
        {ability = "timemanager", cost = 88, default_value = false,},
        {ability = "alchemytechnology", cost = 35, default_value = false,},
        {ability = "lunaraligned", cost = 40, default_value = false,},
        {ability = "shadowaligned", cost = 40, default_value = false,},
        -- ===== 技能树移植能力 (Phase 0 原型) =====
        {ability = "wilson_torch", cost = 15, default_value = false, skilltree = {char = "wilson", skills = {"wilson_torch_1","wilson_torch_2","wilson_torch_3","wilson_torch_4","wilson_torch_5","wilson_torch_6"}},},
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