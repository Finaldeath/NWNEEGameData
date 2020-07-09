// returns true if
// 1 - this guard is near the river gates
// 2 - the river gates are open
// 3 - the main gates are locked

int StartingConditional()
{
    object oMod = GetModule();
    object oPC = GetPCSpeaker();
    object oGates = GetNearestObjectByTag("pm_rivergate", oPC);

    // are the main gates locked?
    if (GetLocalInt(oMod, "pm_Daggerford_open") != 0)
    {
        // the main gates are open
        return(FALSE);
    }

    // are we standing near the river gates?
    float fDist = GetDistanceToObject(oGates);
    if (fDist < 0.0 || fDist > 5.0)
    {
        // not standing near the gates
        return(FALSE);
    }

    // are the river gates locked?
    if (GetLocked(oGates))
    {
        // the river gates are locked
        return(FALSE);
    }

    return(TRUE);
}
