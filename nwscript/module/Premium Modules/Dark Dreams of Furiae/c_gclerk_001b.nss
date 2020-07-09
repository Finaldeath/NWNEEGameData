// Does not have key AND law inforcement
#include "ddf_util"
#include "x0_i0_partywide"

int StartingConditional()
{

    object oPC = GetPCSpeaker();

    if(GetIsItemPossessedByParty(oPC, "CityGuardKey") == TRUE)
        return FALSE;

    if (GetLocalInt(GetModule(), "ddf_background_flag") != BG_COP)
        return FALSE;

    return TRUE;
}
