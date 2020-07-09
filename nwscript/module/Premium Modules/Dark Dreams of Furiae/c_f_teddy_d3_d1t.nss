#include "ddf_util"

int StartingConditional()
{
    // If the player is in aladar's apartment, we need to show the `tedd_002`
    // dialog options...
    if(GetCurrentArea(GetPCSpeaker()) == AREA_ALADARAS_APARTMENT) return FALSE;

    int nDay = GetCurrentDay();

    if ((nDay == 3) && (GetLocalInt(GetModule(), "ddf_tedd_smar") == FALSE && GetLocalInt(GetModule(), "ddf_teddy_met") == FALSE))
    {
        return TRUE;
    }

    return FALSE;
}
