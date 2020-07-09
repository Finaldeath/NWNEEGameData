//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot < 4
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") < 4)
        return TRUE;

    return FALSE;
}
