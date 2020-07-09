//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot < 3, PC is a squire
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") < 3)
        return TRUE;

    return FALSE;
}
