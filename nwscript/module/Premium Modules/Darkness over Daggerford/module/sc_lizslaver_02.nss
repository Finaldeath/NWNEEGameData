// are the two slaves no longer fighting?
// ... this assumes that slave1 will always win

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oSlave1 = GetNearestObjectByTag("ks_lizslave1", oPC);
    object oSlave2 = GetNearestObjectByTag("ks_lizslave2", oPC);

    // TRUE: both of the slaves are not fighting
    if (!GetIsInCombat(oSlave1) && !GetIsInCombat(oSlave2))
    {
        return(TRUE);
    }

    // TRUE: one of the slaves is dead
    if (!GetIsObjectValid(oSlave1) || !GetIsObjectValid(oSlave2))
    {
        return(TRUE);
    }
    if (GetIsDead(oSlave1) || GetIsDead(oSlave2))
    {
        return(TRUE);
    }

    // FALSE: otherwise
    return(FALSE);
}
