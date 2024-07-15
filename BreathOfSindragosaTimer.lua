local frame = CreateFrame("Frame", "BreathOfSindragosaTimerFrame", UIParent)
frame:SetSize(64, 64)
frame:SetPoint("CENTER", UIParent, "CENTER", 0, 100)

local icon = frame:CreateTexture(nil, "BACKGROUND")
icon:SetAllPoints(true)
icon:SetTexture(GetSpellTexture(152279)) -- Breath of Sindragosa spell icon

local timerText = frame:CreateFontString(nil, "OVERLAY")
timerText:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
timerText:SetPoint("CENTER", frame, "CENTER", 0, 0)
timerText:SetText("")

local function UpdateTimer()
    local spellName = GetSpellInfo(152279) -- Breath of Sindragosa
    local start, duration = GetSpellCooldown(spellName)
    local currentTime = GetTime()

    if start == 0 then
        frame:Hide()
    else
        frame:Show()
        local remainingTime = duration - (currentTime - start)
        local runicPower = UnitPower("player", 6) -- 6 is the enum for runic power

        -- Adjust remaining time based on runic power drain rate
        local drainRate = 16 / 60 -- 16 runic power per second
        remainingTime = math.min(remainingTime, runicPower / drainRate)

        timerText:SetText(string.format("%.1f", remainingTime))
    end
end

frame:SetScript("OnUpdate", UpdateTimer)

frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
frame:RegisterEvent("UNIT_POWER_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
frame:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "SPELL_UPDATE_COOLDOWN" or event == "PLAYER_ENTERING_WORLD" then
        UpdateTimer()
    elseif event == "UNIT_POWER_UPDATE" and arg1 == "player" then
        UpdateTimer()
    elseif event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" or event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" then
        if arg1 == 152279 then
            UpdateTimer()
        end
    end
end)
