//::///////////////////////////////////////////////
//:: Name q2a_chk_cook2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check cook dialog status on PC Speaker
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////


int StartingConditional()
{
    if (GetLocalInt(GetPCSpeaker(), "nCookDialog") < 2)
        return TRUE;

    return FALSE;
}