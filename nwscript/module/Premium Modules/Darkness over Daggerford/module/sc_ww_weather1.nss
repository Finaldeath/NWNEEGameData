//test to see if player has met weatherman willy previously
//Author: Damian Brown (Luspr)
//Date: 28-07-2005
int StartingConditional()
{
    if (GetLocalInt(GetModule(), "weatherman_willy")==1)
    return TRUE;
    return FALSE;
}
