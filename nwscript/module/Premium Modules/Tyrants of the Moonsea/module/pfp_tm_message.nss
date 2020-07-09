
const string DEFAULT_MESSAGE = "A pauper's home, there is nothing inside that could interest you.";

void main()
{
    object oPC = GetClickingObject();

    string sMessage = GetLocalString(OBJECT_SELF, "FAILOPEN_MESSAGE");
    if (sMessage == "")
        sMessage = GetLocalString(GetArea(OBJECT_SELF), "FAILOPEN_MESSAGE");
    if (sMessage == "")
        sMessage = DEFAULT_MESSAGE;

    if (sMessage != "")
        AssignCommand(oPC, SpeakString(sMessage));
}
