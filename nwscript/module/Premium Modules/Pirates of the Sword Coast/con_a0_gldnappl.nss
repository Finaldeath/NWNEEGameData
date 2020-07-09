//::///////////////////////////////////////////////
//:: con_a0_gldnappl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The NPC speaker is in the Golden apple area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oNPC = OBJECT_SELF;
    object oArea = GetArea(oNPC);
    int iResult = FALSE;
    int Escort = GetLocalInt(GetModule(), "A0_ESCORT");

    if ((Escort >= 50) && (GetTag(oArea) == "MAP_M1Q4Q"))
    {
        iResult = TRUE;
    }

    return iResult;
}
