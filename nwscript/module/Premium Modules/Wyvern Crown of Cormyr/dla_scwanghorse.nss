//::///////////////////////////////////////////////
//:: FileName dla_scwanghorse
//:: Created By: B W-Husey
// Need a horse, not spoken to Lacinda about it.

int StartingConditional()
{
    int nTemp = GetLocalInt(GetPCSpeaker(), "nHawklinPlot1");
    // Inspect local variables
    if(nTemp<2 && GetLocalInt(GetPCSpeaker(), "nLHorse")<1)
        return TRUE;

    return FALSE;
}
