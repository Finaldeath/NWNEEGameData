#include "dla_inc_darts"
void main()
{
    object oPC = GetLastAttacker(OBJECT_SELF);
    object oWait = GetNearestObjectByTag("dart_waiting");
    int nRound = GetDartRoundNumber();

    //do the dart calc only if playing darts
    if(GetIsPC(oPC) && !GetCutsceneMode(oPC)){return;}

    object oDart = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    //give infinite darts
    SetItemStackSize(oDart,3);
    int nThrow = GetLocalInt(oPC,"nMyDartThrow");
    nThrow++;
    SetLocalInt(oPC,"nMyDartThrow",nThrow);
    FloatingTextStringOnCreature("Throw = "+IntToString(nThrow),oPC);
    DelayCommand(1.4,AssignCommand(oPC, ClearAllActions()));
    DelayCommand(1.6,CheckDartHit(oPC));
    if(nThrow==3)
    {
        DeleteLocalInt(oPC,"nMyDartThrow");
        DeleteLocalInt(oPC,"nMyDartTurn");
        DelayCommand(2.7, IncrementDartRound(oPC));
    }
}
