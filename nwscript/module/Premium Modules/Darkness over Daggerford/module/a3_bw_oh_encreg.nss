void encComplete(object oPC);

void main()
{
    int nNth = 1;
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, nNth);

    // look for a PC
    if (GetIsObjectValid(oPC))
    {
        if (GetLocalInt(oPC, "nREComplete") == 0)  // encounter is active for nearest pc
        {
            int nFoundHostile = 0;
            object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nNth, CREATURE_TYPE_IS_ALIVE, TRUE);

            // look for hostile creatures
            while (GetIsObjectValid(oCreature) && (nFoundHostile == 0))
            {
                if (GetStandardFactionReputation(STANDARD_FACTION_HOSTILE, oCreature) == 100)
                {
                    nFoundHostile = 1;
                }

                nNth += 1;
                oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, OBJECT_SELF, nNth, CREATURE_TYPE_IS_ALIVE, TRUE);
            }

            if (nFoundHostile == 0) // no hostile creatures found
            {
                encComplete(oPC); // xp reward
            }
        }
    }
}

// give players a message and an xp bonus
void encComplete(object oPC)
{
    object oPlayer = GetFirstFactionMember(oPC);
    int nXPAward = 10;
    int nHD;
    int nXPBonus;
    string sBonus;

    while (GetIsObjectValid(oPlayer))
    {
        if (GetLocalInt(oPlayer, "nREComplete") == 0)
        {
            nHD = GetHitDice(oPlayer);
            nXPBonus = (nXPAward * nHD);

            GiveXPToCreature(oPlayer, nXPBonus);

            SetLocalInt(oPlayer, "nREComplete", 1);

            sBonus = IntToString(nXPBonus);
            FloatingTextStringOnCreature("Encounter defeated: "+sBonus+" XP!", oPlayer, FALSE);
        }

        oPlayer = GetNextFactionMember(oPC);
    }
}
