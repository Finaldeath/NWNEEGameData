//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot < 6
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") < 6)
        return TRUE;

    return FALSE;
}
