// place this script in the fail to open event

void main()
{
    // see if we have a custom message to display
    string s = GetLocalString(OBJECT_SELF, "HF_LOCKED_TEXT");
    if (s != "")
    {
        SpeakString(s);
        return;
    }

    // no custom message, so use our assigned dialog instead
    object oPC = GetClickingObject();
    SpeakOneLinerConversation(s, oPC);
}
