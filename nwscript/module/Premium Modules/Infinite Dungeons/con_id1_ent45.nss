// 1 = active, but unoccupied
// 2 = active and occupied
// 3 = plot dungeon
// 4 = no dungeon

#include "inc_id1_debug"

int StartingConditional()
{
    int nDungeonState = GetLocalInt(OBJECT_SELF, "nDungeonState");
    if ((nDungeonState == 1) || (nDungeonState == 2) || (nDungeonState == 4))
    {
        object oPC = GetPCSpeaker();
        string sSinglePlayer = GetPCPublicCDKey(oPC, TRUE);
        string sMultiPlayer = GetPCPublicCDKey(oPC, FALSE);
        DebugMessage("Single player = " + sSinglePlayer + ", Multiplayer = " + sMultiPlayer);

        if ((sSinglePlayer == sMultiPlayer) || (sMultiPlayer == ""))
        {
            return TRUE;
        } else
        {
            return FALSE;
        }
    } else
    {
        return FALSE;
    }
}
