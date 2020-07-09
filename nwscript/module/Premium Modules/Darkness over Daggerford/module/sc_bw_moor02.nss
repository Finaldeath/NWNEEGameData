// returns TRUE if boonmoppet (as girl) is NOT nearby

int StartingConditional()
{
    int iResult;

    object oGirl = GetNearestObjectByTag("ac_boonmoppet");
    float fDist = GetDistanceToObject(oGirl);
    float fRadius = 10.0f;

    iResult = (!GetIsObjectValid(oGirl) ||
               (GetIsDead(oGirl)) ||
               (fDist > fRadius));
    return iResult;
}
