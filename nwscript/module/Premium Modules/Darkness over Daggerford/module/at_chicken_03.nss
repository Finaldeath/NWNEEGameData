// the butcher appears, looking for his lost chicken

void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetWaypointByTag("WP_AR1300_BUTCHER");
    object oButcher = GetNearestObjectByTag("ks_butcher", oPC);
    if (!GetIsObjectValid(oButcher))
    {
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPC);
        oButcher = CreateObject(OBJECT_TYPE_CREATURE, "ks_butcher", GetLocation(oWP));
    }
    AssignCommand(oButcher, ClearAllActions());
    AssignCommand(oButcher, ActionMoveToObject(oPC, TRUE, 1.0));
}
