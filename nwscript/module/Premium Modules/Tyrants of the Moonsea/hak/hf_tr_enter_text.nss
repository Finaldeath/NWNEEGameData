// Speak string script for triggers, takes text from local variable
//   HF_TEXT - floating text to display above the player

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC) && (GetLocalInt(OBJECT_SELF, "nDone") == 0))
    {
        SetLocalInt(OBJECT_SELF, "nDone", 1);
        string sText = GetLocalString(OBJECT_SELF, "HF_TEXT");
        AssignCommand(oPC, SpeakString(sText));
    }
}
