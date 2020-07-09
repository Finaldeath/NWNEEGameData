void main()
{
    object oPC = GetLastUsedBy();

    string sText;

    sText = "<cþþ > test1 </c>"; // yellow
    AssignCommand(oPC, SpeakString(sText));

    sText = "<cþP > test2 </c>"; // orange
    AssignCommand(oPC, SpeakString(sText));

    sText = "<cþ  > test3 </c>"; // red
    AssignCommand(oPC, SpeakString(sText));

    sText = "<c þ > test4 </c>"; // green
    AssignCommand(oPC, SpeakString(sText));

    sText = "<c þþ> test5 </c>"; // cyan
    AssignCommand(oPC, SpeakString(sText));
}

