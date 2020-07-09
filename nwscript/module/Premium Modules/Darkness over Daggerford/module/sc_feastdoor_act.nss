// the feast door traps can only be set-off by veiti

#include "hf_in_plot"

// count the number of traps that have axes installed
int CountTraps(object oPC)
{
    int n = 4;
    if (PlotLevelCheckEquals("ks_ar2501_statue1", 0)) n--;
    if (PlotLevelCheckEquals("ks_ar2501_statue2", 0)) n--;
    if (PlotLevelCheckEquals("ks_ar2501_statue3", 0)) n--;
    if (PlotLevelCheckEquals("ks_ar2501_statue4", 0)) n--;
    return(n);
}

int StartingConditional()
{
    int nResult = FALSE;
    object oPC = GetPCSpeaker();
    object oVeiti = GetNearestObjectByTag("db_veiti", oPC);
    if (GetIsObjectValid(oVeiti))
    {
        int nCode = 0;
        int nTraps = CountTraps(oPC);
        if      (nTraps == 0) nCode = 0;
        else if (nTraps == 4) nCode = 2;
        else                  nCode = 1;
        SetLocalInt(OBJECT_SELF, "HF_ARG", nCode);
        SetCustomToken(100, IntToString(nTraps));
        nResult = TRUE;
    }
    return(nResult);
}
