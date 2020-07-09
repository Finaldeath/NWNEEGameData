// the player should hear voices when the door opens the first time
// ... unless the guards are already downstairs!

void main()
{
    object oPC = GetLastOpenedBy();
    if (GetIsPC(oPC))
    {
        if (!GetIsInCombat(oPC))
        {
            if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nDone", 1);
                if (GetLocalInt(GetModule(), "nFeldranFire") == 0 &&
                    GetLocalInt(GetModule(), "nFandocFeldranSpawned") == 0)
                {
                    // the guards are upstairs, so listen to what they have to say
                    AssignCommand(oPC, ClearAllActions(TRUE));
                    AssignCommand(oPC, ActionStartConversation(oPC, "ks_ar2001_door1", FALSE, FALSE));
                }
            }
        }
    }
}
