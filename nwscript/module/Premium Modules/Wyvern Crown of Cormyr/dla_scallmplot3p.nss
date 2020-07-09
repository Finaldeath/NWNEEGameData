//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot > 2, PC is a knight (main use of this)
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") > 2)
        return TRUE;

    return FALSE;
}
