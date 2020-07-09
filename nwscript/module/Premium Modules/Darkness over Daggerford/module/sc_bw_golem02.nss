int StartingConditional()
{
    int iResult;
    object oFissure = GetNearestObjectByTag("ar2503_fissure");

    iResult = (GetIsObjectValid(oFissure));
    return iResult;
}
