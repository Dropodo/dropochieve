dropochieve = {};
dropochieve["Name"] = "dropochieve";
dropochieve["Color"] = "FFAA00";
dropochieve["Version"] = "1.0";
dropochieve["Achievements"] = {};

function dropochieve_OnLoad()
	this:RegisterEvent("CHAT_MSG_SYSTEM");
	DEFAULT_CHAT_FRAME:AddMessage("|cFF"..dropochieve["Color"]..dropochieve["Name"].." loaded. Version "..dropochieve["Version"]..".|r");
	dropochieve["target"] = nil
	dropochieve["cooldown"] = 0
	dropochieve["achievements_cur"] = 0
	dropochieve["Achievements"] = {
	{["name"]="%[Iron Bones%]"},
	{["name"]="%[Time is money%]"},
	{["name"]="%[Killer Trader%]"},
	{["name"]="%[My precious!%]"},
	{["name"]="%[Special Deliveries%]"},
	{["name"]="%[Only Fan%]"},
	{["name"]="%[Help Yourself%]"},
	{["name"]="%[Mister White%]"},
	{["name"]="%[Marathon Runner%]"},
	{["name"]="%[That Which Has No Life%]"},
	{["name"]="%[Soft Hands%]"},
	{["name"]="%[Lone Wolf%]"},
	{["name"]="%[Grounded%]"},
	{["name"]="%[Self%-made%]"},
	}
	dropochieve["achievements_num"] = 0
	for _ in pairs(dropochieve["Achievements"]) do
		dropochieve["achievements_num"] = dropochieve["achievements_num"] + 1
	end
end

function dropochieve_OnEvent(event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
	res=0
	if string.find(arg1,"'s achievements:") then
		dropochieve["target"] = string.sub(arg1,1,string.find(arg1,"'s achievements")-1);
		dropochieve["cooldown"] = 30;
		dropochieve["achievements_cur"] = 0
		return
	end
    for i,j in ipairs(dropochieve["Achievements"]) do
        if string.find(arg1,j["name"]) then
        	dropochieve["achievements_cur"] = dropochieve["achievements_cur"] + 1
			break;
        end
    end
end

function dropochieve_OnUpdate()
	if dropochieve["cooldown"] > 0 then 
		dropochieve["cooldown"] = dropochieve["cooldown"] - 1
		if dropochieve["cooldown"] == 0 and dropochieve["target"] ~= nil then
			UIErrorsFrame:AddMessage(dropochieve["target"].." has "..dropochieve["achievements_cur"].."/"..dropochieve["achievements_num"].." achievements.");
			dropochieve["target"] = nil
		end
	end
end

