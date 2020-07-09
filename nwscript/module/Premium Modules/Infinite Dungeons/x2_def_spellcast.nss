//::///////////////////////////////////////////////
//:: Name x2_def_spellcast
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spell Cast At script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    // plot creatures ignore attacks
    if (GetPlotFlag(OBJECT_SELF) == TRUE)
    {
        return;
    }

    if (GetLocalInt(OBJECT_SELF, "bFollower") == TRUE)
    {
        ExecuteScript("hen_id1_castat", OBJECT_SELF);
    } else
    {
        ExecuteScript("nw_c2_defaultb", OBJECT_SELF);
    }
}
