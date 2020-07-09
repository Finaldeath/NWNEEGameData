#include "dla_i1_battle"

void main()
{
    object oArea = GetArea(OBJECT_SELF);

    int nEvent = GetUserDefinedEventNumber();
    if (nEvent == DLA_EVENT_BARROWEXIT)
    {// Do Barrow Exit cutscene for finalle
        ExitBattle();
    }
    else if (nEvent == DLA_EVENT_BARROWEXIT_JONAS)
    {// Do Barrow Exit routine for Jonas (should only be fire on jonas)
        ExitBattleJonas(GetLocalObject(oArea, "oJonas"));
    }
    else if (nEvent == DLA_EVENT_BARROWEXIT_WL)
    {// Do Barrow Exit routine for the WL (should only be fire on the witchlord)
        ExitBattleWL(GetLocalObject(oArea, "BattleWL"));
    }
}
