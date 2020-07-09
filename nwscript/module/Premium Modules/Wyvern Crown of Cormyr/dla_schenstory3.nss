//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot >4
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") > 4 && GetLocalInt(OBJECT_SELF,"nMyStory")==2)
        return TRUE;

    return FALSE;
}
