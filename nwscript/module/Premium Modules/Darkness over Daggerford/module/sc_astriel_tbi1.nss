//Starting Conditional for astriel in Chateu Elite
//This will check if the PC has the relevant journal entry and status
//Author: Phil Mitchell (Baron of Gateford)
//
int StartingConditional()
{
    if (GetLocalInt(GetModule(),"the_blackstone_inn") == 1 ||
        GetLocalInt(GetModule(),"the_blackstone_inn") == 2)
        return TRUE;
    return FALSE;
}
