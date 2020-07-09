int StartingConditional()
{
    object oPC = GetPCSpeaker();
    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectType(eEffect)==EFFECT_TYPE_POLYMORPH)
            return TRUE;
        eEffect = GetNextEffect(oPC);
    }
    return FALSE;
}
