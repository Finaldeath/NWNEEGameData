void main()
{
    object oPC = GetEnteringObject();
    object oAstar = GetNearestObjectByTag("Astar", oPC);

    if (GetIsPC(oPC) && (GetLocalInt(oPC, "astartrigger") == 1))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        // SetCutsceneMode(oPC, TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 4.0);

        AssignCommand(oAstar, ClearAllActions());
        DelayCommand(0.2, AssignCommand(oAstar, ActionMoveToObject(oPC, FALSE)));
        DelayCommand(3.0, AssignCommand(oAstar, ActionStartConversation(oPC)));
    }
}

