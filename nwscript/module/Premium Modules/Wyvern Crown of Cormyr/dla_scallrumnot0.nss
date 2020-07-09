// September 2005
// B W-Husey
// This NPC has been asked for a rumour and will have his secondary rumour dialogue available

int StartingConditional()
{
    return (GetLocalInt(OBJECT_SELF,"nMyRumour")>0);
}
