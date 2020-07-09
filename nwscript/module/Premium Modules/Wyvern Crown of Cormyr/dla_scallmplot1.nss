//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot == 1
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") == 1)
        return TRUE;

    return FALSE;
}
