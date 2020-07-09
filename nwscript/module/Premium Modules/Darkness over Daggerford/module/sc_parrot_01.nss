// is hester dead?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oHester = GetNearestObjectByTag("ks_hester", oPC);
    if (!GetIsObjectValid(oHester))
    {
        return(TRUE);
    }
    return(GetIsDead(oHester));
}
