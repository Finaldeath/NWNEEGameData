//B W-Husey (B G P Hughes)
// September 2005
// PC has at least one henchman within conversation range.
// Make sure there is a response for each possible, or the
// conversation will fail.
#include "cu_functions"
int StartingConditional()
{
    object oHench = ReturnHenchman(GetPCSpeaker(),1);
    object oHench2 = ReturnHenchman(GetPCSpeaker(),2);
    if (oHench != OBJECT_INVALID && GetDistanceToObject(oHench)<10.0)
    return TRUE;
    if (oHench2 != OBJECT_INVALID && GetDistanceToObject(oHench2)<10.0)
    return TRUE;

    return FALSE;
}
