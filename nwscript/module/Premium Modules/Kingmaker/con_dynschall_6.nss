//::///////////////////////////////////////////////
//:: Name
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Check if pc has done the first quest to join the temple.
*/
//:://////////////////////////////////////////////
//:: Created By: Dan Whiteside
//:: Created On: July 23, 2003
//:://////////////////////////////////////////////
int StartingConditional()
{
    if (GetLocalInt(GetFirstPC(),"os_jointemple_pc")==23
        || GetLocalInt(GetFirstPC(),"os_jointemple_pc")==27)
        return TRUE;
    return FALSE;
}