//: B W-Husey
//  December 2005
//  The main plot variable nMainPlot is 4 or more
// PC is a knight.
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") > 3)
        return TRUE;

    return FALSE;
}
