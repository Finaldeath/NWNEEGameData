#include "inc_id1_score"
#include "inc_id1_utility"

int StartingConditional()
{
    // if quest is not activated
    int nPlot = GetLocalInt(OBJECT_SELF, "nPlot");
    object oDungeon = GetCurrentDungeon();
    int bActivated = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Activated");

    // if player is not part of this persons quest
    object oPC = GetPCSpeaker();
    string sIdentifier = GetPCIdentifier(oPC);
    int bMember = GetLocalInt(oDungeon, "bPlot" + IntToString(nPlot) + "Player_" + sIdentifier);

    if ((bActivated == TRUE) && (bMember == TRUE))
    {
        return TRUE;
    } else
    {
        return FALSE;
    }
}
