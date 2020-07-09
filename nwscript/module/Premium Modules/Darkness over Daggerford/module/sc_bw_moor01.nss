// returns TRUE if rowboat is anchored here

int StartingConditional()
{
    int iResult;
    object oBoat = GetNearestObjectByTag("bw_rowboat");
    float fDist = GetDistanceToObject(oBoat);

    iResult = ((fDist > 0.0f) && (fDist < 6.0f));
    return iResult;
}
