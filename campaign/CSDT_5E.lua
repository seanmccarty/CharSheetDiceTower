-- Including "not draginfo" prevents triggering while dragged

function onInitAction(draginfo)
	if OptionsManager.isOption("TBOX", "on") and OptionsManager.isOption("CSDT_option_label_initiative", "on") and not draginfo then
		local rActor = ActorManager.resolveActor(getDatabaseNode());
		local rRoll = ActionInit.getRoll(rActor);
		ActionsManager.applyModifiers(rActor, nil, rRoll);
		DiceTowerManager.sendRoll(rRoll, rActor);
		return true;
	else
		return super.onInitAction(draginfo);
	end
end

function onCheckAction(draginfo, sCheck)
	if (sCheck or "") == "" then
		return false;
	end
	if OptionsManager.isOption("TBOX", "on") and OptionsManager.isOption("CSDT_option_label_ability", "on") and not draginfo then
		local rActor = ActorManager.resolveActor(getDatabaseNode());
		local rRoll = ActionCheck.getRoll(rActor, sCheck);
		ActionsManager.applyModifiers(rActor, nil, rRoll);
		DiceTowerManager.sendRoll(rRoll, rActor);
		return true;
	else
		return super.onCheckAction(draginfo, sCheck);
	end
end

function onSaveAction(draginfo, sSave)
	if (sSave or "") == "" then
		return false;
	end
	if OptionsManager.isOption("TBOX", "on") and OptionsManager.isOption("CSDT_option_label_save", "on") and not draginfo then
		local rActor = ActorManager.resolveActor(getDatabaseNode());
		local rRoll = ActionSave.getRoll(rActor, sSave);
		ActionsManager.applyModifiers(rActor, nil, rRoll);
		DiceTowerManager.sendRoll(rRoll, rActor);
		return true;
	else
		return super.onSaveAction(draginfo, sSave)
	end
end