//::///////////////////////////////////////////////
//:: Act 2: Not In Tattoo Parlor
//:: con_a2_notparlor.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Returns TRUE if the conversation is not taking
     place in Act 2's tattoo parlor.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: March 18, 2005
//:://////////////////////////////////////////////

int StartingConditional()
{
    string sArea = GetTag(GetArea(OBJECT_SELF));

    if (sArea != "Map_A2_FALSTAFF")
    {
        return TRUE;
    }
    return FALSE;
}

