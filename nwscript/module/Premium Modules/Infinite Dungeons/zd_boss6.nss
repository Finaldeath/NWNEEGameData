#include "inc_id_liltimmy"

void main()
{
    PrintString("");
    PrintString("Information for boss Masterius");

    int nNum = GetLocalInt(GetModule(), "bMasteriusSurrender");
    PrintString("bMasteriusSurrender " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMasteriusSurrender2");
    PrintString("bMasteriusSurrender2 " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMasteriusQuestActive");
    PrintString("bMasteriusQuestActive " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMasteriusQuestItemFound");
    PrintString("bMasteriusQuestItemFound " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMasteriusCompleted");
    PrintString("bMasteriusCompleted " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMasteriusHostile");
    PrintString("bMasteriusHostile " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMasteriusDead");
    PrintString("bMasteriusDead " + IntToString(nNum));

    PrintString("");
}
