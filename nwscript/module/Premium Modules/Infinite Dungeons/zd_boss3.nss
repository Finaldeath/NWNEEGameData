#include "inc_id_liltimmy"

void main()
{
    PrintString("");
    PrintString("Information for boss Maggris");

    int nNum = GetLocalInt(GetModule(), "bMaggrisSurrender");
    PrintString("bMaggrisSurrender " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMaggrisSurrender2");
    PrintString("bMaggrisSurrender2 " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMaggrisQuestActive");
    PrintString("bMaggrisQuestActive " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMaggrisQuestItemFound");
    PrintString("bMaggrisQuestItemFound " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMaggrisCompleted");
    PrintString("bMaggrisCompleted " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMaggrisHostile");
    PrintString("bMaggrisHostile " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bMaggrisDead");
    PrintString("bMaggrisDead " + IntToString(nNum));

    PrintString("");
}
