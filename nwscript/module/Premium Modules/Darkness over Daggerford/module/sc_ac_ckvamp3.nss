// Check whether player destroyed all three runestones for Nosfiraat

int StartingConditional()
{
    object oStone1 = GetObjectByTag("am_ar2000_rune1");
    object oStone2 = GetObjectByTag("am_ar2000_rune2");
    object oStone3 = GetObjectByTag("am_ar2000_rune3");

    if (!GetIsObjectValid(oStone1) &&
        !GetIsObjectValid(oStone2) &&
        !GetIsObjectValid(oStone3))
    {
        return(TRUE);
    }
    return(FALSE);
}
