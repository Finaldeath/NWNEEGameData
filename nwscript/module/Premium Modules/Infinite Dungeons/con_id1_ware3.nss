#include "inc_id1_debug"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    string sSinglePlayer = GetPCPublicCDKey(oPC, TRUE);
    string sMultiPlayer = GetPCPublicCDKey(oPC, FALSE);
    DebugMessage("Single player = " + sSinglePlayer + ", Multiplayer = " + sMultiPlayer);

    if ((sSinglePlayer == sMultiPlayer) || (sMultiPlayer == ""))
    {
        object oToken = GetItemPossessedBy(oPC, "id1_TokenMastery");
        if (oToken != OBJECT_INVALID)
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
