//B W-Husey (B G P Hughes)
// November 2005
// PC does not have Kathryn currently
#include "cu_functions"
int StartingConditional()
{
    if (GetAssociate(ASSOCIATE_TYPE_HENCHMAN,GetPCSpeaker()) == OBJECT_INVALID)
    return FALSE;
    if (GetInParty("Kathryn",GetPCSpeaker()) == FALSE)
    return TRUE;
    else
    return FALSE;
}
