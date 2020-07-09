// does the player know the exit portal password in illefarn?

int StartingConditional()
{
    // do nothing if the portal is already open
    object oPortal = GetNearestObjectByTag("ar2504_portal");
    if (GetIsObjectValid(oPortal))
    {
        return(FALSE);
    }

    object oPC = GetPCSpeaker();
    return(GetLocalInt(oPC, "nIH_KnowsExit") == 1);

}
