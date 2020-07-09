#include "inc_id_liltimmy"

void main()
{
    PrintString("");
    PrintString("Information for boss Harat");

    int nNum = GetLocalInt(GetModule(), "bHaratSurrender");
    PrintString("bHaratSurrender " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHaratSurrender2");
    PrintString("bHaratSurrender2 " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHaratQuestActive");
    PrintString("bHaratQuestActive " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHaratQuestItemFound");
    PrintString("bHaratQuestItemFound " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHaratCompleted");
    PrintString("bHaratCompleted " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHaratHostile");
    PrintString("bHaratHostile " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHaratDead");
    PrintString("bHaratDead " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHaratOpened");
    PrintString("bHaratOpened " + IntToString(nNum));

    PrintString("");
}
