void main()
{
    object oPC = GetPCSpeaker();
    object oBoat = GetNearestObjectByTag("bw_rowboat");
    float fDist = GetDistanceToObject(oBoat);

    DestroyObject(OBJECT_SELF, 0.3f);

    if ((fDist > 0.0f) && (fDist < 6.0f))
    {
        SetPlotFlag(oBoat, FALSE);
        DestroyObject(oBoat, 0.2f);
    }

    CreateItemOnObject("am_ropecoil", oPC);

    SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
}
