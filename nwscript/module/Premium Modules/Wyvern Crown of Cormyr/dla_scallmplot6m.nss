//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot < 8, PC has not yet gone to the final battle
// Modified to be less than 8.
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") < 8)
        return TRUE;

    return FALSE;
}
