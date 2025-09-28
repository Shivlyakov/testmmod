if SERVER then return end

LuaUserData.MakeFieldAccessible(Descriptors["Barotrauma.Items.Components.Wearable"], "wearableSprites")

local WEAR_CONFIG = {
    Sound = {
            OpenSound = {  sound = Game.SoundManager.LoadSound(... .. "/Sound/HelmetTac/Mask/MaskOpen.ogg"),
                            frequencyMultiplier = 1,
                            gain = 1,
                            range = 500},
            CloseSound = { sound = Game.SoundManager.LoadSound(... .. "/Sound/HelmetTac/Mask/MaskClose.ogg"),
                            frequencyMultiplier = 1,
                            gain = 1,
                            range = 500}
    }
}

-- 所有的OnUse Hook应该只执行一次，而不是一直执行
local isExecuted={}

Hook.Add("MASKA_Origin_Lua", function(_, _, item)
    if not isExecuted[item.ID] then return end
    local itemComponent = item.GetComponentString("Wearable")
    if itemComponent.wearableSprites[1].Sprite == nil then return end
        SoundPlayer.PlaySound(WEAR_CONFIG.Sound.CloseSound.sound, item.WorldPosition, WEAR_CONFIG.Sound.CloseSound.gain, WEAR_CONFIG.Sound.CloseSound.range, WEAR_CONFIG.Sound.CloseSound.frequencyMultiplier)
    itemComponent.wearableSprites[1].Sprite.SourceRect=Rectangle(6,4,101,111)
    itemComponent.wearableSprites[1].Sprite.RelativeOrigin=Vector2(0.55,0.59)
    isExecuted[item.ID] = false
end)

Hook.Add("MASKA_Open_Lua", function(_, _, item)
    if isExecuted[item.ID] then return end
    local itemComponent = item.GetComponentString("Wearable")
    if itemComponent.wearableSprites[1].Sprite == nil then return end
    SoundPlayer.PlaySound(WEAR_CONFIG.Sound.OpenSound.sound, item.WorldPosition, WEAR_CONFIG.Sound.OpenSound.gain, WEAR_CONFIG.Sound.OpenSound.range, WEAR_CONFIG.Sound.OpenSound.frequencyMultiplier)
    itemComponent.wearableSprites[1].Sprite.SourceRect=Rectangle(6,129,112,115)
    itemComponent.wearableSprites[1].Sprite.RelativeOrigin=Vector2(0.52,0.63)
    isExecuted[item.ID] = true
end)
