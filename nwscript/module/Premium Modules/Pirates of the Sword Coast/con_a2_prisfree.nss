//::///////////////////////////////////////////////
//:: con_a2_prisfree
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Are Langer and the Tattooist already free?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

int StartingConditional()
{
    object oModule = GetModule();
    int iPlotTattoo = GetLocalInt(oModule, "A2_TATTOO");
    int iPlotLanger = GetLocalInt(oModule, "A2_LANGER");

    if ((iPlotTattoo >= 20) && (iPlotLanger >= 30))
    {
        return TRUE;
    }
    return FALSE;
}
