#include "ddf_util"

int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    object oLeader = GetFactionLeader(oPC);
    iResult = oPC != oLeader;
    debug(IntToString(iResult));
    return iResult;
}
