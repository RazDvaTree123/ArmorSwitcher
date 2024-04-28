--------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------
local TalentIdByIndex = {}
local AddonName = common.GetAddonName()
local ButtonMain
local MainPanel
local wtChat
local valuedText = common.CreateValuedText()
local dndOn = false
local talents = {}
local AugModuleBuild
--local MenuTemplate = mainForm:GetChildChecked( "MenuTemplate", true ):GetWidgetDesc()
--local ItemTemplate = mainForm:GetChildChecked( "ItemTemplate", true ):GetWidgetDesc()
--local SubmenuTemplate = mainForm:GetChildChecked( "SubmenuTemplate", true ):GetWidgetDesc()
----local CombinedTemplate = mainForm:GetChildChecked( "CombinedTemplate", true ):GetWidgetDesc()
function Init()
    mainForm:Show(true)
	PrepareTextures()
	SetConfigButton()
 --   LoadSettings()
	GetModuleId()
    --DownloadArmor()
end

function PrepareTextures()
    ButtonMain = mainForm:GetChildUnchecked("MainButton", false)

    ButtonMain:Show(false)
end

function SetConfigButton()
    ButtonMain:Show(true)

    DnD.Init(ButtonMain, nil, true)
    common.RegisterReactionHandler(OnClickButton, 'REACT_ON_CLICK')
end 

function OnClickButton()
    MainPanel = mainForm:GetChildUnchecked("BuildArmorPanel", false)
        --if DnD:IsDragging() then
        --	return
        --end
        if not MainPanel:IsVisible() then
            MainPanel:Show(true)
            DnD.Init(MainPanel, nil, true)
        else
            MainPanel:Show(false)
        end
end

function GetModuleId()
    local BuildsTable = {}
    local build = {}
	local exoMountId = mount.GetExoMount()
	build.currentTalents = mount.GetSelectedTalents(exoMountId)
    build.name = "Домик мист"
    table.insert( BuildsTable, build )
	userMods.SetAvatarConfigSection( "AugModuleBuild", BuildsTable )
end

function LoadSettings()


end



function DownloadArmor()
    local exoMountId = mount.GetExoMount()
    local sysName = "DomikMist3"
    local PickedTalents = userMods.GetAvatarConfigSection(sysName)
    for slotIndex, slotTalents in ipairs( PickedTalents ) do
        talents[1] = slotTalents[1]
        talents[2] = slotTalents[2]
        talents[3] = slotTalents[3]
        mount.SelectTalents( exoMountId, talents )
       end
end





local function LogToChat(text)
    if not wtChat then
        wtChat = stateMainForm:GetChildUnchecked("ChatLog", false)
        wtChat = wtChat:GetChildUnchecked("Container", true)
        local formatVT = "<html fontname='AllodsFantasy' fontsize='14' shadow='1'><rs class='color'><r name='addonName'/><r name='text'/></rs></html>"
        valuedText:SetFormat(userMods.ToWString(formatVT))
    end

    if wtChat and wtChat.PushFrontValuedText then
        if not common.IsWString(text) then
            text = userMods.ToWString(text)
        end

        valuedText:ClearValues()
        valuedText:SetClassVal("color", "LogColorYellow")
        valuedText:SetVal("text", text)
        valuedText:SetVal("addonName", userMods.ToWString(": "))
        wtChat:PushFrontValuedText(valuedText)
    end
end




Init()