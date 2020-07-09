//::///////////////////////////////////////////////
//:: FileName con_ac_sleep
//:: Mariner guard falls asleep
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/29/2005 12:35:30 AM
//:://////////////////////////////////////////////
// Modified by Phil Mitchell for his own devious purposes :-)

void createkey()
{
    CreateObject(OBJECT_TYPE_ITEM, "pm_keyar0501", GetLocation(GetObjectByTag("pm_barracudakeydrop")));
}

void ahcSleep(object oTarget)
{
    // remove they key we are going to drop
    object oKey = GetItemPossessedBy(oTarget, "pm_keyar0501");
    if (GetIsObjectValid(oKey))
        DestroyObject(oKey);

    // fall asleep
    effect eMind = EffectVisualEffect(VFX_IMP_SLEEP);
    AssignCommand(oTarget,ClearAllActions(TRUE));
    AssignCommand(oTarget,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,9999999.0));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMind, oTarget);
    AssignCommand(oTarget,ActionDoCommand(SetCommandable(TRUE,oTarget)));
    AssignCommand(oTarget,SetCommandable(FALSE,oTarget));
    DelayCommand(5.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eMind, oTarget));
}

void main()
{
    object oPC = GetPCSpeaker();
    object oCrew1 = GetNearestObjectByTag("pm_barracudacrew", oPC);
    object oCrew2 = GetNearestObjectByTag("pm_barracudacre2", oPC);
    ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 2.0);
    AssignCommand(oCrew1, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 2.0));
    DelayCommand(2.1,ahcSleep(oCrew2));
    DelayCommand(2.2,ahcSleep(oCrew1));
    DelayCommand(2.2,createkey());
    ActionTakeItem(GetItemPossessedBy(oPC, "a2_fillianbrew"), oPC);
    DelayCommand(2.2, FloatingTextStringOnCreature("The half orc drops something as he falls.", oPC));
}
