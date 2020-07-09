#include "rb_include"

//::///////////////////////////////////////////////
//:: FileName con_ac_sleep
//:: Mariner guard falls asleep
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/29/2005 12:35:30 AM
//:://////////////////////////////////////////////
void ahcSleep(object oTarget)
{
    effect eMind = EffectVisualEffect(VFX_IMP_SLEEP);

    AssignCommand(oTarget,ClearAllActions(TRUE));
    AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,999999.9));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oTarget);
    DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oTarget));
    DelayCommand(8.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMind, oTarget));
    CreateObject(OBJECT_TYPE_ITEM, "key_c1ar0302", GetLocation(GetObjectByTag("ac_keydrop")));
    AssignCommand(oTarget,ActionDoCommand(SetCommandable(TRUE,oTarget)));
    AssignCommand(oTarget,SetCommandable(FALSE,oTarget));
    SetLocalInt(oTarget, "nSleepy", 1);
}

void main()
{
    object oPC = GetPCSpeaker();

    GiveXPToCreature(oPC, 100);
    // remove whiskey from player's inventory
    TakeSingleItem(oPC, "ac_taintedharbor");
    // guard falls asleep
    ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 2.0);
    DelayCommand(2.1,ahcSleep(OBJECT_SELF));
    DelayCommand(2.2, FloatingTextStringOnCreature("The guard drops something as he falls.", oPC));

    // remove the key (it was dropped) from the guard
    object oKey = GetItemPossessedBy(OBJECT_SELF, "key_c1ar0302");
    if (GetIsObjectValid(oKey))
        DestroyObject(oKey);
}
