// September 2005
// B W-Husey
// This NPC has refused to give a rumour (but can be persuaded et al). This is also used as a catchall
// on his random response as the default refusal.

int StartingConditional()
{
    return (GetLocalInt(OBJECT_SELF,"nMyRumour")==50);
}
