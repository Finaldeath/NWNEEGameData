//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot >5, PC has dealt with Wyvernwater
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") > 5)
        return TRUE;

    return FALSE;
}
