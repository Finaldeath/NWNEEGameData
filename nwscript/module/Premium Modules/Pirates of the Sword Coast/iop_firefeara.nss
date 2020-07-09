//::///////////////////////////////////////////////
//:: Aura of Fire of Fire On Enter
//:: iop_firefeara
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script will apply a "fear" effect if the
    creatures enter the Area of Effect object.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: November 9, 2004
//:://////////////////////////////////////////////

void Frighten (object oTarget);
void Disappear (object oTarget);

void main()
{
    object oEntering = GetEnteringObject();
    object oPC = GetAreaOfEffectCreator();

    effect eWill = EffectVisualEffect(VFX_IMP_WILL_SAVING_THROW_USE);

    int iFearsFire = GetLocalInt(oEntering, "iFEARFIRE");
    int iSave;

    if (iFearsFire != FALSE)
    {
        iSave = WillSave(oEntering, 20, SAVING_THROW_TYPE_FEAR);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eWill, oEntering);

        if ((iFearsFire == 1) &&(iSave == FALSE))
        {
            Frighten(oEntering);
        }
        else if (iFearsFire == 2)
        {
            Disappear(oEntering);
        }
    }
}

void Frighten (object oTarget)
{
    effect eFear = EffectFrightened();
    effect eVis1 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);

    eFear = EffectLinkEffects(eVis1, eFear);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eFear, oTarget, 20.0f);
}

void Disappear (object oTarget)
{
    effect eDisappear = EffectDisappear();
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDisappear, oTarget);
}
