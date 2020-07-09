int StartingConditional()
{
    int iResult;
    object oArea = GetArea(OBJECT_SELF);

    iResult = (GetLocalInt(oArea, "nIH_BeamActive") == 1);

    return iResult;
}
