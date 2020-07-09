//returns true if the PC has already met hevesar
//Author: Damian Brown (Luspr)
//Date: 28-07-2005
int StartingConditional()
{
    if (GetLocalInt(GetModule(), "hevesar_quest")==1)
    return TRUE;
    return FALSE;
}
