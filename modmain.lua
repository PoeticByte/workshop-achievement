GLOBAL.CHEATS_ENABLED = true
GLOBAL.require( 'debugkeys' )
GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})
local _G = GLOBAL
local require = GLOBAL.require
local ipairs =GLOBAL.ipairs
local STRINGS = GLOBAL.STRINGS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local TheInput = GLOBAL.TheInput
local SpawnPrefab = GLOBAL.SpawnPrefab
local TimeEvent = GLOBAL.TimeEvent
local FRAMES = GLOBAL.FRAMES
local ActionHandler = GLOBAL.ActionHandler
local ACTIONS = GLOBAL.ACTIONS
local achievement_config = require("Achievement.achievement_config")
local achievement_ability_config = require("Achievement.achievement_ability_config")
local ability_cost = achievement_ability_config.ability_cost
local language  = GetModConfigData("language")
local can_hide_hud = GetModConfigData("can_hide_hud")
local language_package = "Achievement.strings_achievement_" .. language
require(language_package)
require "Achievement.allachivrpc"
-- GM 控制台命令: 文件返回函数表,这里注册到真全局表 GLOBAL,控制台才能调用(详见该文件注释)。
local _gm_commands = require 'achievement_debugcommands'
for _gmname, _gmfn in GLOBAL.pairs(_gm_commands) do
    GLOBAL[_gmname] = _gmfn
end
TUNING.CHECKCOIN = GetModConfigData("checkcoin")
TUNING.CHECKSTART = GetModConfigData("checkstart")
TUNING.BOSSSUP = GetModConfigData("bossstrengthen")
TUNING.RETRUN_POINT = GetModConfigData("returnpoint")
TUNING.RETRUN_ATTRIBUTE_POINT = GetModConfigData("return_attribute_point")
TUNING.ATTRIBUTE_POINTS_GAINED = GetModConfigData("attribute_points_gained")
TUNING.ACHIEVEMENT_FIRSTINIT = 0
local SHOW_TITLE = GetModConfigData("showtitle")
local IsServer = _G.TheNet:GetIsServer() or _G.TheNet:IsDedicated()
PrefabFiles = {
	"seffc",
	"klaussack_placer",
	--"achivbooks",
    "achivbooks_add",
    "shadowmeteor_ai",
	"expbean",
    "redlantern2",
    "wesfx",
    "fernsfx",
    "healflowersfx",
    "deer_ice_flakes_aifx",
    "electricfx",

    "achiv_fire",
    "achiv_sinkhole",
    "achiv_shield",
    "achiv_ice_crystal",
    "achiv_lasertrail",
    "achiv_bramblefx",
    "achiv_altar_placer",
    "achievement_moonbase",
    "achiv_moonbase_placer",
    "achiv_moon_altar_placer",
    "halo",
    "title",
}

Assets = {

    Asset("ATLAS", "images/inventoryimages/achiv_armor_bramble.xml"),
    Asset("IMAGE", "images/inventoryimages/achiv_armor_bramble.tex"),
    Asset("ATLAS", "images/inventoryimages/achiv_trap_bramble.xml"),
    Asset("IMAGE", "images/inventoryimages/achiv_trap_bramble.tex"),
    Asset("ATLAS", "images/inventoryimages/achiv_compostwrap.xml"),
    Asset("IMAGE", "images/inventoryimages/achiv_compostwrap.tex"),
    
	Asset("ATLAS", "images/inventoryimages/expbean.xml"),
    Asset("IMAGE", "images/inventoryimages/expbean.tex"),

	Asset("ATLAS", "images/inventoryimages/klaussack.xml"),
    Asset("IMAGE", "images/inventoryimages/klaussack.tex"),

    Asset("ATLAS", "images/inventoryimages/achivbook_meteor.xml"),
    Asset("IMAGE", "images/inventoryimages/achivbook_meteor.tex"),

    Asset("ATLAS", "images/inventoryimages/achivbook_shakespeare.xml"),
    Asset("IMAGE", "images/inventoryimages/achivbook_shakespeare.tex"),
 
    Asset("ATLAS", "images/inventoryimages/memorypotion.xml"),
    Asset("IMAGE", "images/inventoryimages/memorypotion.tex"),  

    Asset("ATLAS", "images/inventoryimages/altar.xml"),
    Asset("IMAGE", "images/inventoryimages/altar.tex"), 
    Asset("ATLAS", "images/inventoryimages/moon_altar.xml"),
    Asset("IMAGE", "images/inventoryimages/moon_altar.tex"), 
    Asset("ATLAS", "images/inventoryimages/moonbase.xml"),
    Asset("IMAGE", "images/inventoryimages/moonbase.tex"), 

    Asset("ATLAS", "images/hud/achivbg_act.xml"),
    Asset("IMAGE", "images/hud/achivbg_act.tex"),
    Asset("ATLAS", "images/hud/achivbg_dact.xml"),
    Asset("IMAGE", "images/hud/achivbg_dact.tex"),
    Asset("ATLAS", "images/hud/achivbg_done.xml"),
    Asset("IMAGE", "images/hud/achivbg_done.tex"),
    Asset("ATLAS", "images/title/title.xml"),
    Asset("IMAGE", "images/title/title.tex"), 
    Asset("ANIM", "anim/altar.zip"),
}

local buttonimageslist = {
"last_act","last_dact","next_act","next_dact","close","infobutton",
"checkbutton","checkbuttonglow","coinbutton","coinbuttonglow",
"config_act","config_dact","config_bg","config_bigger","config_smaller","config_drag","config_remove",
"remove_info_cn", "remove_info_en","remove_yes","remove_no",
"item_head_act","item_head_dact", "item_mide_act","item_mide_dact","item_tail_act","item_tail_dact",
"button_normal",
}

for k,v in pairs(buttonimageslist) do
    table.insert(Assets, Asset("ATLAS", "images/button/"..v..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/button/"..v..".tex"))
end
local coinlist = {
	"coin_cn0","coin_cn1","coin_cn3","coin_cn_start","coin_cn_change",  "coin_cn_line", 
}

for k,v in pairs(coinlist) do
	table.insert(Assets, Asset("ATLAS", "images/coin_cn/"..v..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/coin_cn/"..v..".tex"))
end

--给食物加上自身tag
local foodnamelist = {
"nightmarepie","voltgoatjelly","glowberrymousse","frogfishbowl","dragonchilisalad",
"gazpacho","potatosouffle","monstertartare","freshfruitcrepes","bonesoup",
"moqueca","potatotornado","mashedpotatoes","asparagussoup","vegstinger",
"bananapop","ceviche","salsa","pepperpopper","baconeggs",
"bonestew","butterflymuffin","dragonpie","fishsticks","fishtacos",
"flowersalad","frogglebunwich","fruitmedley","guacamole","honeyham",
"honeynuggets","hotchili","icecream","jellybean","kabobs",
"mandrakesoup","meatballs","monsterlasagna","perogies","powcake",
"pumpkincookie","ratatouille","stuffedeggplant","taffy","trailmix",
"turkeydinner","unagi","waffles","watermelonicle",

"seafoodgumbo","surfnturf","californiaroll",
"lobsterbisque","lobsterdinner",
"meatysalad","leafymeatsouffle","sweettea","bunnystew",
"bisque","koalefig_trunk","frozenbananadaiquiri","shroomcake",

}

for k,v in pairs(foodnamelist) do
    AddPrefabPostInit(v, function(inst)
        inst:AddTag(v.."_ai")
    end)
    AddPrefabPostInit(v.."_spice_chili", function(inst)
        inst:AddTag(v.."_ai")
    end)
    AddPrefabPostInit(v.."_spice_sugar", function(inst)
        inst:AddTag(v.."_ai")
    end)
    AddPrefabPostInit(v.."_spice_garlic", function(inst)
        inst:AddTag(v.."_ai")
    end)
    AddPrefabPostInit(v.."_spice_salt", function(inst)
        inst:AddTag(v.."_ai")
    end)
end

--独立同名书本，解决与可做书人物冲突的问题
-- AddRecipe("achivbook_birds", {Ingredient("papyrus", 2),Ingredient("bird_egg", 2)},
-- RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
-- "images/inventoryimages.xml", "book_birds.tex",nil,"book_birds")

AddRecipe("achivbook_gardening", {GLOBAL.Ingredient("papyrus", 2), GLOBAL.Ingredient("seeds", 1), GLOBAL.Ingredient("poop", 1)},
RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
"images/inventoryimages.xml", "book_gardening.tex" ,nil,"book_gardening")

-- AddRecipe("achivbook_sleep", {GLOBAL.Ingredient("papyrus", 2), GLOBAL.Ingredient("nightmarefuel", 2)}, 
-- RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
-- "images/inventoryimages.xml", "book_sleep.tex" ,nil,"book_sleep")

-- AddRecipe("achivbook_brimstone", {GLOBAL.Ingredient("papyrus", 2), GLOBAL.Ingredient("redgem", 1)}, 
-- RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
-- "images/inventoryimages.xml", "book_brimstone.tex" ,nil,"book_brimstone")

-- AddRecipe("achivbook_tentacles", {GLOBAL.Ingredient("papyrus", 2), GLOBAL.Ingredient("tentaclespots", 1)}, 
-- RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
-- "images/inventoryimages.xml", "book_tentacles.tex" ,nil,"book_tentacles")

-- AddRecipe("achivbook_meteor2", {GLOBAL.Ingredient("papyrus", 2), GLOBAL.Ingredient("moonrocknugget", 3), GLOBAL.Ingredient("yellowgem", 1)}, 
-- RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
-- "images/inventoryimages/achivbook_meteor.xml", "achivbook_meteor.tex" ,nil,"achivbook_meteor")

-- AddRecipe("achivbook_shakespeare2", {GLOBAL.Ingredient("papyrus", 2), GLOBAL.Ingredient("purplegem", 1), GLOBAL.Ingredient("orangegem", 1)}, 
-- RECIPETABS.MAGIC, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
-- "images/inventoryimages/achivbook_shakespeare.xml", "achivbook_shakespeare.tex" ,nil,"achivbook_shakespeare")

--wickerbottom
AddRecipe("achivbook_meteor", {GLOBAL.Ingredient("papyrus", 2), GLOBAL.Ingredient("moonrocknugget", 3), GLOBAL.Ingredient("yellowgem", 1)}, 
GLOBAL.CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
"images/inventoryimages/achivbook_meteor.xml", "achivbook_meteor.tex" ,nil,"achivbook_meteor")

AddRecipe("achivbook_shakespeare", {GLOBAL.Ingredient("papyrus", 2), GLOBAL.Ingredient("purplegem", 1), GLOBAL.Ingredient("orangegem", 1)}, 
GLOBAL.CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "achivbookbuilder", 
"images/inventoryimages/achivbook_shakespeare.xml", "achivbook_shakespeare.tex" ,nil,"achivbook_shakespeare")

--添加克劳斯背包建造
AddRecipe("klaus_sack", {Ingredient("redmooneye",1),Ingredient("bluemooneye",1),Ingredient("greenmooneye",1)}, RECIPETABS.MAGIC, TECH.NONE, 
"klaussack_placer", --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"achiveking", -- builder_tag
"images/inventoryimages/klaussack.xml", -- atlas
"klaussack.tex") -- image

-- name, ingredients, tab, level, placer, min_spacing, nounlock, numtogive, builder_tag, atlas, image, testfn, product, build_mode, build_distance)

--添加克劳斯背包钥匙建造
AddRecipe("deer_antler1", {Ingredient("boneshard",2),Ingredient("houndstooth",5),Ingredient("silk",5)}, RECIPETABS.MAGIC, TECH.NONE, 
nil, --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"achiveking", -- builder_tag
"images/inventoryimages.xml", -- atlas
"deer_antler1.tex") -- image

--添加生命药水
AddRecipe("halloweenpotion_health_large", {Ingredient("red_cap",3),Ingredient("spidergland",2),Ingredient(GLOBAL.CHARACTER_INGREDIENT.HEALTH,10)}, RECIPETABS.REFINE, TECH.NONE, 
nil, --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"allachivpotion", -- builder_tag
"images/inventoryimages.xml", -- atlas
"halloweenpotion_health_large.tex") -- image

modimport("scripts/Achievement/tags_extension")

--厨师能吃药水  给药水添加tag
AddPrefabPostInit("halloweenpotion_health_large", function(inst)
	inst:AddTag("preparedfood")
end)
AddPrefabPostInit("halloweenpotion_sanity_large", function(inst)
	inst:AddTag("preparedfood")
end)
--添加精神药水
AddRecipe("halloweenpotion_sanity_large", {Ingredient("petals",3),Ingredient("green_cap",1),Ingredient("blue_cap",1)}, RECIPETABS.REFINE, TECH.NONE, 
nil, --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"allachivpotion", -- builder_tag
"images/inventoryimages.xml", -- atlas
"halloweenpotion_sanity_large.tex") -- image

-- --靠谱的胶带
-- AddRecipe("achiv_sewing_tape", {Ingredient("silk",1),Ingredient("cutgrass",3)}, RECIPETABS.SCIENCE, TECH.NONE, 
-- nil, --placer
-- nil, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achivehandyperson", -- builder_tag
-- "images/inventoryimages.xml", -- atlas
-- "sewing_tape.tex",--image
-- nil, -- testfn
-- "sewing_tape")  -- product

-- --添加投石器
-- AddRecipe("achiv_winona_catapult", {Ingredient("sewing_tape",1),Ingredient("twigs",3),Ingredient("rocks",15)}, RECIPETABS.SCIENCE, TECH.NONE, 
-- "winona_catapult_placer", --placer
-- TUNING.WINONA_ENGINEERING_SPACING, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achivehandyperson", -- builder_tag
-- "images/inventoryimages.xml", -- atlas
-- "winona_catapult.tex",nil,"winona_catapult")

-- --聚光灯
-- AddRecipe("achiv_winona_spotlight", {Ingredient("sewing_tape",1),Ingredient("goldnugget",2),Ingredient("fireflies",1)}, RECIPETABS.SCIENCE, TECH.NONE, 
-- "winona_spotlight_placer", --placer
-- TUNING.WINONA_ENGINEERING_SPACING, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achivehandyperson", -- builder_tag
-- "images/inventoryimages.xml", -- atlas
-- "winona_spotlight.tex",nil,"winona_spotlight")

-- --发电机
-- AddRecipe("achiv_winona_battery_low", {Ingredient("sewing_tape",1),Ingredient("log",2),Ingredient("nitre",2)}, RECIPETABS.SCIENCE, TECH.NONE, 
-- "winona_battery_low_placer", --placer
-- TUNING.WINONA_ENGINEERING_SPACING, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achivehandyperson", -- builder_tag
-- "images/inventoryimages.xml", -- atlas
-- "winona_battery_low.tex",nil,"winona_battery_low")

-- --G.E.M发电机
-- AddRecipe("achiv_winona_battery_high", {Ingredient("sewing_tape",1),Ingredient("boards",2),Ingredient("transistor",2)}, RECIPETABS.SCIENCE, TECH.NONE, 
-- "winona_battery_high_placer", --placer
-- TUNING.WINONA_ENGINEERING_SPACING, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achivehandyperson", -- builder_tag
-- "images/inventoryimages.xml", -- atlas
-- "winona_battery_high.tex",nil,"winona_battery_high")

--活木
-- AddRecipe("achiv_livinglog", {Ingredient(GLOBAL.CHARACTER_INGREDIENT.HEALTH, 20)}, RECIPETABS.WAR, TECH.NONE, 
-- nil, --placer
-- nil, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achiveplantkin", -- builder_tag
-- "images/inventoryimages.xml",
-- "livinglog.tex",nil,"livinglog")

-- --荆棘甲
-- AddRecipe("achiv_armor_bramble", {Ingredient("livinglog",2),Ingredient("boneshard",4)}, RECIPETABS.WAR, TECH.NONE, 
-- nil, --placer
-- nil, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achiveplantkin", -- builder_tag
-- "images/inventoryimages/achiv_armor_bramble.xml",
-- "achiv_armor_bramble.tex",nil,"armor_bramble")

-- --荆棘陷阱
-- AddRecipe("achiv_trap_bramble", {Ingredient("livinglog",1),Ingredient("stinger",1)}, RECIPETABS.WAR, TECH.NONE, 
-- nil, --placer
-- nil, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achiveplantkin", -- builder_tag
-- "images/inventoryimages/achiv_trap_bramble.xml",
-- "achiv_trap_bramble.tex",nil,"trap_bramble")

-- --肥料包
-- AddRecipe("achiv_compostwrap", {Ingredient("poop",5),Ingredient("spoiled_food",2), Ingredient("nitre", 1)}, RECIPETABS.WAR, TECH.NONE, 
-- nil, --placer
-- nil, -- min_spacing
-- nil, -- nounlock
-- nil, -- numtogive
-- "achiveplantkin", -- builder_tag
-- "images/inventoryimages/achiv_compostwrap.xml",
-- "achiv_compostwrap.tex",nil,"compostwrap")

--灯泡
AddRecipe("achiv_winter_ornament_light5", {Ingredient("spore_medium",5),Ingredient("goldnugget",3), Ingredient("transistor", 1)}, RECIPETABS.REFINE, TECH.NONE, 
nil,nil,nil,nil,"achive_science","images/inventoryimages.xml",
"winter_ornament_light5.tex",nil,"winter_ornament_light5")
AddRecipe("achiv_winter_ornament_light6", {Ingredient("spore_small",5),Ingredient("goldnugget",3), Ingredient("transistor", 1)}, RECIPETABS.REFINE, TECH.NONE, 
nil,nil,nil,nil,"achive_science","images/inventoryimages.xml",
"winter_ornament_light6.tex",nil,"winter_ornament_light6")
AddRecipe("achiv_winter_ornament_light7", {Ingredient("spore_tall",5),Ingredient("goldnugget",3), Ingredient("transistor", 1)}, RECIPETABS.REFINE, TECH.NONE, 
nil,nil,nil,nil,"achive_science","images/inventoryimages.xml",
"winter_ornament_light7.tex",nil,"winter_ornament_light7")
AddRecipe("achiv_winter_ornament_light8", {Ingredient("lightbulb",5),Ingredient("goldnugget",3), Ingredient("transistor", 1)}, RECIPETABS.REFINE, TECH.NONE, 
nil,nil,nil,nil,"achive_science","images/inventoryimages.xml",
"winter_ornament_light8.tex",nil,"winter_ornament_light8")

--羽毛变换
AddRecipe("achiv_feather_robin_winter_b", {Ingredient("feather_crow",1),Ingredient("charcoal",1), Ingredient("ice", 1)}, RECIPETABS.REFINE, TECH.NONE, 
nil,nil,nil,nil,"achive_science","images/inventoryimages.xml",
"feather_robin_winter.tex",nil,"feather_robin_winter")

--元宝
AddRecipe("achiv_lucky_goldnugget", {Ingredient("goldnugget",5)}, RECIPETABS.REFINE, TECH.NONE, 
nil,nil,nil,5,"achive_science","images/inventoryimages.xml",
"lucky_goldnugget.tex",nil,"lucky_goldnugget")

--羽毛变换
AddRecipe("achiv_feather_robin_winter_c", {Ingredient("feather_robin",1),Ingredient("charcoal",1), Ingredient("ice", 1)}, RECIPETABS.REFINE, TECH.NONE, 
nil,nil,nil,nil,"achive_science","images/inventoryimages.xml",
"feather_robin_winter.tex",nil,"feather_robin_winter")

--节日欢愉
AddRecipe("achiv_wintersfeastfuel", {Ingredient("lightbulb",8),Ingredient("moon_tree_blossom",3), Ingredient("purplegem", 1)}, RECIPETABS.REFINE, TECH.NONE, 
nil,nil,nil,3,"achive_science","images/inventoryimages2.xml",
"wintersfeastfuel.tex",nil,"wintersfeastfuel")

--圣诞节食物科技
AddRecipe("achiv_wintersfeastoven", {Ingredient("cutstone", 1), Ingredient("marble", 1), Ingredient("log", 1)}, RECIPETABS.TOWN, TECH.NONE, 
"wintersfeastoven_placer",
nil,nil,nil,"achive_science","images/inventoryimages2.xml",
"wintersfeastoven.tex",nil,"wintersfeastoven")

--餐桌
AddRecipe("achiv_table_winters_feast", {Ingredient("boards", 1), Ingredient("beefalowool", 1)}, RECIPETABS.TOWN, TECH.NONE, 
"wintersfeastoven_placer",
nil,nil,nil,"achive_science","images/inventoryimages2.xml",
"table_winters_feast.tex",nil,"table_winters_feast")

AddRecipe("ancient_altar", {Ingredient("thulecite", 15), Ingredient("cutstone", 20), Ingredient("purplegem", 2)}, GLOBAL.RECIPETABS.MAGIC, TECH.NONE, 
"ancient_altar_placer", --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"ancientstation", -- builder_tag
"images/inventoryimages/altar.xml", -- atlas
"altar.tex") -- image

AddRecipe("achievement_moonbase", {Ingredient("moonrocknugget", 20), Ingredient("cutstone", 10), Ingredient("purplegem", 2)}, GLOBAL.RECIPETABS.MAGIC, TECH.NONE, 
"moonbase_placer", --placer
nil, -- min_spacing
nil, -- nounlock
nil, -- numtogive
"moonstone", -- builder_tag
"images/inventoryimages/moonbase.xml", -- atlas
"moonbase.tex") -- image

AddRecipe2("achievement_leif_idol",					{Ingredient("cutgrass", 3), Ingredient("livinglog", 2), Ingredient("nightmarefuel", 5)},		TECH.NONE,				{builder_tag="leifidolcrafter"})
AddRecipe2("achievement_woodie_boards",				{Ingredient("log", 3)}, 													TECH.NONE,				{builder_tag="woodcarver1", sg_state="carvewood_boards", product="boards",  description="boards",  no_deconstruction=true,})
AddRecipe2("achievement_woodcarvedhat",				{Ingredient("log", 6), Ingredient("pinecone", 1)}, 						TECH.NONE,				{builder_tag="woodcarver2", sg_state="carvewood"})
AddRecipe2("achievement_walking_stick",				{Ingredient("log", 3), Ingredient("charcoal", 1)},						TECH.NONE,				{builder_tag="woodcarver3", sg_state="carvewood"})

-- 炼金科技(alchemytechnology) 修复：官方 transmute 配方已从 builder_tag 迁移到 builder_skill="wilson_alchemy_N"/"wilson_allegiance_*"，
-- 只能靠 skilltreeupdater:IsActivated 解锁，加标签无效(见 builder.lua)。这里用 mod 自己的 builder_tag="alchemist"
-- 重新注册一份(新名 achiv_transmute_*)，alchemytechnologyfn 本就会给玩家加 "alchemist" 标签。材料/产物/数量照抄官方 recipes.lua。
local ACHIV_TRANSMUTES = {
    { "log",               { Ingredient("twigs", 3) } },
    { "twigs",             { Ingredient("log", 1) }, 2 },
    { "bluegem",           { Ingredient("redgem", 2) } },
    { "redgem",            { Ingredient("bluegem", 2) } },
    { "purplegem",         { Ingredient("bluegem", 1), Ingredient("redgem", 1) } },
    { "orangegem",         { Ingredient("purplegem", 3) } },
    { "yellowgem",         { Ingredient("orangegem", 3) } },
    { "greengem",          { Ingredient("yellowgem", 3) } },
    { "opalpreciousgem",   { Ingredient("yellowgem", 1), Ingredient("orangegem", 1), Ingredient("greengem", 1), Ingredient("purplegem", 1), Ingredient("redgem", 1), Ingredient("bluegem", 1) } },
    { "flint",             { Ingredient("rocks", 3) } },
    { "rocks",             { Ingredient("flint", 2) } },
    { "goldnugget",        { Ingredient("nitre", 3) } },
    { "nitre",             { Ingredient("goldnugget", 2) } },
    { "marble",            { Ingredient("cutstone", 2) } },
    { "cutstone",          { Ingredient("marble", 1) } },
    { "moonrocknugget",    { Ingredient("marble", 2) } },
    { "meat",              { Ingredient("smallmeat", 3) } },
    { "smallmeat",         { Ingredient("meat", 1) }, 2 },
    { "beardhair",         { Ingredient("beefalowool", 2) } },
    { "beefalowool",       { Ingredient("beardhair", 2) } },
    { "boneshard",         { Ingredient("houndstooth", 2) } },
    { "houndstooth",       { Ingredient("boneshard", 2) } },
    { "poop",              { Ingredient("spoiled_food", 6) } },
    { "horrorfuel",        { Ingredient("dreadstone", 1) }, 2 },
    { "dreadstone",        { Ingredient("horrorfuel", 3) } },
    { "nightmarefuel",     { Ingredient("horrorfuel", 1) }, 2 },
    { "purebrilliance",    { Ingredient("moonglass_charged", 3) } },
    { "moonglass_charged", { Ingredient("purebrilliance", 1) }, 2 },
}
for _, t in GLOBAL.ipairs(ACHIV_TRANSMUTES) do
    AddRecipe2("achiv_transmute_" .. t[1], t[2], TECH.NONE, {
        product = t[1],
        builder_tag = "alchemist",
        numtogive = t[3],
        description = "transmute_" .. t[1],
    })
end

-- 植物好友(plantfriend) 修复：Wormwood 植物配方已从 builder_tag 迁移到 builder_skill="wormwood_*crafting"(recipes.lua)，
-- mod 加的 berrybushcrafter/saplingcrafter 等旧标签全失效。这里用 mod 自己授予的 builder_tag="plantkin"(plantfriendfn 会加且仍有效)
-- 重新注册一份。form_* 种植 SG 状态在通用 SGwilson 里，任意角色都能用。材料/产物/sg_state 照抄官方。
local _H = GLOBAL.CHARACTER_INGREDIENT.HEALTH
AddRecipe2("achiv_wormwood_ipecacsyrup",   {Ingredient("red_cap",1), Ingredient("honey",1), Ingredient("spoiled_food",1)},        TECH.NONE, {builder_tag="plantkin", product="ipecacsyrup", allowautopick=true})
AddRecipe2("achiv_wormwood_sapling",       {Ingredient(_H,5), Ingredient("twigs",5)},                                             TECH.NONE, {builder_tag="plantkin", product="dug_sapling_moon",    sg_state="form_moon",   actionstr="GROW", allowautopick=true, no_deconstruction=true, description="wormwood_sapling"})
AddRecipe2("achiv_wormwood_berrybush",     {Ingredient(_H,10), Ingredient("spoiled_food",3), Ingredient("berries_juicy",8)},      TECH.NONE, {builder_tag="plantkin", product="dug_berrybush",       sg_state="form_bush",   actionstr="GROW", allowautopick=true, no_deconstruction=true, description="wormwood_berrybush"})
AddRecipe2("achiv_wormwood_berrybush2",    {Ingredient(_H,10), Ingredient("spoiled_food",3), Ingredient("berries_juicy",8)},      TECH.NONE, {builder_tag="plantkin", product="dug_berrybush2",      sg_state="form_bush2",  actionstr="GROW", allowautopick=true, no_deconstruction=true, description="wormwood_berrybush2"})
AddRecipe2("achiv_wormwood_juicyberrybush",{Ingredient(_H,10), Ingredient("spoiled_food",3), Ingredient("berries",8)},             TECH.NONE, {builder_tag="plantkin", product="dug_berrybush_juicy", sg_state="form_juicy",  actionstr="GROW", allowautopick=true, no_deconstruction=true, description="wormwood_juicyberrybush"})
AddRecipe2("achiv_wormwood_reeds",         {Ingredient(_H,15), Ingredient("cave_banana",1), Ingredient("cutreeds",4)},            TECH.NONE, {builder_tag="plantkin", product="dug_monkeytail",      sg_state="form_monkey", actionstr="GROW", allowautopick=true, no_deconstruction=true, description="wormwood_reeds"})
AddRecipe2("achiv_wormwood_lureplant",     {Ingredient(_H,25), Ingredient("compostwrap",2), Ingredient("plantmeat",5)},           TECH.NONE, {builder_tag="plantkin", product="lureplantbulb",       sg_state="form_bulb",   actionstr="GROW", allowautopick=true, no_deconstruction=true, description="wormwood_lureplantbulb"})


local function CanSoulhop(inst, souls)
    if inst.replica.inventory:Has("wortox_soul", souls or 1) then
        local rider = inst.replica.rider
        if rider == nil or not rider:IsRiding() then
            return true
        end
    end
    return false
end

local function _init_ability_net_var(inst)
    for _,v in pairs(achievement_ability_config.ability_cost) do
        local current = "current" .. v.ability
        inst[current] = GLOBAL.net_shortint(inst.GUID,current)
    end
end

local function _init_attribute_net_var(inst)
    for attribute, _ in pairs(achievement_ability_config.attributes_cost) do
        local current = "current" .. attribute
		inst[current] = GLOBAL.net_shortint(inst.GUID, current)
	end
end


local function SavePlayerOldData(inst)
    if inst.components.achievementability and inst.components.achievementmanager then
        inst.components.achievementability:OnSave()
        inst.components.achievementmanager:OnSave()
        -- local achievementabilityPersist = inst.components.achievementability:OnSave()
        -- local achievementmanagerPersist = inst.components.achievementmanager:OnSave()
        -- GLOBAL.TheWorld.achievementPersist = {}
        -- GLOBAL.TheWorld.achievementPersist[inst.userid] =
        -- {
        --     ["SaveForReroll"] = inst.SaveForReroll ~= nil and inst:SaveForReroll() or nil,
        --     ["achievementabilityPersist"] = achievementabilityPersist,
        --     ["achievementmanagerPersist"] = achievementmanagerPersist,
        -- }

        if inst.prefab ~= "walter" then
            if inst.woby ~= nil then
                inst.woby:OnPlayerLinkDespawn()
            end
        end
        
        if inst.prefab ~= "wendy" then
            local abigail = inst.components.ghostlybond and inst.components.ghostlybond.ghost
            if abigail then
                abigail:RemoveFromScene()
            end
        end
    end
end

--预运行
-- ============ 技能树能力桥接 (skilltree ability bridge) ============
-- 目标:让"成就授予的官方技能"被视为已激活,从而 ①查 IsActivated 的服务端被动技能(如火把时长/亮度、薇诺娜建筑升级)生效
-- ②带 onactivate 的技能执行其逻辑。③(Route B 客户端同步,见下方反查表)让客户端 IsActivated 也返回 true,
-- 使官方 builder_skill 配方(眼镜/储物机器人/传送)+遥控器法术图标自动可用,无需重注册配方。
local SKILLTREE_DEFS = require("prefabs/skilltree_defs").SKILLTREE_DEFS

-- skill -> ability 反查表: 客户端没有 _achiv_skills(服务端字段不同步),改用已同步的 current<ability> netvar 判定。
-- 让客户端的 IsActivated 也能对"成就授予的技能"返回 true,从而 ①遥控器法术图标 ②builder_skill 配方显示
-- ③投石机元素齐射瞄准预览 在客户端正常工作(均在客户端读 skilltreeupdater:IsActivated)。
local _achiv_skill2ability = {}
for _, v in GLOBAL.pairs(achievement_ability_config.ability_cost) do
    if v.skilltree ~= nil then
        for _, skill in GLOBAL.ipairs(v.skilltree.skills) do
            _achiv_skill2ability[skill] = v.ability
        end
    end
end

AddComponentPostInit("skilltreeupdater", function(self)
    local base_IsActivated = self.IsActivated
    function self:IsActivated(skill)
        local inst = self.inst
        -- 服务端权威: _achiv_skills(AchivGrantSkills 设置)
        local granted = inst._achiv_skills
        if granted ~= nil and granted[skill] then
            return true
        end
        -- 客户端(及服务端冗余): 经已同步的能力标志位反查
        local ab = _achiv_skill2ability[skill]
        if ab ~= nil then
            local nv = inst["current" .. ab]
            if nv ~= nil and nv:value() ~= 0 then
                return true
            end
        end
        return base_IsActivated(self, skill)
    end
end)

-- 授予一组官方技能(char=源角色名, skills=技能名数组, recipes=可选,需 AddRecipe 学会的配方名数组)。服务端调用。
function GLOBAL.AchivGrantSkills(inst, char, skills, recipes)
    if inst._achiv_skills == nil then inst._achiv_skills = {} end
    local defs = SKILLTREE_DEFS[char]
    for _, skill in GLOBAL.ipairs(skills) do
        inst._achiv_skills[skill] = true
        local def = defs ~= nil and defs[skill] or nil
        if def ~= nil and def.onactivate ~= nil then
            def.onactivate(inst, false)
        end
    end
    -- TECH.LOST 配方(薇机人/传送伞/传送垫): builder_skill 门已由 IsActivated 桥接放行,但科技门(LOST不可达)仍挡;
    -- AddRecipe 加入已学列表(builder.lua:878 命中→绕过科技门),并同步 replica 供客户端 KnowsRecipe。
    if recipes ~= nil and inst.components.builder ~= nil then
        for _, r in GLOBAL.ipairs(recipes) do
            inst.components.builder:AddRecipe(r)
        end
    end
    inst:PushEvent("onactivateskill_server", {}) -- 通知已装备物品重算被动技能
    -- 通知客户端刷新制作菜单: builder_skill 配方(眼镜/储物机器人/传送)显示靠客户端 IsActivated,
    -- 而 current<ability> netvar 更新不会自动刷craft菜单,这里主动 push 让新配方立即出现。
    if inst._achiv_craftrefresh ~= nil then
        inst._achiv_craftrefresh:push()
    end
end

-- 收回一组官方技能(recipes=可选,需 RemoveRecipe 的配方名数组)。服务端调用。
function GLOBAL.AchivRevokeSkills(inst, char, skills, recipes)
    if inst._achiv_skills == nil then return end
    local defs = SKILLTREE_DEFS[char]
    for _, skill in GLOBAL.ipairs(skills) do
        local def = defs ~= nil and defs[skill] or nil
        if def ~= nil and def.ondeactivate ~= nil then
            def.ondeactivate(inst, false)
        end
        inst._achiv_skills[skill] = nil
    end
    if recipes ~= nil and inst.components.builder ~= nil then
        for _, r in GLOBAL.ipairs(recipes) do
            inst.components.builder:RemoveRecipe(r)
        end
    end
    inst:PushEvent("ondeactivateskill_server", {})
end

AddPlayerPostInit(function(inst)
    inst._achiv_skills = {}
    _init_ability_net_var(inst)
    _init_attribute_net_var(inst)
    inst.currentcoinamount = GLOBAL.net_shortint(inst.GUID,"currentcoinamount")
    inst.currentkillamount = GLOBAL.net_uint(inst.GUID,"currentkillamount")--杀戮值
    inst.currentattributepointamount =  GLOBAL.net_uint(inst.GUID,"currentattributepointamount")--属性点
    inst.currentresetamount =  GLOBAL.net_shortint(inst.GUID,"currentresetamount")
    inst.currentusedresetamount =  GLOBAL.net_shortint(inst.GUID,"currentusedresetamount")
    -- 制作菜单刷新信号(服务端→客户端): 移除能力摘掉 builder_tag 后,服务端 PushEvent 到不了客户端 HUD,
    -- 用 net_event 让客户端自己 push refreshcrafting,隐藏不可造的配方。
    inst._achiv_craftrefresh = GLOBAL.net_event(inst.GUID, "achiv_craftrefresh")
    inst:ListenForEvent("achiv_craftrefresh", function(inst)
        if inst.HUD ~= nil then
            inst:PushEvent("refreshcrafting")
        end
    end)
    for _,v in pairs(achievement_config.idconfig) do
        if v.id == "a_4" or v.id == "angry" then
            inst[v.check] = GLOBAL.net_shortint(inst.GUID,v.check)
            inst[v.current] = GLOBAL.net_uint(inst.GUID,v.current)
        else
            inst[v.check] = GLOBAL.net_shortint(inst.GUID,v.check)
            inst[v.current] = GLOBAL.net_shortint(inst.GUID,v.current)
        end
    end

    inst:AddComponent("achievementability")
    --inst.components.achievementmanager.a_a1=false
    inst:AddComponent("achievementmanager")
	if not GLOBAL.TheNet:GetIsClient() then     
        inst.components.achievementmanager:Init(inst)
        inst.components.achievementability:Init(inst)
    end
    
    --除了温蒂以外  添加 阿比盖尔徽章
    local WendyFlowerOver = require("widgets/wendyflowerover")
    local function OnBondLevelDirty(inst)
        if inst.HUD ~= nil and not inst:HasTag("playerghost") then
            local bond_level = inst._bondlevel:value()
            if bond_level > 1 then
                if inst.HUD.wendyflowerover ~= nil then
                    inst.HUD.wendyflowerover:Play( bond_level )
                end
            end
        end
    end

    local function OnPlayerDeactivated(inst)
        inst:RemoveEventCallback("onremove", OnPlayerDeactivated)
        if not GLOBAL.TheWorld.ismastersim then
            inst:RemoveEventCallback("_bondleveldirty", OnBondLevelDirty)
        end
    end

    local function OnClientPetSkinChanged(inst)
        if inst.HUD ~= nil and inst.HUD.wendyflowerover ~= nil then
            local skinname = GLOBAL.TheInventory:LookupSkinname( inst.components.pethealthbar._petskin:value() )
            inst.HUD.wendyflowerover:SetSkin( skinname ) 
        end
    end
    local function PetHealthbadgeTask(inst)
        if (not inst.currentghostly_friend) or inst.currentghostly_friend:value() == 0 then
            inst.HUD.controls.status.pethealthbadge:Hide()
        else 
            inst.HUD.controls.status.pethealthbadge:Show()
        end
    end
    local function OnPlayerActivated(inst)
        if inst == GLOBAL.ThePlayer then
            if inst.HUD.wendyflowerover == nil and inst.components.pethealthbar ~= nil and inst.currentghostly_friend then
                inst.HUD.wendyflowerover = inst.HUD.overlayroot:AddChild(WendyFlowerOver(inst))
                inst.HUD.wendyflowerover:MoveToBack()
                OnClientPetSkinChanged( inst )
            end

            inst:ListenForEvent("onremove", OnPlayerDeactivated)
            if not GLOBAL.TheWorld.ismastersim then
                inst:ListenForEvent("_bondleveldirty", OnBondLevelDirty)
            end
            inst:DoPeriodicTask(3, PetHealthbadgeTask)
        end
    end
    if  inst.prefab ~= "wendy" then
        inst:AddTag("ghostlyfriend")
        inst:AddTag("elixirbrewer")

        if not inst.components.pethealthbar then
            inst:AddComponent("pethealthbar")
        end
        inst._bondlevel = GLOBAL.net_tinybyte(inst.GUID, "wendy._bondlevel", "_bondleveldirty")
        inst:ListenForEvent("playeractivated", OnPlayerActivated)
        inst:ListenForEvent("playerdeactivated", OnPlayerDeactivated)
        inst:ListenForEvent("clientpetskindirty", OnClientPetSkinChanged)
    end
    local PetHealthBadge = require "widgets/pethealthbadge"
    AddClassPostConstruct("widgets/statusdisplays", function(self)
        function self:RefreshPetHealth2()
            if self.owner.currentghostly_friend:value() ~= 0 then
                self.pethealthbadge:Show()
            end
            local pethealthbar = self.owner.components.pethealthbar
            self.pethealthbadge:SetValues(pethealthbar:GetSymbol(), pethealthbar:GetPercent(), pethealthbar:GetOverTime(), pethealthbar:GetMaxHealth(), pethealthbar:GetPulse())
            pethealthbar:ResetPulse()
        end

        if not self.owner or self.owner.prefab == "wendy" then return end
        if self.owner.components.pethealthbar ~= nil then
            self.pethealthbadge = self:AddChild(PetHealthBadge(self.owner, { 254 / 255, 253 / 255, 237 / 255, 1 }, "status_abigail"))
            self.pethealthbadge:SetPosition(60, -100, 0)
            self.pethealthbadge:SetValues(0, 0, 1, 1, 1)
            self.pethealthbadge:Hide()
            if self.pethealthbadge ~= nil and self.onpethealthdirty == nil then
                self.onpethealthdirty = function() self:RefreshPetHealth2() end
                inst:ListenForEvent("clientpethealthdirty", self.onpethealthdirty, self.owner)
                inst:ListenForEvent("clientpethealthsymboldirty",  self.onpethealthdirty, self.owner)
                inst:ListenForEvent("clientpetmaxhealthdirty", self.onpethealthdirty, self.owner)
                inst:ListenForEvent("clientpethealthpulsedirty", self.onpethealthdirty, self.owner)
                inst:ListenForEvent("clientpethealthstatusdirty", self.onpethealthdirty, self.owner)
                self:RefreshPetHealth2()
            end
        end
    end)

    local function OnSetSpecialActions(inst, data)
        inst:DoTaskInTime(1, function(inst, data)
            if inst.components.achievementability and inst.components.achievementability.soulhopcopy == true then
                inst:AddTag("soulstealer")
            else
                inst:RemoveTag("soulstealer")
            end
            if inst.components.playeractionpicker ~= nil then
                local old_pointspecialactionsfn = inst.components.playeractionpicker.pointspecialactionsfn
                if old_pointspecialactionsfn then
                    inst.components.playeractionpicker.pointspecialactionsfn=function(inst, pos, useitem, right)
                        if right and useitem == nil and inst.CanSoulhop and inst:CanSoulhop() then

                            local equipitem = inst.replica.inventory and inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                            if equipitem == nil or equipitem.components.aoetargeting == nil or not equipitem.components.aoetargeting:IsEnabled() then
                                return {ACTIONS.BLINK}
                            end
                        end
                        return old_pointspecialactionsfn(inst, pos, useitem, right)
                    end
                else
                    inst.components.playeractionpicker.pointspecialactionsfn=function(inst, pos, useitem, right)
                        if right and useitem == nil and inst.CanSoulhop and inst:CanSoulhop() then
                            local equipitem = inst.replica.inventory and inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                            if equipitem == nil or equipitem.components.aoetargeting == nil or not equipitem.components.aoetargeting:IsEnabled() then
                                return {ACTIONS.BLINK}
                            end
                        end
                        return {}
                    end
                end
            end
        end)
    end

    if inst.prefab ~= "wortox" then
        inst.CanSoulhop = CanSoulhop
        inst.boolsoulhop = GLOBAL.net_bool(inst.GUID, "boolsoulhop", "boolsoulhopdirty")
        inst:ListenForEvent("boolsoulhopdirty", OnSetSpecialActions)
        inst:ListenForEvent("setowner", OnSetSpecialActions)
        inst:ListenForEvent("inmightygym", OnSetSpecialActions)
        inst:ListenForEvent("weremodedirty", OnSetSpecialActions)
        inst:ListenForEvent("ms_respawnedfromghost", OnSetSpecialActions)
    end
    -- 修复: 这些"能力专属"建造标签曾被无条件加给所有非本角色玩家(依赖 dealSpecialTags 事后移除,但新角色/未触发load时不可靠),
    -- 导致人人能造对应物品(如 handyperson→薇诺娜胶带/电池/投石机)。已注释: 各标签由其能力自身授予并在重置时移除:
    --   handyperson←fastbuild(fastbuildfn), slingshot_sharpshooter←fearless(warlter_common_postinit), pocketwatchcaster←timemanager。
    -- if inst.prefab ~= "walter" then
    --     inst:AddTag("slingshot_sharpshooter")
    -- end
    -- if inst.prefab ~= "wanda" then
    --     inst:AddTag("pocketwatchcaster")
    -- end
    -- if inst.prefab ~= "winona" then
    --     inst:AddTag("handyperson")
    -- end

    if inst.OnNewSpawn then
        local function OnPlayerNewSpawn(inst)
            inst.components.achievementability:OnInitSpecialAbility()
           -- inst.components.achievementmanager:OnInitSpecialAbility()
        end
        inst:DoTaskInTime(1, OnPlayerNewSpawn)
    end

    local OldChangeToMonkey = inst.ChangeToMonkey
    local NewChangeToMonkey = function(inst)
        SavePlayerOldData(inst)
        if OldChangeToMonkey then
            return OldChangeToMonkey(inst)
        end
    end
    local OldChangeFromMonkey = inst.ChangeFromMonkey
    local NewChangeFromMonkey = function(inst)
        SavePlayerOldData(inst)
        if OldChangeFromMonkey then
            return OldChangeFromMonkey(inst)
        end
    end

    inst.ChangeToMonkey = NewChangeToMonkey
    inst.ChangeFromMonkey = NewChangeFromMonkey

    if SHOW_TITLE then
        local function updateTitle(inst)
            local level,cur_exp,next_exp = 0,0,0
            if inst.components.achievementmanager then
                level = inst.components.achievementmanager:getLevel()
                cur_exp,next_exp = inst.components.achievementmanager:getExp()
            end
            if inst.title == nil then 
                inst.title = GLOBAL.SpawnPrefab("title") 
                inst.title.entity:SetParent(inst.entity) 
                inst.title:SetText(inst:GetDisplayName(),level) 
                --inst.title:SetTexture(level)
            end 
            local title = ""
            local phase = math.floor(level/10) + 1
            if phase > #STRINGS.TITLE then
                title = STRINGS.TITLE[#STRINGS.TITLE]
            else
                title =  STRINGS.TITLE[phase]
            end
            local titleinfo = string.format(STRINGS.TITLE_INFO,title,level,cur_exp,next_exp,inst:GetDisplayName() or "")
            inst.title:SetText(titleinfo,level) 
            --inst.title:SetTexture(level)
        end
        inst:DoPeriodicTask(2,function() 
            updateTitle(inst) 
        end) 
        updateTitle(inst) 
    end
end)

--UI尺寸
local function PositionUI(self, screensize)
	local hudscale = self.top_root:GetScale()
	self.uiachievement:SetScale(.75*hudscale.x,.75*hudscale.y,1)
end

--UI
local uiachievement = require("widgets/uiachievement")
local function Adduiachievement(self)
    self.uiachievement = self.top_root:AddChild(uiachievement(self.owner))
    local screensize = {GLOBAL.TheSim:GetScreenSize()}
    PositionUI(self, screensize)
    self.uiachievement:SetHAnchor(0)
    self.uiachievement:SetVAnchor(0)
    --H: 0=中间 1=左端 2=右端
    --V: 0=中间 1=顶端 2=底端
    self.uiachievement:MoveToFront()
    local OnUpdate_base = self.OnUpdate
    self.OnUpdate = function(self, dt)
        OnUpdate_base(self, dt)
        local curscreensize = {GLOBAL.TheSim:GetScreenSize()}
        if curscreensize[1] ~= screensize[1] or curscreensize[2] ~= screensize[2] then
            PositionUI(self, curscreensize)
            screensize = curscreensize
        end
    end
end

AddClassPostConstruct("widgets/controls", Adduiachievement)
GLOBAL.TheInput:AddKeyDownHandler(
    GLOBAL.KEY_N,
    function()
        if can_hide_hud then
            if not GLOBAL.TheWorld.ismastersim and not GLOBAL.ThePlayer.HUD:HasInputFocus() then
                if GLOBAL.ThePlayer.HUD.controls.uiachievement and GLOBAL.ThePlayer.HUD.controls.uiachievement:IsVisible() then
                    GLOBAL.ThePlayer.HUD.controls.uiachievement:Hide()
                else
                    GLOBAL.ThePlayer.HUD.controls.uiachievement:Show()
                    if GLOBAL.ThePlayer.HUD.controls.uiachievement.mainui.bg.allcoin.shown then
                    else
                        GLOBAL.ThePlayer.HUD.controls.uiachievement.mainui.bg.title_1.onclick()
                    end
                end
            end
        end
    end,
    false
)

AddPrefabPostInit("moon_cap", function(inst)
    local function mooncap_oneaten(inst, eater)
        if not (eater.components.freezable and eater.components.freezable:IsFrozen()) and
                not (eater.components.pinnable and eater.components.pinnable:IsStuck()) and
                not (eater.components.fossilizable and eater.components.fossilizable:IsFossilized()) then
    
            local sleeptime = TUNING.MOON_MUSHROOM_SLEEPTIME
    
            local mount = (eater.components.rider ~= nil and eater.components.rider:GetMount()) or nil
            if mount then
                mount:PushEvent("ridersleep", { sleepiness = 4, sleeptime = sleeptime })
            end
    
            if (eater.components.skilltreeupdater and eater.components.skilltreeupdater:IsActivated("wormwood_moon_cap_eating")) or (eater.components.achievementability and eater.components.achievementability.plantfriend) then
                local cloud = SpawnPrefab("sleepcloud_lunar")
                cloud.Transform:SetPosition(eater.Transform:GetWorldPosition())
                cloud:SetOwner(eater)
            elseif eater.components.sleeper then
                eater.components.sleeper:AddSleepiness(4, sleeptime)
            elseif eater.components.grogginess then
                eater.components.grogginess:AddGrogginess(2, sleeptime)
            else
                eater:PushEvent("knockedout")
            end
        end
    end
    if GLOBAL.TheWorld.ismastersim then
        inst.components.edible:SetOnEatenFn(mooncap_oneaten)
    end
end)
AddPrefabPostInit("mushroom_farm", function(inst)
    local function accepttest(inst, item, giver)
        if item == nil then
            return false
        elseif inst.remainingharvests == 0 then
            if item.prefab == "livinglog" then -- only livinglog for now because that is the recipe
                return true
            end
            return false, "MUSHROOMFARM_NEEDSLOG"
        elseif not (item:HasTag("mushroom") or item:HasTag("spore")) then
            return false, "MUSHROOMFARM_NEEDSSHROOM"
        elseif item:HasTag("moonmushroom") then
            local grower_skilltreeupdater = giver.components.skilltreeupdater
            if (grower_skilltreeupdater and grower_skilltreeupdater:IsActivated("wormwood_moon_cap_eating")) or (giver.components.achievementability and giver.components.achievementability.plantfriend) then
                return true
            else
                return false, "MUSHROOMFARM_NOMOONALLOWED"
            end
        else
            return true
        end
    end

    if GLOBAL.TheWorld.ismastersim then
        inst.components.trader:SetAbleToAcceptTest(accepttest)
    end
end)


--欧皇检测
AddPrefabPostInit("krampus_sack", function(inst)
    inst:AddComponent("ksmark")
end)
AddPrefabPostInit("ancient_altar", function(inst)
    inst:AddComponent("ksmark")
end)

-- 修复鱼人伪装(成就 murlocdisguise): 青蛙用 FindEntities 的 CANT_TAGS={"merm"} 排除鱼人,
-- 但对运行时(成就伪装)新加到玩家身上的 merm 标签不生效(C++ 标签过滤问题)。官方鱼人是用 Lua HasTag 判定才生效。
-- 这里 hook 青蛙,用 Lua HasTag 在 retarget/keeptarget 里排除带 merm 标签的玩家,使其不被青蛙锁定/攻击。
AddPrefabPostInit("frog", function(inst)
    local combat = inst.components.combat
    if combat == nil then return end -- 客户端无 combat 组件,直接跳过
    local old_retarget = combat.targetfn -- 注意: SetRetargetFunction 存到 combat.targetfn(不是retargetfn)
    if old_retarget ~= nil then
        combat:SetRetargetFunction(combat.retargetperiod or 3, function(i)
            local t = old_retarget(i)
            if t ~= nil and t:HasTag("merm") then return nil end
            return t
        end)
    end
    local old_keep = combat.keeptargetfn
    combat:SetKeepTargetFunction(function(i, target)
        if target ~= nil and target:HasTag("merm") then return false end
        return old_keep == nil or old_keep(i, target)
    end)
end)

AddStategraphPostInit("wilson", function(inst)
    local deststatepick = inst.actionhandlers[ACTIONS.PICK].deststate
    inst.actionhandlers[ACTIONS.PICK].deststate = function(inst, action, ...)
        if inst and inst:HasTag("fastpicker") then
            if action.target then
                if action.target.prefab ~= "junk_pile_big" and action.target.prefab ~= "berrybush_juicy" then
                    return "doshortaction"
                end
            else
                return "doshortaction"
            end
        end
        if type(deststatepick) == "string" then
            return deststatepick
        else
            return deststatepick(inst, action, ...)
        end
    end
    local deststatetakeitem = inst.actionhandlers[ACTIONS.TAKEITEM].deststate
    inst.actionhandlers[ACTIONS.TAKEITEM].deststate = function(inst, action, ...)
        if inst and inst:HasTag("fastpicker") then
            if action.target then
                if action.target.prefab ~= "junk_pile_big" and action.target.prefab ~= "berrybush_juicy" then
                    return "doshortaction"
                end
            else
                return "doshortaction"
            end
        end
        if type(deststatetakeitem) == "string" then
            return deststatetakeitem
        else
            return deststatetakeitem(inst, action, ...)
        end
    end
    local deststateharvest = inst.actionhandlers[ACTIONS.HARVEST].deststate
    inst.actionhandlers[ACTIONS.HARVEST].deststate = function(inst, action, ...)
        if inst and inst:HasTag("fastpicker") then
            if action.target then
                if action.target.prefab ~= "junk_pile_big" and action.target.prefab ~= "berrybush_juicy" then
                    return "doshortaction"
                end
            else
                return "doshortaction"
            end
        end
        if type(deststateharvest) == "string" then
            return deststateharvest
        else
            return deststateharvest(inst, action, ...)
        end
    end
end)
GLOBAL.package.loaded["stategraphs/SGwilson"] = nil

--阿比盖尔杀死怪物   leader也增加exp和killamount
local abigail_kill = function(inst, data)
    local leader = nil
    if inst.components.follower and  inst.components.follower.leader then
        leader = inst.components.follower.leader
    end
    if leader and  leader.components.achievementability.level == true  and leader:HasTag("player") then
        if data.victim and data.victim.components.combat and leader.achivhaskill == nil then 
            leader.components.achievementability:calc_killamount(leader,data)
            --leader.components.achievementmanager:checkGetSoul(leader, data)
            leader.components.achievementmanager:checkkill(leader,data.victim)
            leader.components.achievementmanager:check_kill_exp(leader,data.victim)
        end 
    end
end

AddPrefabPostInit("abigail", function(inst)
    inst:ListenForEvent("killed", abigail_kill)    
end)

--成就：daywalker/sharkboi 这类不会 0 血死亡、而是在 minhealth(被击败)触发的 Boss，给攻击者记成就。
--旧实现是全局覆盖 health:SetVal，会丢掉官方 SetVal 的尸化(corpsing)/erode_task 等新逻辑，破坏全服所有怪物。
--改为监听官方在跌到 minhealth 时本就会 push 的 "minhealth" 事件，非侵入。
local function OnAchivBossDefeated(inst)
    if inst._achiv_defeated then return end
    inst._achiv_defeated = true
    if inst.attacker_userid and inst.attacker_userid[1] then
        local attacker = UserToPlayer(inst.attacker_userid[1])
        if attacker ~= nil and attacker.components.achievementmanager ~= nil then
            attacker.components.achievementmanager:OnKilledCheck(attacker, { victim = inst })
        end
    end
end
for _, prefab in ipairs({ "daywalker", "daywalker2", "sharkboi" }) do
    AddPrefabPostInit(prefab, function(inst)
        inst:ListenForEvent("minhealth", OnAchivBossDefeated)
    end)
end
----------------------------------------------------------------------------------------------------
--BOSS SKILL
---是否加强-------------------------------------------------------------------

if TUNING.BOSSSUP  then
    local function AI_DropItem(inst,target,equippeditem)
        if equippeditem then
            local angle_num = -10
            local item_temp = GLOBAL.EQUIPSLOTS.HANDS
            if equippeditem == "HEAD" then
                angle_num = -40
                item_temp =  GLOBAL.EQUIPSLOTS.HEAD
            end
            if equippeditem == "BODY" then
                angle_num = 20
                item_temp =  GLOBAL.EQUIPSLOTS.BODY
            end
            local item = nil
            if target and target.components.inventory then
                item = target.components.inventory:GetEquippedItem(item_temp)
            end
            if item and item.Physics then
                target.components.inventory:DropItem(item)
                local x, y, z = item:GetPosition():Get()
                y = .1
                item.Physics:Teleport(x,y,z)
                local hp = target:GetPosition()
                local pt = inst:GetPosition()
                local vel = (hp - pt):GetNormalized()
                local speed = 5 + (math.random() * 2)
                local angle = math.atan2(vel.z, vel.x) + (math.random() * 20 +angle_num ) * GLOBAL.DEGREES
                item.Physics:SetVel(math.cos(angle) * speed, 10, math.sin(angle) * speed)
            end
        end
    end
    
    local function OnBossOnhitotherCooldown(inst)
        inst._cdtaskboss_onhitother = nil
    end
    
    local function OnBossAttackedCooldown(inst)
        inst._cdtaskboss_attacked = nil
    end
    local function OnBossFireCooldown(inst)
        inst._cdtaskboss_zhaohuan = nil
    end
    
    local function SpawnAchiv_fire(inst, x, z)
        GLOBAL.SpawnPrefab("achiv_fire").Transform:SetPosition(x, 0, z)
    end
    --触手不打
    
    AddPrefabPostInit("tentacle", function(inst)
        local function retargetfn2(inst)
            return GLOBAL.FindEntity(
            inst,
            TUNING.TENTACLE_ATTACK_DIST,
            function(guy) 
                return guy.prefab ~= inst.prefab and not guy:HasTag("dont_target") and guy.entity:IsVisible() and not guy.components.health:IsDead()
                    and (guy.components.combat.target == inst or guy:HasTag("character") or guy:HasTag("monster") or  guy:HasTag("animal"))
            end,
            { "_combat", "_health" },
            { "prey" })
        end
        local function shouldKeepTarget2(inst, target)
            return target ~= nil and not target:HasTag("dont_target")  and target:IsValid()  and target.entity:IsVisible() and target.components.health ~= nil
                and not target.components.health:IsDead() and target:IsNear(inst, TUNING.TENTACLE_STOPATTACK_DIST)
            end
            if inst.components.combat then
                inst.components.combat:SetRetargetFunction(GLOBAL.GetRandomWithVariance(2, 0.5), retargetfn2)
                inst.components.combat:SetKeepTargetFunction(shouldKeepTarget2)
            end
        end)
    
    --龙蝇
    TUNING.DRAGONFLY_SPEED = 7
    TUNING.DRAGONFLY_FIRE_SPEED = 9
    TUNING.DRAGONFLY_BREAKOFF_DAMAGE = 5000
    
    AddPrefabPostInit("dragonfly", function(inst)
        inst:AddTag("dont_target")
        inst:ListenForEvent("onhitother", function(inst, data)
            if   inst._cdtaskboss_onhitother == nil and data ~= nil and not data.redirected  then
                inst._cdtaskboss_onhitother = inst:DoTaskInTime(10, OnBossOnhitotherCooldown)
                --AI_DropItem(inst,data.target,"HANDS")
                AI_DropItem(inst,data.target,"HEAD")
                AI_DropItem(inst,data.target,"BODY")
    
                local pos = GLOBAL.Vector3(inst.Transform:GetWorldPosition())
                local ents = GLOBAL.TheSim:FindEntities(pos.x,pos.y,pos.z, 5)
                for k,v in pairs(ents) do
                    if v:HasTag("player") and not  v:HasTag("playerghost")   and  v ~= data.target then
                        local  r3 = math.random()
                        if r3 <= 0.33 then
                            AI_DropItem(inst,data.attacker,"HANDS")
                        elseif  r3>0.33 and r3 < 0.66 then
                            AI_DropItem(inst,data.attacker,"HEAD")
                        else
                            AI_DropItem(inst,data.attacker,"BODY")
                        end
                    end
                end
            end
        end)
        inst:ListenForEvent("attacked", function(inst, data)
            if   inst._cdtaskboss_attacked == nil and data ~= nil and not data.redirected  then
                inst._cdtaskboss_attacked = inst:DoTaskInTime(5, OnBossAttackedCooldown)
    
                GLOBAL.SpawnPrefab("bramblefx_armor"):SetFXOwner(inst)--22
                local player_num = 0
                local pos = GLOBAL.Vector3(inst.Transform:GetWorldPosition())
                local ents = GLOBAL.TheSim:FindEntities(pos.x,pos.y,pos.z, 6)
                for k,v in pairs(ents) do
                    if v:HasTag("player") and not  v:HasTag("playerghost")    then
                        player_num= player_num +1
                    end
                end
                if player_num >=3 then
                    GLOBAL.SpawnPrefab("bramblefx_trap"):SetFXOwner(inst)--40
                else
                    if math.random() > .6 then
                        GLOBAL.SpawnPrefab("bramblefx_trap"):SetFXOwner(inst)--40
                    end
                end
                local  r3 = math.random()
                if r3 <= 0.33 then
                    AI_DropItem(inst,data.attacker,"HANDS")
                elseif  r3>0.33 and r3 < 0.66 then
                    AI_DropItem(inst,data.attacker,"HEAD")
                else
                    AI_DropItem(inst,data.attacker,"BODY")
                end
    
                ----------------------------
                if inst._cdtaskboss_zhaohuan == nil then
                    inst._cdtaskboss_zhaohuan = inst:DoTaskInTime(26, OnBossFireCooldown)
                    local pos_inst = inst:GetPosition()
                    local pos_temp = 1
                    local pos_temp2 = 1
                    local dx = 24
                    local dx2 = 16
                    local r = 16
                    local r2 = 10
                    local angle = 0
                    local angle2 = 0
                    for pos_temp=1,dx do
                        inst:DoTaskInTime(.75, SpawnAchiv_fire(inst ,(pos_inst.x + math.cos(angle)*r), (pos_inst.z -math.sin(angle)*r)))
                        angle = angle + (math.pi*2/dx)
                    end
                    if inst.components.health and (inst.components.health.currenthealth < inst.components.health.maxhealth/2) then
                        for pos_temp2=1,dx2 do
                            inst:DoTaskInTime(.75, SpawnAchiv_fire(inst ,(pos_inst.x + math.cos(angle2)*r2), (pos_inst.z -math.sin(angle2)*r2)))
                            angle2 = angle2 + (math.pi*2/dx2)
                        end
                    end
                end
            end
        end)
    end)

    local function AI_DropItemIsInsulated(inst,target,equippeditem)
        if equippeditem then
            local angle_num = -20
            local item_temp = GLOBAL.EQUIPSLOTS.HEAD
            if equippeditem == "BODY" then
                angle_num = 20
                item_temp =  GLOBAL.EQUIPSLOTS.BODY
            end
            local item = nil
            if target and target.components.inventory then
                item = target.components.inventory:GetEquippedItem(item_temp)
            end
            if item and item.Physics and item.components.waterproofer and  item.components.waterproofer.effectiveness>=1  then
                target.components.inventory:DropItem(item)
                local x, y, z = item:GetPosition():Get()
                y = .1
                item.Physics:Teleport(x,y,z)
                local hp = target:GetPosition()
                local pt = inst:GetPosition()
                local vel = (hp - pt):GetNormalized()
                local speed = 5 + (math.random() * 2)
                local angle = math.atan2(vel.z, vel.x) + (math.random() * 20 +angle_num ) * GLOBAL.DEGREES
                item.Physics:SetVel(math.cos(angle) * speed, 10, math.sin(angle) * speed)
            end
        end
    end
    --鹿鸭
    TUNING.MOOSE_HEALTH = 15000
    TUNING.MOOSE_WALK_SPEED = 10
    TUNING.MOOSE_RUN_SPEED = 14
    AddPrefabPostInit("moose", function(inst)
        inst:AddTag("dont_target")
        inst:AddComponent("heater")
        inst.components.heater.heat = -200
        inst.components.heater:SetThermics(false, true)
        if inst.components.health then
            inst.components.health.fire_damage_scale = 0 
        end
        inst:ListenForEvent("onhitother", function(inst, data)
            if data ~= nil and data.target  then
                SpawnPrefab("waterballoon_splash").Transform:SetPosition(data.target.Transform:GetWorldPosition())
                if  data.target.components.moisture ~= nil then
                    data.target.components.moisture:DoDelta(data.target.components.inventory ~= nil and 30 * (1 - math.min(data.target.components.inventory:GetWaterproofness(), 1)) or 20)
                end
    
                if data.target.components.temperature then
                    data.target.components.temperature:DoDelta(-10)
                end
    
                if  inst._cdtaskboss_onhitother == nil then
                    inst._cdtaskboss_onhitother = inst:DoTaskInTime(8, OnBossOnhitotherCooldown)
    
                    if  data.target.components.health ~= nil and not data.target.components.health:IsDead() and data.target.components.combat then
                        data.target.components.health:DoDelta(-15, nil, inst.prefab, nil, inst)
                        if data.target:HasTag("player") and  not  data.target:HasTag("playerghost") then
                            if data.target.components.inventory == nil or not data.target.components.inventory:IsInsulated() then
                                data.target.components.combat:GetAttacked(inst, TUNING.MOOSE_EGG_DAMAGE, nil, "electric")
                            end
                        end
                    end
                end
            end
        end)
        inst:ListenForEvent("attacked", function(inst, data)
            if   inst._cdtaskboss_attacked == nil and data ~= nil  then
                inst._cdtaskboss_attacked = inst:DoTaskInTime(6, OnBossAttackedCooldown)
                local pos = GLOBAL.Vector3(inst.Transform:GetWorldPosition())
                local ents = GLOBAL.TheSim:FindEntities(pos.x,pos.y,pos.z, 6)
                for k,v in pairs(ents) do
                    if v:HasTag("player") and not  v:HasTag("playerghost")   then
                        SpawnPrefab("waterballoon_splash").Transform:SetPosition(v.Transform:GetWorldPosition())
                        if data ~= nil and data.attacker ~= nil and  data.attacker.components.temperature then
                            data.attacker.components.temperature:DoDelta(-10)
                        end
                        if  v.components.moisture ~= nil then
                            v.components.moisture:DoDelta(v.components.inventory ~= nil and 40 * (1 - math.min(v.components.inventory:GetWaterproofness(), 1)) or 20)
                        end
                        
                        if data ~= nil and data.attacker ~= nil and data.attacker.components.health ~= nil and not data.attacker.components.health:IsDead()  then
                            if data.attacker.components.inventory == nil or not data.attacker.components.inventory:IsInsulated() then
                                data.attacker.components.health:DoDelta(-15, nil, inst.prefab, nil, inst)
                                data.attacker.sg:GoToState("electrocute")
                            end
                        end 
                        if math.random() < .55 then
                            AI_DropItemIsInsulated(inst,data.attacker,"HEAD")
                        end
                        if math.random() < .55 then
                            AI_DropItemIsInsulated(inst,data.attacker,"BODY")
                        end
                        
                    end
                end
            end
        end)
    end)
    --熊大
    local function OnSpawnPrefabBearger(inst,pos_x,pos_z)
        SpawnPrefab("achiv_sinkhole").Transform:SetPosition(pos_x, 0, pos_z)
    end
    local function OnSpawnPrefabIcecrystal(inst)
    
        local pos_inst = inst:GetPosition()
        local pos_temp,dx,r,angle = 1,30,8,0
        local pos_temp2,dx2,r2,angle2 = 1,20,5,0
        for pos_temp=1,dx do
            local ice_crystal = SpawnPrefab("achiv_ice_crystal")
            if ice_crystal   then
                ice_crystal.Transform:SetPosition((pos_inst.x + math.cos(angle)*r), 0, (pos_inst.z -math.sin(angle)*r))
                angle = angle + (math.pi*2/dx)
            end
        end
        for pos_temp2=1,dx2 do
            local ice_crystal = SpawnPrefab("achiv_ice_crystal")
            if ice_crystal  then
                ice_crystal.Transform:SetPosition((pos_inst.x + math.cos(angle2)*r2), 0, (pos_inst.z -math.sin(angle2)*r2))
                angle2 = angle2 + (math.pi*2/dx2)
            end
        end
    end
    
    TUNING.BEARGER_HEALTH = 12000
    AddPrefabPostInit("bearger", function(inst)
        inst:AddTag("dont_target")
    
        if inst.components.health then
            inst.components.health.fire_damage_scale = 0 
        end
        inst:ListenForEvent("attacked", function(inst, data)
            if inst.components.combat  and inst.components.health and (inst.components.health.currenthealth < inst.components.health.maxhealth/3)    then
                inst.components.combat:SetDefaultDamage(260)
            end
            if   inst._cdtaskboss_attacked == nil and data ~= nil and data.attacker and data.attacker:HasTag("player") and  not  data.attacker:HasTag("playerghost")  then
                inst._cdtaskboss_attacked = inst:DoTaskInTime(11, OnBossAttackedCooldown)
                local pos = GLOBAL.Vector3(inst.Transform:GetWorldPosition())
                local ents = GLOBAL.TheSim:FindEntities(pos.x,pos.y,pos.z, 7.8)
    
                local check_fx = true
                for k,v in pairs(ents) do
                    if  v:HasTag("achiv_sinkhole_fx")    then
                        check_fx = false
                    end
                end
                if check_fx then
                    inst:DoTaskInTime(.1, OnSpawnPrefabBearger(inst,pos.x,pos.z))
                end
                if check_fx then
                    inst:DoTaskInTime(.35, OnSpawnPrefabIcecrystal(inst))
                end
            end
        end)
    end)
    --蚁狮 antlion
    TUNING.ANTLION_HEALTH = 17500
    AddPrefabPostInit("antlion", function(inst)
        inst:AddTag("dont_target")
        inst:ListenForEvent("attacked", function(inst, data)
            if   inst._cdtaskboss_attacked == nil and data ~= nil   then
                inst._cdtaskboss_attacked = inst:DoTaskInTime(10, OnBossAttackedCooldown)
                local pos = GLOBAL.Vector3(inst.Transform:GetWorldPosition())
                local ents = GLOBAL.TheSim:FindEntities(pos.x,pos.y,pos.z, 17)
                for k,v in pairs(ents) do
                    if v ~= nil  and v:HasTag("catapult") or  v:HasTag("engineeringbattery")  or v.prefab  == "eyeturret"  or v.prefab  == "lureplant"   then
                        local pos_spawn = GLOBAL.Vector3(v.Transform:GetWorldPosition())
                        SpawnPrefab("sandspike_med").Transform:SetPosition(pos_spawn.x,0,pos_spawn.z)
                    end
                end
                if data.attacker and data.attacker:HasTag("player") and not  data.attacker:HasTag("playerghost")   then
                    SpawnPrefab("achiv_shield").Transform:SetPosition(pos.x, 0, pos.z)
                        
                end
                local pos_inst = inst:GetPosition()
                local pos_temp,dx,r,angle = 1,14,2.1,0
                local pos_temp2,dx2,r2,angle2 = 1,28,2.9,0
                for pos_temp=1,dx do
                    local sandblock_small = SpawnPrefab("sandspike_med")
                    if sandblock_small and sandblock_small.components.health  then
                        sandblock_small.components.health:SetMaxHealth(200)
                        sandblock_small.Transform:SetPosition((pos_inst.x + math.cos(angle)*r), 0, (pos_inst.z -math.sin(angle)*r))
                        angle = angle + (math.pi*2/dx)
                    end
                end
                for pos_temp2=1,dx2 do
                    local sandblock_small = SpawnPrefab("sandspike_short")
                    if sandblock_small and sandblock_small.components.health  then
                        sandblock_small.components.health:SetMaxHealth(100)
                        sandblock_small.Transform:SetPosition((pos_inst.x + math.cos(angle2)*r2), 0, (pos_inst.z -math.sin(angle2)*r2))
                        angle2 = angle2 + (math.pi*2/dx2)
                    end
                end
    
            end
        end)
        
    end)
    --巨鹿 deerclops
    TUNING.DEERCLOPS_HEALTH = 8000
    AddPrefabPostInit("deerclops", function(inst)
        inst:AddTag("dont_target")
        if inst.components.health then
            inst.components.health.fire_damage_scale = 0 
        end
        inst:ListenForEvent("attacked", function(inst, data)
            if   inst._cdtaskboss_attacked == nil and data ~= nil  and data.attacker and data.attacker:HasTag("player") and not  data.attacker:HasTag("playerghost") then
                inst._cdtaskboss_attacked = inst:DoTaskInTime(math.random() * 5 + 8, OnBossAttackedCooldown)
                
                local pos = GLOBAL.Vector3(inst.Transform:GetWorldPosition())
                local ents = GLOBAL.TheSim:FindEntities(pos.x,pos.y,pos.z, 10)
                for k,v in pairs(ents) do
                    if v:HasTag("player") and not  v:HasTag("playerghost")  then
                        if v._deer_ice_burst_aifx == nil then            
                            v._deer_ice_burst_aifx = SpawnPrefab("deer_ice_burst_aifx") -- deer_ice_burst_aifx
                            v._deer_ice_burst_aifx.entity:SetParent(v.entity)
                            v._deer_ice_burst_aifx.Transform:SetPosition(0, 0.2, 0)
                            v._deer_ice_burst_aifx = v:DoTaskInTime(3, 
                                function(v) 
                                    if v  then v._deer_ice_burst_aifx = nil  end
                                    if math.random()> 0.55 and v and  v.components.freezable then
                                        v.components.freezable:AddColdness(5, 3)
                                        v.components.freezable:SpawnShatterFX()
                                    end
    
                            end)
                        end
                    end
                end
            end
        end)
    
    end)
    local function OnBossAttackedCooldownPlayer(inst)
        inst._cdtaskboss_playerattack = nil
    end
    --蜂后 beequeen
    AddPrefabPostInit("beequeen", function(inst)
        if inst.components.health then
            inst.components.health.fire_damage_scale = 0 
        end
        inst:ListenForEvent("attacked", function(inst, data)
            if   inst._cdtaskboss_attacked == nil and data ~= nil  and data.attacker and not data.attacker:HasTag("player") and not  data.attacker:HasTag("playerghost") then
                inst._cdtaskboss_attacked = inst:DoTaskInTime(.15, OnBossAttackedCooldown)
                GLOBAL.SpawnPrefab("achiv_bramblefx_armor"):SetFXOwner(inst)
            end
            if   inst._cdtaskboss_playerattack == nil and data ~= nil  and data.attacker and  data.attacker:HasTag("player") and not  data.attacker:HasTag("playerghost") then
                inst._cdtaskboss_playerattack = inst:DoTaskInTime(5, OnBossAttackedCooldownPlayer)
                GLOBAL.SpawnPrefab("achiv_bramblefx_armor"):SetFXOwner(inst)
            end
        end)
    
    end)
    --克劳斯
    AddPrefabPostInit("klaus", function(inst)
        if inst.components.health then
            inst.components.health.fire_damage_scale = 0 
        end
    end)
    --蛤蟆  toadstool
    AddPrefabPostInit("toadstool", function(inst)
        if inst.components.freezable then
            inst:RemoveComponent("freezable")
        end
        if inst.components.sleeper ~= nil then
            inst.components.sleeper.resistance = 9999
        end
        inst:ListenForEvent("attacked", function(inst, data)
            if   inst._cdtaskboss_attacked == nil and data ~= nil  and data.attacker and  data.attacker:HasTag("player") and not  data.attacker:HasTag("playerghost") then
                inst._cdtaskboss_attacked = inst:DoTaskInTime(2, OnBossAttackedCooldown)
                
            end
        end)
    
    end)
    --剧毒蛤蟆  toadstool_dark
    AddPrefabPostInit("toadstool_dark", function(inst)
        if inst.components.freezable then
            inst:RemoveComponent("freezable")
        end
        if inst.components.sleeper ~= nil then
            inst.components.sleeper.resistance = 9999
        end
    end)
    --中庭  stalker_atrium
    AddPrefabPostInit("stalker_atrium", function(inst)
        inst:ListenForEvent("attacked", function(inst, data)
            if   inst._cdtaskboss_attacked == nil and data ~= nil  and data.attacker and not data.attacker:HasTag("player") and not  data.attacker:HasTag("playerghost") then
                inst._cdtaskboss_attacked = inst:DoTaskInTime(.15, OnBossAttackedCooldown)
                GLOBAL.SpawnPrefab("achiv_bramblefx_armor"):SetFXOwner(inst)
            end
            if   inst._cdtaskboss_playerattack == nil and data ~= nil  and data.attacker and  data.attacker:HasTag("player") and not  data.attacker:HasTag("playerghost") then
                inst._cdtaskboss_playerattack = inst:DoTaskInTime(5, OnBossAttackedCooldownPlayer)
                GLOBAL.SpawnPrefab("achiv_bramblefx_armor"):SetFXOwner(inst)
            end
        end)
    end)
    --犀牛  minotaur
    --邪天翁   malbatross
end