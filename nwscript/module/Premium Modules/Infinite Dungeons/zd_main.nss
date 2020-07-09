#include "inc_id_liltimmy"

void main()
{
    PrintString("");

    // plot state
    int nNum = lt_GetDungeonLevel();
    PrintString("Main plot state is " + IntToString(nNum));

    // bosses
    nNum = lt_GetFirstLieutenant();
    PrintString("First lieutenant is " + IntToString(nNum));
    nNum = lt_GetSecondLieutenant();
    PrintString("Second lieutenant is " + IntToString(nNum));
    nNum = lt_GetThirdLieutenant();
    PrintString("Third lieutenant is " + IntToString(nNum));
    nNum = lt_GetFirstBoss();
    PrintString("First boss is " + IntToString(nNum));
    nNum = lt_GetSecondBoss();
    PrintString("Second boss is " + IntToString(nNum));
    nNum = lt_GetThirdBoss();
    PrintString("Third boss is " + IntToString(nNum));

    // trigger
    nNum = GetLocalInt(GetModule(), "nTriggerPlot");
    PrintString("Cutscene trigger is " + IntToString(nNum));

    PrintString("");
}
