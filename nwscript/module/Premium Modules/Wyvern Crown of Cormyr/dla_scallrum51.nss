// September 2005
// B W-Husey
// This NPC has refused to give a rumour and never will.

int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF,"nMyRumour")==51)
    return TRUE;

    return FALSE;
}
