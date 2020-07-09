// February 2006
// B W-Husey
// Witch Lord surrenders when damaged and starts bargaining

#include "cu_functions"
void main()
{

    if (GetCurrentHitPoints() <= 20  && GetLocalInt(OBJECT_SELF,"nSurrendered")<1)
    {
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    object oHench1 = ReturnHenchman(oPC,1);
    object oHench2 = ReturnHenchman(oPC,2);
//       SetPlotFlag(OBJECT_SELF, TRUE);
        SurrenderToEnemies();
//       SetIsTemporaryNeutral(GetLastDamager(),OBJECT_SELF);
//       SetIsTemporaryNeutral(oPC,OBJECT_SELF);
//       SetIsTemporaryNeutral(oHench1,OBJECT_SELF);
//       SetIsTemporaryNeutral(oHench2,OBJECT_SELF);
       ClearAllActions(TRUE);
       AssignCommand(oPC,ClearAllActions(TRUE));
       AssignCommand(oHench1,ClearAllActions(TRUE));
       AssignCommand(oHench2,ClearAllActions(TRUE));
        DelayCommand(1.0,ActionStartConversation(oPC,"witchlord1",FALSE,FALSE));
    }
    else

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------
    ExecuteScript("nw_c2_default6", OBJECT_SELF);
}
