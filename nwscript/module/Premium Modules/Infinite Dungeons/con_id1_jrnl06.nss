#include "inc_id1_utility"
#include "inc_id1_text"

int StartingConditional()
{
    string sFileName = GetLocalString(OBJECT_SELF, "sFileName");
    string sString = "Dungeon exported as " + sFileName;
    SetCustomToken(5200, sString);

    return TRUE;
}
