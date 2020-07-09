// are all the fowls present in the circle?

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    if (GetLocalInt(oArea, "nParrotBack")  != 0 &&
        GetLocalInt(oArea, "nPenguinBack") != 0)
    {
        return(TRUE);
    }
    return(FALSE);
}
