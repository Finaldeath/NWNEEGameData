// is feldran dead? (or close to dead)

int StartingConditional()
{
    object oMod = GetModule();
    if (GetLocalInt(oMod, "nFandocFeldranAttackFinal") == 1)
        return(TRUE);
    if (GetLocalInt(oMod, "nFandocFeldranDead") == 1)
        return(TRUE);
    return(FALSE);
}
