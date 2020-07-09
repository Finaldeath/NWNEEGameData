//::///////////////////////////////////////////////
//:: cac_a2_pglg_po
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Pegleg Paulson has passed out.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
void main()
{
    object oPegLeg = OBJECT_SELF;
    effect eSleep = EffectSleep();
    effect eVFX = EffectVisualEffect(VFX_IMP_SLEEP);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSleep, oPegLeg, 30.0f);

    AssignCommand(oPegLeg, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 30.0f));

    DelayCommand(0.15f, SetCommandable(FALSE, oPegLeg));

    DelayCommand(2.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPegLeg, 5.0f));
    DelayCommand(7.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPegLeg, 5.0f));
    DelayCommand(12.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPegLeg, 5.0f));
    DelayCommand(17.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPegLeg, 5.0f));
    DelayCommand(22.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPegLeg, 5.0f));
    DelayCommand(27.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVFX, oPegLeg, 5.0f));

    DelayCommand(30.5f, SetCommandable(TRUE, oPegLeg));

    SetLocalInt(GetModule(), "POTSC_PEGLEG_DRINK", 0);
}
