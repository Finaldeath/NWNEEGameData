// mephits will only attack other mephits

void ResetReputation(object oPC, string sTag)
{
    int i = 1;
    object oMephit = GetNearestObjectByTag(sTag, oPC, i);
    while (GetIsObjectValid(oMephit))
    {
        ClearPersonalReputation(oPC, oMephit);
        int nRepAdjust = 50 - GetReputation(oMephit, oPC);
        AdjustReputation(oPC, oMephit, nRepAdjust);
        oMephit = GetNearestObjectByTag(sTag, oPC, ++i);
    }
}

void main()
{
    object oAttacker = GetLastAttacker();

    if (GetTag(oAttacker) == "ks_mephit_fire" ||
        GetTag(oAttacker) == "ks_mephit_ice")
    {
        ExecuteScript("nw_c2_default5", OBJECT_SELF);
    }
    else
    {
        ClearAllActions(TRUE);
        ResetReputation(oAttacker, GetTag(OBJECT_SELF));
    }
}
