void main()
{
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        // commoner
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 100, oPC);
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 100, oPC);
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 100, oPC);
        SetStandardFactionReputation(STANDARD_FACTION_HOSTILE, 0, oPC);

        // neutral
        ClearPersonalReputation(GetObjectByTag("DungeonAngel"), oPC);

        oPC = GetNextPC();
    }
}
