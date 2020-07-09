
const float JUMP_DISTANCE = 3.0f; // Jumps the NPCs in, if too far away

void main()
{
    object oPC = GetEnteringObject();
    object oLyressa = GetNearestObjectByTag("Lyressa", oPC);

    if ( GetIsPC(oPC) &&
         GetIsObjectValid(oLyressa) &&
         (GetLocalInt(OBJECT_SELF, "nDone") == 0) )
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);
        SetLocalInt(oPC, "hench_interject", 4);

        AssignCommand(oPC, ClearAllActions(TRUE));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 3.0);

        AssignCommand(oLyressa, ClearAllActions(TRUE));
        if (GetDistanceBetween(oPC, oLyressa) > JUMP_DISTANCE)
        {
            AssignCommand(oLyressa, JumpToLocation(GetLocation(oPC)));
        }
        DelayCommand(0.5f, AssignCommand(oLyressa, ActionStartConversation(oPC, "tm_hench_inter")));
    }
}
