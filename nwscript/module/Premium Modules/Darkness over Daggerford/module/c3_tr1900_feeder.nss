// player enters the lizardfolk feeding hut and is confronted by a butcher

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nDone", 1);
            object oFeeder = GetNearestObjectByTag("ks_lizfeeder", oPC);
            if (GetObjectSeen(oPC, oFeeder))
            {
                AssignCommand(oPC, ClearAllActions());
                AssignCommand(oFeeder, ClearAllActions());
                AssignCommand(oFeeder, ActionStartConversation(oPC));
            }
        }
    }
}
