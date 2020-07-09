#include "inc_id1_text"

int StartingConditional()
{
    string sString = "Dungeon is valid.";
    sString = AddLineBreak(sString);
    sString = AddLineBreak(sString);

    // get dungeon
    object oImport = GetLocalObject(OBJECT_SELF, "oImport");
    string sName = GetLocalString(oImport, "sDungeonName");
    int nMax = GetLocalInt(oImport, "nMaxLevel");
    int nDepth = GetLocalInt(oImport, "nDungeonDepth");

    sString += sName + " has had " + IntToString(nMax) + " out of " + IntToString(nDepth) + " levels explored. Would you like to import it in the current state, or reset it?";

    SetCustomToken(5200, sString);

    return TRUE;
}

