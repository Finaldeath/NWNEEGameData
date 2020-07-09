// stegil will talk to the player (only each time player enters the area)

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        object oArea = GetArea(oPC);
        if (GetLocalInt(oArea, "nStegilTalks") == 0)
        {
            SetLocalInt(oArea, "nStegilTalks", 1);
            object oStegil = GetNearestObjectByTag("ks_stegil", oPC);
            if (GetIsObjectValid(oStegil))
            {
                if (!GetIsEnemy(oStegil, oPC))
                {
                    AssignCommand(oPC, ClearAllActions());
                    AssignCommand(oStegil, ActionStartConversation(oPC));
                }
            }
        }
    }
}
