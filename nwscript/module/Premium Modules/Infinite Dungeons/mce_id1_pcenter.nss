#include "inc_id1_debug"

void main()
{
    // detect to see if a player is entering the dungeon
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) == TRUE)
    {
        string sTag = GetTag(oPC);
        DebugMessage("Player entered with tag " + sTag);

        if (GetLocalInt(GetModule(), "bLevelPlayers") == TRUE)
        {
            DebugMessage("  Must level player if needed.");
            int nXP = GetXP(oPC);
            DebugMessage("  Player has " + IntToString(nXP) + " xp");
            if (nXP < 10000)
            {
                GiveXPToCreature(oPC, 10000 - nXP);
            }
        }

        // if a PC is already in the game, jump the new guy to them
        object oFirst = GetFirstPC();
        if (oFirst != OBJECT_INVALID)
        {
            if (oFirst != oPC)
            {
                AssignCommand(oPC, JumpToObject(oFirst));
            }
        }
    }
}
