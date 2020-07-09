// September 2005
// B W-Husey
// This NPC has never been asked for a rumour and will have his initial rumour dialogue available

int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF,"nMyRumour")==0)
    return TRUE;

    return FALSE;
}
