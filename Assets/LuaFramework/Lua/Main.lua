--主入口函数。从这里开始lua逻辑
function Main()
    local a = 'x-studio365 is a power full IDE!'
    print("logic start")	 		
end

--场景切换通知
function OnLevelWasLoaded(level)
    collectgarbage("collect")
    Time.timeSinceLevelLoad = 0
end

function OnApplicationQuit()
end