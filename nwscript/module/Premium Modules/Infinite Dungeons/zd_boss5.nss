#include "inc_id_liltimmy"

void main()
{
    PrintString("");
    PrintString("Information for boss Gzhorb");

    int nNum = GetLocalInt(GetModule(), "bGzhorbSurrender");
    PrintString("bGzhorbSurrender " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bGzhorbSurrender2");
    PrintString("bGzhorbSurrender2 " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bGzhorbQuestActive");
    PrintString("bGzhorbQuestActive " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bGzhorbQuestItemFound");
    PrintString("bGzhorbQuestItemFound " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bGzhorbCompleted");
    PrintString("bGzhorbCompleted " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bGzhorbHostile");
    PrintString("bGzhorbHostile " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bGzhorbDead");
    PrintString("bGzhorbDead " + IntToString(nNum));

    PrintString("");
}
