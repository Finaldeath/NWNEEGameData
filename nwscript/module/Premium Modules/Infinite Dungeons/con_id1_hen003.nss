int StartingConditional()
{
    int bPoisoned = FALSE;
    effect eEffect = GetFirstEffect(OBJECT_SELF);
    while ((GetIsEffectValid(eEffect) == TRUE) && (bPoisoned == FALSE))
    {
        if (GetEffectType(eEffect) == EFFECT_TYPE_POISON)
        {
            bPoisoned = TRUE;
        } else
        {
            eEffect = GetNextEffect(OBJECT_SELF);
        }
    }

    return bPoisoned;
}
