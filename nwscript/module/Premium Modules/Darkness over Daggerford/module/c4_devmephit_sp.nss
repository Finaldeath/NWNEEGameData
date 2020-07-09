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
    object oCaster = GetLastSpellCaster();

    if (GetTag(oCaster) != "ks_mephit_fire" ||
        GetTag(oCaster) != "ks_mephit_ice")
    {
        ExecuteScript("nw_c2_defaultb", OBJECT_SELF);
    }
    else
    {
        ClearAllActions(TRUE);
        ResetReputation(oCaster, GetTag(OBJECT_SELF));
    }
}
