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

function performDeathRoll(draginfo, rActor, bAuto)
	local rRoll = { };
	if bAuto then
		rRoll.sType = "death_auto";
	else
		rRoll.sType = "death";
	end
	rRoll.aDice = DiceRollManager.getActorDice({ "d20" }, rActor);
	rRoll.nMod = 0;
	
	rRoll.sDesc = "[DEATH]";
	
	ActionsManager.performAction(draginfo, rActor, rRoll);
end
