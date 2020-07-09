// heartbeat script used on an invisible "controller" object to give players a bonus
// when all the creatures from a random world map encounter are defeated

#include "hf_in_worldmap"

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
                MapEncounterComplete(oPC); // xp reward
            }
        }
    }
}
