//: B W-Husey
//  October 2005

//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(OBJECT_SELF,"nMyStory")<1)
        return TRUE;

    return FALSE;
}
