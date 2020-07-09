//: B W-Husey
//  October 2005
//  Module finished
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") ==9)
        return TRUE;

    return FALSE;
}
