// is the player in "lizardman form"? dispel it if so.
// .. also dispels polymorph on henchmen

int IsPolymorphed(object oPC)
{
    object oMod = GetModule();
    int rc = FALSE;
    effect ePoly = GetFirstEffect(oPC);
    while (GetIsEffectValid(ePoly))
    {
        if (GetEffectType(ePoly) == EFFECT_TYPE_POLYMORPH)
        {
            if (GetEffectCreator(ePoly) == oMod)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oPC);
                RemoveEffect(oPC, ePoly);
                rc = TRUE;
                break;
            }
        }
        ePoly = GetNextEffect(oPC);
    }
    return(rc);
}

int StartingConditional()
{
    int i = 1;
    object oPC = GetPCSpeaker();
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        IsPolymorphed(oHench);
        oHench = GetHenchman(oPC, ++i);
    }
    return(IsPolymorphed(oPC));
}
