const string STRING1 = "[Lady Tasina] But I need that statue!";
const string STRING2 = "[Rahman Madani] It's a ridiculously valuable artifact and it's mine!";
const string STRING3 = "[Captain Allendry] Stop this foolishness at once! Both of you!";
const string STRING4 = "[Lady Tasina] Captain, you don't understand.";
const string STRING5 = "[Captain Allendry] Master Madani brought it aboard. If you wish to purchase it from him, name a price...";
const string STRING6 = "[Rahman Madani] Hmph! And know that you're competing with all the collectors of Calimshan!";
const string STRING7 = "[Lady Tasina] But it doesn't belong to him!";

void SpeakWrapper(object oSpeaker, string sLine);

void main()
{
    object oPC = GetEnteringObject();
    object oDoor = GetObjectByTag("a0rn_chatdoor");
    int iDoOnce = GetLocalInt(OBJECT_SELF, "DOONCE");

    if ((iDoOnce == FALSE)&&(GetIsPC(oPC) == TRUE))
    {
        SetLocalInt(OBJECT_SELF, "DOONCE", TRUE);

        DelayCommand(0.2f, SpeakWrapper(oDoor, STRING1));
        DelayCommand(7.4f, SpeakWrapper(oDoor, STRING2));
        DelayCommand(15.2f, SpeakWrapper(oDoor, STRING3));
        DelayCommand(25.3f, SpeakWrapper(oDoor, STRING4));
        DelayCommand(30.5f, SpeakWrapper(oDoor, STRING5));
        DelayCommand(38.8f, SpeakWrapper(oDoor, STRING6));
        DelayCommand(46.1f, SpeakWrapper(oDoor, STRING7));
    }
}

void SpeakWrapper(object oSpeaker, string sLine)
{
    object oDoor = GetObjectByTag("a0rn_chatdoor");
    int iCutStart = GetLocalInt(oDoor, "iCutStart");

    if ((IsInConversation(oDoor) == FALSE) && (iCutStart == FALSE))
    {
        AssignCommand(oSpeaker, SpeakString(sLine));
    }
}

