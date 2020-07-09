const string STRING1 = "For the final time, get this artifact into the crate!";
const string STRING2 = "After what happened to Martins!? I ain't touching this thing.";
const string STRING3 = "Don't cross me, peasant!";
const string STRING4 = "It'll take stronger words then that, mage.";
const string STRING5 = "Uh, I just wanna know why Martins runned away...";

void SpeakWrapper(object oSpeaker, string sLine);

void main()
{
    object oPC = GetEnteringObject();
    object oDock1 = GetObjectByTag("a0_dockhand1", 0);
    object oDock2 = GetObjectByTag("a0_dockhand2", 1);
    object oRahman = GetObjectByTag("a0_rahman");

    int iDoOnce = GetLocalInt(OBJECT_SELF, "DOONCE");

    if ((GetIsPC(oPC) == TRUE)&& (iDoOnce == FALSE))
    {
        SetLocalInt(OBJECT_SELF, "DOONCE", TRUE);

        DelayCommand(0.5,  SpeakWrapper(oRahman, STRING1));
        DelayCommand(3.5, SpeakWrapper(oDock1, STRING2));
        DelayCommand(6.5, SpeakWrapper(oRahman, STRING3));
        DelayCommand(9.5, SpeakWrapper(oDock1, STRING4));
        DelayCommand(12.5, SpeakWrapper(oDock2, STRING5));

    }
}

void SpeakWrapper(object oSpeaker, string sLine)
{
    object oThug1 = GetObjectByTag("a0_rahman");

    if (IsInConversation(oThug1)== FALSE)
    {
        AssignCommand(oSpeaker, SpeakString(sLine));
    }
}

