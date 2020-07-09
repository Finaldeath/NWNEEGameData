//: B W-Husey
//  October 2005
//  The main plot variable nMainPlot >3
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") > 3 && GetLocalInt(OBJECT_SELF,"nMyStory")==1)
        return TRUE;

    return FALSE;
}
