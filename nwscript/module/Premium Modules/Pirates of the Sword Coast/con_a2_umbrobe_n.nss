//::///////////////////////////////////////////////
//:: Act 2: Inside Temple, Not Wearing Robe
//:: con_a2_umbrobe_n.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Return TRUE if the player is inside the
     Temple of Umberlee and not wearing the
     Umberlant Robe.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 25, 2005
//:://////////////////////////////////////////////
int StartingConditional()
{
    object oArea = GetArea(OBJECT_SELF);
    string sArea = GetTag(oArea);

    if (sArea == "TempleOfUmberlee")
    {
        return TRUE;
    }
    return FALSE;
}
