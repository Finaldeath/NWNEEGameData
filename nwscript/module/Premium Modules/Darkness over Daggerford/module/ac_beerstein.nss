//::///////////////////////////////////////////////
//:: ac_beerstein based on NW_S3_Alcohol.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Makes beverages fun.
  May 2002: Removed fortitude saves. Just instant intelligence loss
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent / Edited by Anya Clancy
//:: Created On:   February 2002 / Feb. 26, 2006
//:://////////////////////////////////////////////
#include "x2_inc_switches"
void DrinkIt(object oTarget)
{
   AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
   AssignCommand(oTarget,ActionSpeakStringByStrRef(10499));
}

void MakeDrunk(object oTarget, int nPoints)
{
    if (Random(100) + 1 < 40)
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING));
    else
        AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK));

    effect eDumb = EffectAbilityDecrease(ABILITY_INTELLIGENCE, nPoints);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDumb, oTarget, 60.0);
 //   AssignCommand(oTarget, SpeakString(IntToString(GetAbilityScore(oTarget,ABILITY_INTELLIGENCE))));
}
void main()
{

  int nEvent = GetUserDefinedItemEventNumber();
  if (nEvent == X2_ITEM_EVENT_ACTIVATE)
  {

        object oTarget = GetItemActivator();
        DrinkIt(oTarget);
        MakeDrunk(oTarget, 1);
  }

}
