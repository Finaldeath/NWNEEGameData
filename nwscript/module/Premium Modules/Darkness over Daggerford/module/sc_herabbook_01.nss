// the player is searching capt herab's desk. Have they NOT already found the
// .. shoreside shipping records in the mariner's alliance basement?

int StartingConditional()
{
    object oMod = GetModule();
    int nPlot = GetLocalInt(oMod, "barge_activity");
    return (nPlot < 2);
}
