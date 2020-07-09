//: B W-Husey
//  October 2005
//  Module in the finale phase - Jonas specific, not back as a henchie & not freed.
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(GetPCSpeaker(), "nMainPlot") !=8)
        return FALSE;
    if(GetLocalInt(OBJECT_SELF, "nFree") >0)
        return FALSE;
    if(GetLocalInt(OBJECT_SELF, "n8times1") >0)
        return FALSE;
    SetLocalInt(OBJECT_SELF,"n8times1",1);//branch appears once only
    return TRUE;
}
