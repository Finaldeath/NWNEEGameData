//returns true if the PC has agreed to help the farmers
//Author: Damian Brown (Luspr)
//Date: 02-Aug-2005
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"help_hevesar")==1)
    return TRUE;
    return FALSE;
}
