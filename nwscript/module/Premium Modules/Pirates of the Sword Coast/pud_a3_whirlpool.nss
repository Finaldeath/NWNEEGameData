//::///////////////////////////////////////////////
//:: Act 3: Whirlpool User-Defined Event
//:: pud_a3_whirlpool.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Apply and repeat the whirlpool VFX.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 27, 2005
//:://////////////////////////////////////////////

void main()
{
    effect eCold = EffectVisualEffect(VFX_DUR_AURA_COLD);
    effect ePara = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect ePrem = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
    effect eTurn = EffectVisualEffect(VFX_DUR_SPELLTURNING);

    int iUD = GetUserDefinedEventNumber();

    if (iUD == 1000)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCold, OBJECT_SELF, 60.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePara, OBJECT_SELF, 60.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePrem, OBJECT_SELF, 60.0);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTurn, OBJECT_SELF, 60.0);

        DelayCommand(60.0, SignalEvent(OBJECT_SELF, EventUserDefined(1000)));
    }
}
