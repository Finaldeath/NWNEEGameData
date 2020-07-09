#include "ddf_util"


int StartingConditional()
{
    int iResult = GetLocalInt(GetPCSpeaker(), "CLIMBED_IVY_WALL");

    //debug("c_f_clmb_ivy_01 - " + IntToString(iResult));

    if(iResult == TRUE) return FALSE;

    return TRUE;
}
