//: B W-Husey
//  October 2005
// Last hench story node
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(GetLocalInt(OBJECT_SELF,"nMyStory")==3)
        return TRUE;

    return FALSE;
}
