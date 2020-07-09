#include "ddf_util"

int StartingConditional()
{
    // should be showing the `tedd_002` options if we are in the apartment.
    if(GetCurrentArea(GetPCSpeaker()) == AREA_ALADARAS_APARTMENT) return FALSE;

    int nDay = GetCurrentDay();

    if ((nDay == 3) && (GetLocalInt(GetModule(), "ddf_tedd_smar") == TRUE || GetLocalInt(GetModule(), "ddf_tedd_met") == TRUE))
    {
        return TRUE;
    }

    return FALSE;
}
