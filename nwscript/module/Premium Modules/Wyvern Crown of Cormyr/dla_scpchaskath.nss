//B W-Husey (B G P Hughes)
// November 2005
// PC has Kathryn

#include "cu_functions"
int StartingConditional()
{
    if (GetAssociate(ASSOCIATE_TYPE_HENCHMAN,GetPCSpeaker()) == OBJECT_INVALID)
    return FALSE;
    if (GetInParty("Kathryn",GetPCSpeaker()) == TRUE)
    return TRUE;
    else
    return FALSE;
}
