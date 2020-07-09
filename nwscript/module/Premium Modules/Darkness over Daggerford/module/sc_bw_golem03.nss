int StartingConditional()
{
    int iResult;
    object oFlamer = GetNearestObjectByTag("bw_flamer");

    iResult = (GetIsObjectValid(oFlamer));
    return iResult;
}
