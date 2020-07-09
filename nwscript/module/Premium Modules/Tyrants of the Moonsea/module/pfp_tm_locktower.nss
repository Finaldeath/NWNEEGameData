//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: pfp_tm_locktower
// DATE: October 7, 2005
// AUTH: Luke Scull
// NOTE: Starts Noric conversation.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    //Don't start a conversation if Noric has fallen to his death
    if(GetLocalInt(GetModule(), "nNoricPlummet") == 0)
    {
        ActionStartConversation(GetFirstPC(), "tm_towerguard");
    }
}
