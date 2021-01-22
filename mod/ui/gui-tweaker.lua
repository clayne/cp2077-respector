local mod = ...
local str = mod.require('mod/utils/str')
local array = mod.require('mod/utils/array')
local Rarity = mod.require('mod/enums/Rarity')
local TweakDb = mod.require('mod/helpers/TweakDb')

local tweaker = {}

local respector
local tweakDb
local persitentState

local windowWidth = 440
local windowHeight = 400
local windowPadding = 7.5
local openKey

local viewData = {
	tweakSearch = nil,
	tweakSearchMaxLen = 32,
	tweakSearchMaxResults = 50,
	tweakSearchResults = nil,
	tweakSearchPreviews = nil,

	activeTweakIndex = nil,
	activeTweakData = nil,

	qualityOptionList = nil,
	qualityOptionCount = nil,
	qualityOptionIndex = nil,

	questOptionList = nil,
	questOptionCount = nil,
	questOptionIndex = nil,
}

local userState = {
	showTweaker = nil,
	expandTweaker = nil,
	tweakSearch = nil,
}

function tweaker.init(_respector, _userState, _persitentState)
	respector = _respector
	userState = _userState
	persitentState = _persitentState

	tweakDb = TweakDb:new()

	tweaker.initHotkeys()
	tweaker.initState()
end

function tweaker.initHotkeys()
	openKey = mod.config.openTweakerKey or 0x7B -- F12
end

function tweaker.initState(force)
	if not userState.tweakSearch or force then
		userState.showTweaker = false
		userState.expandTweaker = true
		viewData.tweakSearch = str.padnul('', viewData.tweakSearchMaxLen)
	else
		viewData.tweakSearch = userState.tweakSearch
	end

	-- Trigger search
	userState.tweakSearch = ''

	viewData.tweakSearchResults = {}
	viewData.tweakSearchPreviews = {}

	viewData.activeTweakIndex = -1
	viewData.activeTweakData = nil
end

function tweaker.onUpdateEvent()
	if ImGui.IsKeyPressed(openKey, false) then
		userState.showTweaker = not userState.showTweaker
	end
end

function tweaker.onDrawEvent()
	if not userState.showTweaker or not userState.showWindow then
		return
	end

	ImGui.SetNextWindowPos(365, 400, ImGuiCond.FirstUseEver)
	ImGui.SetNextWindowSize(windowWidth + (windowPadding * 2), windowHeight)
	--ImGui.SetNextWindowCollapsed(false)

	userState.showTweaker, userState.expandTweaker = ImGui.Begin('Quick Tweaks', userState.showTweaker, ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoScrollbar | ImGuiWindowFlags.NoScrollWithMouse)

	if userState.showTweaker and userState.expandTweaker then
		ImGui.Spacing()

		ImGui.SetNextItemWidth(windowWidth)
		viewData.tweakSearch = ImGui.InputTextWithHint('##TweakSearch', 'Search database... (at least 2 characters)', viewData.tweakSearch, viewData.tweakSearchMaxLen)

		if viewData.tweakSearch ~= userState.tweakSearch then
			viewData.activeTweakIndex = -1
			viewData.activeTweakData = nil

			userState.tweakSearch = viewData.tweakSearch

			tweaker.onTweakSearchChange()
		end

		ImGui.PushStyleColor(ImGuiCol.FrameBg, 0.16, 0.29, 0.48, 0.25)
		ImGui.SetNextItemWidth(windowWidth)
		local tweakIndex, tweakChanged = ImGui.ListBox('##TweakSearchResults', viewData.activeTweakIndex, viewData.tweakSearchPreviews, #viewData.tweakSearchPreviews, 5)
		ImGui.PopStyleColor()

		if tweakChanged then
			viewData.activeTweakIndex = tweakIndex
			viewData.activeTweakData = viewData.tweakSearchResults[tweakIndex + 1] or nil

			tweaker.onTweakSearchResultSelect()
		end

		ImGui.SetCursorPos(8, 153) -- Fix for inconsistent height of ListBox

		ImGui.Spacing()
		ImGui.Separator()
		ImGui.Spacing()

		if viewData.activeTweakData then
			local tweak = viewData.activeTweakData

			ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 4, 2)

			if tweak.entryMeta.quality then
				ImGui.PushStyleColor(ImGuiCol.Text, Rarity.toColor(tweak.entryMeta.quality))
			end

			ImGui.Text(tweak.entryMeta.name)

			if tweak.entryMeta.quality then
				ImGui.SameLine()
				ImGui.Text('·')
				ImGui.SameLine()
				ImGui.Text(tweak.entryMeta.quality)

				if tweak.entryMeta.iconic then
					ImGui.SameLine()
					ImGui.Text('/')
					ImGui.SameLine()
					ImGui.Text('Iconic')
				end

				ImGui.PopStyleColor()
			end

			ImGui.PushStyleColor(ImGuiCol.Text, 0xffbf9f9f) -- 0xff484ae6
			ImGui.Text(tweak.entryMeta.kind)

			if tweak.entryMeta.group then
				ImGui.SameLine()
				ImGui.Text('/')
				ImGui.SameLine()
				ImGui.Text(tweak.entryMeta.group)

				if tweak.entryMeta.group2 then
					ImGui.SameLine()
					ImGui.Text('/')
					ImGui.SameLine()
					ImGui.Text(tweak.entryMeta.group2)
				end
			end

			ImGui.PopStyleColor()

			if tweak.entryMeta.desc then
				ImGui.PushStyleColor(ImGuiCol.Text, 0xffcccccc)
				ImGui.TextWrapped(tweak.entryMeta.desc:gsub('%%', '%%%%'))
				ImGui.PopStyleColor()
			end

			ImGui.PopStyleVar()

			if tweak.entryMeta.comment then
				ImGui.PushStyleColor(ImGuiCol.Text, 0xff484ad5) -- 0xff484ad5 0xff484ae6 0xff3c3dbd
				ImGui.TextWrapped(tweak.entryMeta.comment:gsub('%%', '%%%%'))
				ImGui.PopStyleColor()
			end

			ImGui.Spacing()
			ImGui.Separator()

			if tweak.entryMeta.kind == 'Fact' then

			elseif tweak.entryMeta.kind == 'Vehicle' then

			elseif tweak.entryMeta.kind == 'Money' then

			else
				--ImGui.Text('Spawn item')

				ImGui.BeginGroup()
				ImGui.Spacing()
				ImGui.Text('Qty:')
				ImGui.SetNextItemWidth(120)
				tweak.itemQty = ImGui.InputInt('##Item Qty', tweak.itemQty or 1)
				ImGui.EndGroup()

				ImGui.SameLine()
				ImGui.BeginGroup()
				ImGui.Text('Rarity:')
				ImGui.SetNextItemWidth(150)
				if tweak.itemCanBeUpgraded then
					local optionIndex, optionChanged = ImGui.Combo('##ItemQuality', viewData.qualityOptionIndex, viewData.qualityOptionList, viewData.qualityOptionCount)
					if optionChanged then
						tweak.itemQuality = viewData.qualityOptionList[optionIndex + 1]
						viewData.qualityOptionIndex = optionIndex
					end
				else
					ImGui.PushStyleColor(ImGuiCol.FrameBg, 0.16, 0.29, 0.48, 0.25)
					ImGui.InputText('##ItemQualityFixed', tweak.entryMeta.quality, 512, ImGuiInputTextFlags.ReadOnly)
					ImGui.PopStyleColor()
				end
				ImGui.EndGroup()

				ImGui.SameLine()
				ImGui.BeginGroup()
				ImGui.Text('Quest mark:')
				ImGui.SetNextItemWidth(100)
				if tweak.itemCanBeMarked then
					local optionIndex, optionChanged = ImGui.Combo('##ItemQuest', viewData.questOptionIndex, viewData.questOptionList, viewData.questOptionCount)
					if optionChanged then
						tweak.itemQuestMark = viewData.questOptionList[optionIndex + 1] == 'YES'
						viewData.questOptionIndex = optionIndex
					end
				else
					ImGui.PushStyleColor(ImGuiCol.FrameBg, 0.16, 0.29, 0.48, 0.25)
					ImGui.InputText('##ItemQuestFixed', 'NO', 512, ImGuiInputTextFlags.ReadOnly)
					ImGui.PopStyleColor()
				end
				ImGui.EndGroup()

				ImGui.Spacing()

				if ImGui.Button('Add to inventory', windowWidth, 19) then
					tweaker.onSpawnItemClick()
				end

				if tweak.itemCanBeCrafted then
					ImGui.Spacing()
					ImGui.Separator()
					ImGui.Spacing()

					if tweak.itemRecipeKnown then
						ImGui.Text('You have crafting recipe for this item.')
					else
						ImGui.Text('This item can be crafted.')

						if ImGui.Button('Unlock crafting recipe', windowWidth, 19) then
							tweaker.onUnlockRecipeClick()
						end
					end
				end
			end

			ImGui.Spacing()
			ImGui.Separator()

			ImGui.AlignTextToFramePadding()

			ImGui.PushStyleColor(ImGuiCol.FrameBg, 0)
			ImGui.PushStyleColor(ImGuiCol.Text, 0xff9f9f9f)
			--ImGui.PushStyleColor(ImGuiCol.Border, 0xff483f3f)
			--ImGui.PushStyleVar(ImGuiStyleVar.FrameBorderSize, 1)
			ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 2, 0)
			ImGui.Text('ID:')
			ImGui.SameLine()
			ImGui.SetNextItemWidth(292)
			ImGui.InputText('##Tweak Hash Name', tweak.entryMeta.type or 'N/A', 512, ImGuiInputTextFlags.ReadOnly)
			ImGui.PopStyleVar()
			ImGui.SameLine()
			ImGui.PushStyleVar(ImGuiStyleVar.ItemSpacing, 2, 0)
			ImGui.Text('Hash:')
			ImGui.SameLine()
			ImGui.SetNextItemWidth(78)
			ImGui.InputText('##Tweak Hash Key', tweak.entryHash, 16, ImGuiInputTextFlags.ReadOnly)
			ImGui.PopStyleVar()
			ImGui.PopStyleColor(2)
		end
	end

	ImGui.End()
end

function tweaker.onTweakSearchChange()
	persitentState:flush()

	local searchTerm = str.stripnul(userState.tweakSearch)

	if searchTerm:len() < 2 then
		return
	end

	tweakDb:load('mod/data/tweakdb-meta')

	local searchResults = {}

	for entryKey, entryMeta, entryPos in tweakDb:search(searchTerm) do
		if entryMeta.name and entryMeta.kind ~= 'Slot' then
			table.insert(searchResults, {
				entryKey = entryKey,
				entryMeta = entryMeta,
				entryOrder = tweakDb:order(entryMeta, true, ('%03X'):format(entryPos)),
			})
		end
	end

	tweakDb:unload()

	array.sort(searchResults, 'entryOrder')
	array.limit(searchResults, viewData.tweakSearchMaxResults)

	-- View Data

	viewData.tweakSearchResults = array.map(searchResults, function(result)
		return {
			entryKey = result.entryKey,
			entryMeta = result.entryMeta,
			entryHash = ('%010X'):format(result.entryKey),
		}
	end)

	viewData.tweakSearchPreviews = array.map(searchResults, function(result)
		return tweakDb:describe(result.entryMeta, true, false, 25)
	end)
end

function tweaker.onTweakSearchResultSelect()
	local tweak = viewData.activeTweakData

	-- Quantity

	if tweak.entryMeta.kind == 'Money' then
		tweak.itemQty = 100000
	else
		tweak.itemQty = 1
	end

	-- Quality

	if tweak.entryMeta.quality then
		tweak.itemCanBeUpgraded = false
		tweak.itemQuality = tweak.entryMeta.quality
	else
		tweak.itemCanBeUpgraded = true

		-- Set max quality by default
		if tweakDb:match(tweak.entryMeta, { kind = 'Mod', group = { 'Clothing', 'Ranged', 'Scope' } }) then
			tweak.itemQuality = 'Epic'
		else
			tweak.itemQuality = 'Legendary'
		end
	end

	-- Quest Mark

	if tweak.entryMeta.quest then
		tweak.itemCanBeMarked = true
		tweak.itemQuestMark = true
	else
		tweak.itemCanBeMarked = false
		tweak.itemQuestMark = false
	end

	-- Crafting

	if tweak.entryMeta.craft then
		tweak.itemCanBeCrafted = true

		if tweak.entryMeta.craft == true then
			tweak.itemRecipeId = tweak.entryMeta.type
		else
			tweak.itemRecipeId = tweak.entryMeta.craft
		end

		tweak.itemRecipeKnown = respector:usingModule('crafting', function(craftingModule)
			return craftingModule:isRecipeKnown(craftableId)
		end)
	else
		tweak.itemCanBeCrafted = false
		tweak.itemRecipeId = nil
		tweak.itemRecipeKnown = false
	end

	-- View Data

	if tweak.itemCanBeUpgraded then
		viewData.qualityOptionList = Rarity.upTo(tweak.itemQuality)
	else
		viewData.qualityOptionList = { tweak.itemQuality }
	end

	viewData.qualityOptionCount = #viewData.qualityOptionList
	viewData.qualityOptionIndex = viewData.qualityOptionCount - 1

	if tweak.itemCanBeMarked then
		viewData.questOptionList = { 'Yes', 'No' }
	else
		viewData.questOptionList = { 'N/A' }
	end

	viewData.questOptionCount = #viewData.questOptionList
	viewData.questOptionIndex = viewData.questOptionCount - 1
end

function tweaker.onSpawnItemClick()
	local tweak = viewData.activeTweakData

	local itemSpec = {
		id = tweak.entryMeta.type,
		upgrade = tweak.itemQuality,
		qty = tweak.itemQty
	}

	if not tweak.itemQuestMark then
		itemSpec.quest = false
	end

	respector:applySpecData({
		Inventory = { itemSpec }
	})
end

function tweaker.onUnlockRecipeClick()
	local tweak = viewData.activeTweakData

	respector:usingModule('crafting', function(craftingModule)
		craftingModule:addRecipe(tweak.itemRecipeId)
	end)

	tweak.itemRecipeKnown = true
end

function tweaker.onQuickButtonClick()
	userState.showTweaker = not userState.showTweaker

	persitentState:flush()
end

return tweaker