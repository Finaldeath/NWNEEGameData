//Starting Conditional for astriel in Chateu Elite
//This will check if the PC has the relevant journal entry and status
//Author: Phil Mitchell (Baron of Gateford)
//
int StartingConditional()
{
    int iResult;

    iResult = GetLocalInt(GetModule(),"the_dukes_killer") == 2;
    return iResult;
}
