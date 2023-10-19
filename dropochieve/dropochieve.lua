dropochieve = {};
dropochieve["Name"] = "dropochieve";
dropochieve["Color"] = "FFAA00";
dropochieve["Version"] = "2.0";
dropochieve["Achievements"] = {};
dropochieve["iconsize"] = {["x"] = 16, ["y"] = 16};
dropochieve["subframegap"] = {["x"] = 4, ["y"] = 4};
dropochieve["subframesize"] = {["x"] = 128, ["y"] = 16};

function dropochieve_OnLoad()
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	DEFAULT_CHAT_FRAME:AddMessage("|cFF"..dropochieve["Color"]..dropochieve["Name"].." loaded. Version "..dropochieve["Version"]..".|r");
	dropochieve["target"] = nil
	dropochieve["target_fails"] = false;
	dropochieve["cooldown"] = 0
	dropochieve["achievements_cur"] = 0
	dropochieve["Achievements"] =
	{
		["FrameIronbones"] = {
			["ID"]=1,
			["name"]="%[Iron Bones%]",
			["icon"]="Trade_BlackSmithing",
			["description"]="Reach level 60 without at\nany point repairing the\ndurability of an item."
		},
		["FrameTimeismoney"] = {
			["ID"]=2,
			["name"]="%[Time is money%]",
			["icon"]="INV_Misc_Coin_05",
			["description"]="Reach level 60 without at\nany point using the auction\nhouse to buy an item."
		},
		["FrameKillertrader"] = {
			["ID"]=3,
			["name"]="%[Killer Trader%]",
			["icon"]="INV_Misc_Coin_03",
			["description"]="Reach level 60 without at\nany point using the auction\nhouse to sell an item."
		},
		["FramePrecious"] = {
			["ID"]=4,
			["name"]="%[My precious!%]",
			["icon"]="INV_Box_01",
			["description"]="Reach level 60 without at\nany point trading goods or\nmoney with another player."
		},
		["FrameMail"] = {
			["ID"]=5,
			["name"]="%[Special Deliveries%]",
			["icon"]="INV_Crate_03",
			["description"]="Reach level 60 without at\nany point getting goods\nor money from the mail."
		},
		["FrameOnlyfan"] = {
			["ID"]=6,
			["name"]="%[Only Fan%]",
			["icon"]="INV_Pants_Wolf",
			["description"]="Reach level 60 without at\nany point equipping anything\nelse than weapons, shields,\nammos, tabards or bags."
		},
		["FrameHelpyourself"] = {
			["ID"]=7,
			["name"]="%[Help Yourself%]",
			["icon"]="INV_Misc_Note_02",
			["description"]="Reach level 60 without at\nany point turning in a quest\n(class and profession quests\nallowed)."
		},
		["FrameMisterwhite"] = {
			["ID"]=8,
			["name"]="%[Mister White%]",
			["icon"]="INV_Shirt_White_01",
			["description"]="Reach level 60 without at\nany point equipping an\nuncommon or greater\nquality item (only white\nand grey items allowed)."
		},
		["FrameMarathonrunner"] = {
			["ID"]=9,
			["name"]="%[Marathon Runner%]",
			["icon"]="INV_Gizmo_RocketBoot_01",
			["description"]="Reach level 60 without at\nany point learning a riding skill."
		},
		["FrameSouthpark"] = {
			["ID"]=10,
			["name"]="%[That Which Has No Life%]",
			["icon"]="Ability_Hunter_Pet_Boar",
			["description"]="Reach level 60 only by killing boars."
		},
		["FrameSofthands"] = {
			["ID"]=11,
			["name"]="%[Soft Hands%]",
			["icon"]="Spell_Holy_LayOnHands",
			["description"]="Reach level 60 without at\nany point learning any\nprimary profession."
		},
		["FrameLonewolf"] = {
			["ID"]=12,
			["name"]="%[Lone Wolf%]",
			["icon"]="Spell_Nature_SpiritWolf",
			["description"]="Reach level 60 without at\nany point grouping with\nother players."
		},
		["FrameGrounded"] = {
			["ID"]=13,
			["name"]="%[Grounded%]",
			["icon"]="Spell_Nature_StrengthOfEarthTotem02",
			["description"]="Reach level 60 without at\nany point using flying services."
		},
		["FrameSelfmade"] = {
			["ID"]=14,
			["name"]="%[Self%-made%]",
			["icon"]="INV_Hammer_20",
			["description"]="Reach level 60 without at\nany point equipping items\nthat you did not craft yourself."
		},
	}
	dropochieve["frame_main"] = CreateFrame("Frame","FrameDropochieveMain",UIParent);
	dropochieve["frame_main"]:SetPoint("CENTER",UIParent,"CENTER");
	dropochieve["frame_main"]:SetMovable(true);
	dropochieve["frame_main"]:SetHeight(500);
	dropochieve["frame_main"]:SetWidth(dropochieve["subframesize"]["x"]+5*dropochieve["iconsize"]["x"]+2*dropochieve["subframegap"]["x"]);
	dropochieve["frame_main"]:EnableMouse(true);
	dropochieve["frame_main"]:SetScript("OnMouseDown",dropochieve_OnMouseDown)
	dropochieve["frame_main"]:SetScript("OnMouseUp", dropochieve_OnMouseUp)
	dropochieve["frame_main"]:SetBackdrop({
		--bgFile = "Interface\\AddOns\\"..dropochieve["Name"].."\\whitesquare2"
		bgFile = "Interface\\Buttons\\WHITE8X8.blp"
	}
	);
	--dropochieve["frame_main"]:SetBackdrop({
	--	bgFile = "Interface\\Icons\\"..dropochieve["Achievements"]["FrameSelfmade"]["icon"]..".blp"
	--}
	--);
	dropochieve["frame_main"]:SetBackdropColor(0,0,0,.5);
	dropochieve["frame_main"]:SetClampedToScreen(true);
	dropochieve["achievements_num"] = 0
	local parentFrame,iconFrame,textFrame
	dropochieve["frame_title"] = dropochieve["frame_main"]:CreateFontString("DropochieveTitle");
	dropochieve["frame_title"]:SetPoint("TOP",dropochieve["frame_main"],"TOP",0,-2);
	dropochieve["frame_title"]:SetFont(GameFontNormal:GetFont(),12);
	dropochieve["frame_close"] = CreateFrame("Button",nil,dropochieve["frame_main"])
	dropochieve["frame_close"]:SetBackdrop({bgFile = "Interface\\Buttons\\UI-Panel-MinimizeButton-Up.blp"});
	dropochieve["frame_close"]:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight.blp")
	--dropochieve["frame_close"]:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down.blp")
	dropochieve["frame_close"]:SetPoint("BOTTOMRIGHT",dropochieve["frame_main"],"BOTTOMRIGHT",0,0);
	dropochieve["frame_close"]:SetWidth(32);
	dropochieve["frame_close"]:SetHeight(32);
	dropochieve["frame_close"]:SetScript("OnClick",function()
		dropochieve["frame_main"]:Hide();
	end);	


	for i,v in pairs(dropochieve["Achievements"]) do
		-- parent frame for an individual achievement
		parentFrame = CreateFrame("Frame",i.."Parent",dropochieve["frame_main"])
		parentFrame:SetPoint("TOPLEFT",dropochieve["frame_main"],"TOPLEFT",dropochieve["subframegap"]["x"],-(dropochieve["subframesize"]["y"]+dropochieve["subframegap"]["y"])*v["ID"]);
		parentFrame:SetWidth(dropochieve["subframesize"]["x"]);
		parentFrame:SetHeight(dropochieve["subframesize"]["y"]);
		parentFrame:EnableMouse(true);
		parentFrame:SetScript("OnEnter",dropochieve_OnMouseEnter);
		parentFrame:SetScript("OnLeave",dropochieve_OnMouseLeave);
		-- icon frame for the achievement
		iconFrame = CreateFrame("Frame",i.."Icon",parentFrame)
		iconFrame:SetPoint("LEFT",parentFrame,"LEFT",0,0);
		iconFrame:SetWidth(dropochieve["iconsize"]["x"]);
		iconFrame:SetHeight(dropochieve["iconsize"]["y"]);
		iconFrame:SetBackdrop({bgFile = "Interface\\Icons\\"..v["icon"]..".blp"});
		-- text frame for the achievement
		textFrame = parentFrame:CreateFontString(i.."Text");
		textFrame:SetPoint("LEFT",iconFrame,"LEFT",dropochieve["subframegap"]["x"]+dropochieve["iconsize"]["x"],0);
		textFrame:SetFont(GameFontNormal:GetFont(),10);
		textFrame:SetText(
			string.gsub(v["name"],"%%","")
			);
		v["FrameParent"] = parentFrame;
		v["FrameParent"]:SetAlpha(0.3);
		dropochieve["achievements_num"] = dropochieve["achievements_num"] + 1
	end
	dropochieve["frame_main"]:SetHeight((dropochieve["subframesize"]["y"]+dropochieve["subframegap"]["y"])*(1+dropochieve["achievements_num"]));
end

function dropochieve_OnEvent(event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
	if string.find(arg1,"'s achievements:") then
		dropochieve["target"] = string.sub(arg1,1,string.find(arg1,"'s achievements")-1);
		dropochieve["target_fails"] = false;
		dropochieve["frame_close"]:SetButtonState("NORMAL",false);
		dropochieve["frame_main"]:Show();
		for i,v in pairs(dropochieve["Achievements"]) do
			v["FrameParent"]:SetAlpha(0.3);
		end
		dropochieve["frame_title"]:SetText("|cFFFFFF00"..dropochieve["target"].."'s Achievements:|r");
		return
	elseif string.find(arg1,"Listing achievements...") then
		dropochieve["target"] = UnitName("player");
		dropochieve["target_fails"] = true;
		dropochieve["frame_close"]:SetButtonState("NORMAL",false);
		dropochieve["frame_main"]:Show();
		for i,v in pairs(dropochieve["Achievements"]) do
			v["FrameParent"]:SetAlpha(0.3);
		end
		dropochieve["frame_title"]:SetText("|cFFFFFF00"..dropochieve["target"].."'s Achievements:|r");
		return
	end
    for i,v in pairs(dropochieve["Achievements"]) do
        if string.find(arg1,v["name"]) and not string.find(arg1,"(failed)") then
        	v["FrameParent"]:SetAlpha(1);
			break;
        end
    end
end

function dropochieve_OnUpdate()
	--if dropochieve["cooldown"] > 0 then 
	--	dropochieve["cooldown"] = dropochieve["cooldown"] - 1
	--	if dropochieve["cooldown"] == 0 and dropochieve["target"] ~= nil then
	--		UIErrorsFrame:AddMessage(dropochieve["target"].." has "..dropochieve["achievements_cur"].."/"..dropochieve["achievements_num"].." achievements.");
	--		dropochieve["target"] = nil
	--	end
	--end
end

function dropochieve_OnMouseDown()
	dropochieve["frame_main"]:StartMoving()
end

function dropochieve_OnMouseUp()
	dropochieve["frame_main"]:StopMovingOrSizing()
end
function dropochieve_OnMouseEnter()
	local tooltip_title = dropochieve["Achievements"][string.gsub(this:GetName(),"Parent","")]["name"];
	tooltip_title = string.gsub(tooltip_title,"%[","");
	tooltip_title = string.gsub(tooltip_title,"%]","");
	tooltip_title = string.gsub(tooltip_title,"%%","");
    GameTooltip:SetOwner(this)
    GameTooltip:SetWidth(128)
    GameTooltip:SetPoint("BOTTOMRIGHT", this, "BOTTOMRIGHT", 0, 0)
    GameTooltip:SetText("|cFFFFFFFF"..tooltip_title.."|r")
    GameTooltip:AddLine(dropochieve["Achievements"][string.gsub(this:GetName(),"Parent","")]["description"]);
    GameTooltip:Show();
end
function dropochieve_OnMouseLeave()
	GameTooltip:Hide();
end