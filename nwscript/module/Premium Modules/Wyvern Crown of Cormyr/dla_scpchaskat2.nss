//B W-Husey (B G P Hughes)
// November 2005
// PC has Kathrynand not talked to Hawklin yet with her.

#include "cu_functions"
int StartingConditional()
{
    if (GetAssociate(ASSOCIATE_TYPE_HENCHMAN,GetPCSpeaker()) == OBJECT_INVALID)
    return FALSE;

    string sName = "Var14"+GetTag(OBJECT_SELF);       //Set variable to object's tag + extra bit
    int nOnce = GetLocalInt(GetPCSpeaker(), sName);  //Check to see if PC has tried this before
    if(nOnce==FALSE && GetInParty("Kathryn",GetPCSpeaker()) == TRUE)
    return TRUE;
    else
    return FALSE;
}
