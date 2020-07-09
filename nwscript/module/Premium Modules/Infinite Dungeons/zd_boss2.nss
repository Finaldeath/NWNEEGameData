#include "inc_id_liltimmy"

void main()
{
    PrintString("");
    PrintString("Information for boss Hagatha");

    int nNum = GetLocalInt(GetModule(), "bHagathaSurrender");
    PrintString("bHagathaSurrender " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHagathaSurrender2");
    PrintString("bHagathaSurrender2 " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHagathaQuestActive");
    PrintString("bHagathaQuestActive " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHagathaQuestItemFound");
    PrintString("bHagathaQuestItemFound " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHagathaCompleted");
    PrintString("bHagathaCompleted " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHagathaHostile");
    PrintString("bHagathaHostile " + IntToString(nNum));
    nNum = GetLocalInt(GetModule(), "bHagathaDead");
    PrintString("bHagathaDead " + IntToString(nNum));

    PrintString("");
}
