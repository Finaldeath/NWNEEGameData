void main()
{
    object oAttacker = GetLastAttacker();
    if (GetTag(oAttacker) != "bw_smith")
    {
        return;
    }

    int nThumps = GetLocalInt(OBJECT_SELF, "nThumps");
    nThumps += 1;

    if (nThumps >= 3)
    {
        AssignCommand(oAttacker, ClearAllActions(TRUE));
        ExecuteScript("c4_xs_bw_smith2", oAttacker);
        nThumps = 0;
    }

    SetLocalInt(OBJECT_SELF, "nThumps", nThumps);
}
