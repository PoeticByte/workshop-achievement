-- GM 控制台命令
-- 注意: 本文件被 require 加载,运行在严格的 mod env 里——直接 `function foo()` 会定义进 mod env,
-- 而控制台在真正的全局表 _G 里查找,所以找不到、调不动;此 env 里也访问不到 `GLOBAL`(会报 not declared)。
-- 解决: 本文件返回一个函数表,由 modmain(能访问 GLOBAL) 把它们注册到全局表 _G,这样控制台才能调用。
-- 函数体里读 AllPlayers 是真全局,通过 env 的 __index 回退能正常读到。
-- 这些命令修改服务端组件(.components),在服务端/主机控制台执行(主机本地控制台即可)。

return {
    add_achievement_point = function(player_index, points)
        AllPlayers[player_index].components.achievementability.coinamount = AllPlayers[player_index].components.achievementability.coinamount + points
    end,

    add_kill_point = function(player_index, points)
        AllPlayers[player_index].components.achievementability.killamount = AllPlayers[player_index].components.achievementability.killamount + points
    end,

    add_player_exp = function(player_index, points)
        AllPlayers[player_index].components.achievementmanager.currenta_a2amount = AllPlayers[player_index].components.achievementmanager.currenta_a2amount + points
    end,

    add_player_level = function(player_index, points)
        AllPlayers[player_index].components.achievementmanager.currenta_a4amount = AllPlayers[player_index].components.achievementmanager.currenta_a4amount + points
    end,

    add_attribute_point = function(player_index, points)
        AllPlayers[player_index].components.achievementability.attributepointamount = AllPlayers[player_index].components.achievementability.attributepointamount + points
    end,

    add_reset_point = function(player_index, points)
        print(AllPlayers[player_index].components.achievementability.resetamount, AllPlayers[player_index].components.achievementability.usedresetamount)
        AllPlayers[player_index].components.achievementability.resetamount = AllPlayers[player_index].components.achievementability.resetamount + points
    end,
}
