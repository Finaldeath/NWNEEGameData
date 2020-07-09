void main()
{
    object oPC = GetEnteringObject();
    object oEremuth = GetNearestObjectByTag("Eremuth", oPC);

    if (GetIsPC(oPC) && (GetLocalInt(oPC, "eremuthtrigger") == 1))
    {
        AssignCommand(oPC, ClearAllActions(TRUE));
        // SetCutsceneMode(oPC, TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 4.0);

        AssignCommand(oEremuth, ClearAllActions(TRUE));
        DelayCommand(0.2, AssignCommand(oEremuth, ActionMoveToObject(oPC, FALSE)));
        DelayCommand(2.2, AssignCommand(oEremuth, ActionStartConversation(oPC)));
    }
}
