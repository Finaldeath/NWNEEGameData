//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot == 2, PC is a squire and needs to find Edgar Truesilver
// before this variable changes
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") == 2)
        return TRUE;

    return FALSE;
}
