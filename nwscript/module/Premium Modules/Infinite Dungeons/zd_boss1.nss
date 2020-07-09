#include "inc_id_liltimmy"

void main()
{
    PrintString("");
    PrintString("Information for boss Baccha");

    int nNum = GetLocalInt(GetModule(), "bBacchaSurrender");
    PrintString("bBacchaSurrender " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bBacchaSurrender2");
    PrintString("bBacchaSurrender2 " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bBacchaQuestActive");
    PrintString("bBacchaQuestActive " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bBacchaQuestItemFound");
    PrintString("bBacchaQuestItemFound " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bBacchaCompleted");
    PrintString("bBacchaCompleted " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bBacchaHostile");
    PrintString("bBacchaHostile " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bBacchaDead");
    PrintString("bBacchaDead " + IntToString(nNum));

    PrintString("");
}
