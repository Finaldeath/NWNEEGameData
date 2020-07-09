//: B W-Husey
//  October 2005
//  Module in the finale phase
//: Once only version
//:://////////////////////////////////////////////
int StartingConditional()
{


    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nLast"+GetTag(OBJECT_SELF)) != 0)
        return FALSE;

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") ==8)
        return TRUE;

    return FALSE;
}
