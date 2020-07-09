const string SHOUT_TEXT = "You there, halt. I saw you around here earlier. I require a moment of your time, citizen.";

void main()
{

    // We only do the shout if we haven't had this conv yet.
    if(GetLocalInt(GetModule(), "luce_001_done") == TRUE) return;

    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == EVENT_HEARTBEAT)
    {
        if (IsInConversation(OBJECT_SELF) == FALSE)
        {
            SpeakString(SHOUT_TEXT);
        }
    }
}
