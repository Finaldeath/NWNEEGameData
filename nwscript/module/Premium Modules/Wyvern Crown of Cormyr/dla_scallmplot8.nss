//: B W-Husey
//  October 2005
//  Module in the finale phase
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") ==8)
        return TRUE;

    return FALSE;
}
