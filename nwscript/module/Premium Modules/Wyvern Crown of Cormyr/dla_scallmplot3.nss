//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot == 3
// This section deals with getting info on, and heading to Polter's Fort. The variable switches with the death
// of the WL. You can use this script for questions on Polter's Fort.
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") == 3)
        return TRUE;

    return FALSE;
}
