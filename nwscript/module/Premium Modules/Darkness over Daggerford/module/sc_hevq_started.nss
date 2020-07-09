//returns true if the PC is following the hevesar quest
//Author: Damian Brown (Luspr)
//Date: 28-07-2005
int StartingConditional()
{
    if (GetLocalInt(GetModule(), "hevesar_quest")>0)
    return TRUE;
    return FALSE;
}
