void main()
{
    object oPC = GetLastUsedBy();

    string sText;

    sText = "<c�� > test1 </c>"; // yellow
    AssignCommand(oPC, SpeakString(sText));

    sText = "<c�P > test2 </c>"; // orange
    AssignCommand(oPC, SpeakString(sText));

    sText = "<c�  > test3 </c>"; // red
    AssignCommand(oPC, SpeakString(sText));

    sText = "<c � > test4 </c>"; // green
    AssignCommand(oPC, SpeakString(sText));

    sText = "<c ��> test5 </c>"; // cyan
    AssignCommand(oPC, SpeakString(sText));
}

