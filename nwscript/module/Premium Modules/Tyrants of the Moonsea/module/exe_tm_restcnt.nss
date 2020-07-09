// Wak Simulacrum only spawns 4 times on rest (one for each pod in his chamber).
// Each pod destroyed would remove 1 Wak spawn onRest.

object getActivePod(object oSelf)
{
    int n = 1;
    object oPod = GetNearestObjectByTag("CloningTube", oSelf, n);
    while (GetIsObjectValid(oPod))
    {
        int nUsed = GetLocalInt(oPod, "HF_USED");
        if (nUsed == 0)
            return oPod;
        oPod = GetNearestObjectByTag("CloningTube", oSelf, ++n);
    }
    return OBJECT_INVALID;
}

void main()
{
    object oPod = getActivePod(OBJECT_SELF);
    if (GetIsObjectValid(oPod))
    {
        SetLocalInt(oPod, "HF_USED", 1);
        SetLocalInt(OBJECT_SELF, "HF_RETVAL", TRUE);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "HF_RETVAL", FALSE);
    }
}
