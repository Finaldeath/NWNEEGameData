//::///////////////////////////////////////////////
//:: Name x2_def_attacked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Physically attacked script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }
    else
    {
        ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------

    ExecuteScript("nw_c2_default5", OBJECT_SELF);
}
