//::///////////////////////////////////////////////
//:: FileName ac_taintedharbor
//:: Player falls asleep when he/she drinks tainted whisky
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 1/29/2006
//:://////////////////////////////////////////////
#include "x2_inc_switches"
void ahcSleep(object oTarget)
{
    effect eMind = EffectVisualEffect(VFX_IMP_SLEEP);
    SetCutsceneMode(oTarget, TRUE);
    DelayCommand(4.0,SetCutsceneMode(oTarget, FALSE));
    AssignCommand(oTarget,ClearAllActions(TRUE));
    AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,4.0));
    DelayCommand(2.0,FadeToBlack(oTarget));
    DelayCommand(3.0,FadeFromBlack(oTarget));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oTarget);
}
void main()
{
  int nEvent = GetUserDefinedItemEventNumber();
  if (nEvent == X2_ITEM_EVENT_ACTIVATE)
  {
  object oPC = GetItemActivator();
  ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 2.0);
  DelayCommand(2.1,ahcSleep(oPC));
}
}
