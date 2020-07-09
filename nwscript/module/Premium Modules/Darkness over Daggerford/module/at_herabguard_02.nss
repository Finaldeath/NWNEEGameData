// the guards in the barracuda attack the player (unless they are leaving)

void GoHostile(string sTag, object oPC)
{
    int i = 1;
    object o = GetNearestObjectByTag(sTag, oPC, i);
    while (GetIsObjectValid(o))
    {
        if (GetLocalInt(o, "HF_EXIT_STARTED") == 0)
        {
            ChangeToStandardFaction(o, STANDARD_FACTION_HOSTILE);
            AssignCommand(o, ClearAllActions());
            AssignCommand(o, ActionAttack(oPC));
        }
        o = GetNearestObjectByTag(sTag, oPC, ++i);
    }
}


void main()
{
    object oPC = GetPCSpeaker();
    GoHostile("ks_griffon_guard", oPC);
}
