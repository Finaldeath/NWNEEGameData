//returns true if the PC has agreed to help the farmers and is quests active
//Author: Damian Brown (Luspr)
//Date: 02-Aug-2005
int StartingConditional()
{
    if(GetLocalInt(GetModule(),"help_hevesar")==2)
    return TRUE;
    return FALSE;
}
