//: B W-Husey
//  December 2005
//  The main plot variable nMainPlot == 4
// This section covers between the end of Polter's Fort and the start of Wyvernwater Castle.
// During this section Polter's Fort areas are closed, and plot characters use the 'find Wyvernvapor'
// mode.
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") == 4)
        return TRUE;

    return FALSE;
}
