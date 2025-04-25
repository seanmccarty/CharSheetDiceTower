local fOriginalPerformDeathRoll = nil;

---Adds options to send roll types automatically to the tower, when rolled by double clicking on char sheet, when ruleset is not CoreRPG
function onInit()
	if Interface.getRuleset() ~= "CoreRPG" then
		OptionsManager.registerOption2("CSDT_option_label_initiative", false, "option_header_game", "CSDT_option_label_initiative", "option_entry_cycler",
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });
		OptionsManager.registerOption2("CSDT_option_label_ability", false, "option_header_game", "CSDT_option_label_ability", "option_entry_cycler", 
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });
		OptionsManager.registerOption2("CSDT_option_label_save", false, "option_header_game", "CSDT_option_label_save", "option_entry_cycler", 
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });
		OptionsManager.registerOption2("CSDT_option_label_skill", false, "option_header_game", "CSDT_option_label_skill", "option_entry_cycler", 
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });
	end
	if Interface.getRuleset() == "5E" then
		OptionsManager.registerOption2("CSDT_option_label_death", false, "option_header_game", "CSDT_option_label_death", "option_entry_cycler",
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "off" });

		fOriginalPerformDeathRoll = ActionSave.performDeathRoll;
		ActionSave.performDeathRoll = CSDT.performDeathRoll;
	end
end

---Overrides ActionSave.performDeathRoll to divert rolls to the tower
function performDeathRoll(draginfo, rActor, bAuto)
	-- if draginfo is defined, the icon is being dragged somewhere. Otherwise, it was a double click or death_auto, so we divert those.
	if (not draginfo) and OptionsManager.isOption("TBOX", "on") and OptionsManager.isOption("CSDT_option_label_death", "on") then
		local rRoll = ActionSave.getDeathRoll(rActor, bAuto);
		ActionsManager.applyModifiers(rActor, nil, rRoll);
		DiceTowerManager.sendRoll(rRoll, rActor);
	else
		fOriginalPerformDeathRoll(draginfo, rActor, bAuto);
	end

end
