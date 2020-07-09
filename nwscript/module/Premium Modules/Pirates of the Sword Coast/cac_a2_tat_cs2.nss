//::///////////////////////////////////////////////
//:: cac_a2_tat_cs2
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Start XPM cutscene, when talking to the
    tattooist in the tattoo parlor.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 16/05
//:://////////////////////////////////////////////
#include "inc_polymorphfix"
#include "_inc_generic"

void main()
{
    object oModule = GetModule();
    object oWP = GetWaypointByTag(a2w_Manor_PC_Jump_From_Parlor);
    object oThisArea = GetArea(OBJECT_SELF);
    object oManorArea = GetObjectByTag("SpindriftMayorsOffice");

    // set a variable on the area, so that when the next PC enters
    // the area's on enter script knows it should start the xpm cutscene
    SetLocalInt(oManorArea, l_n_XPM_START_CS_ON_AEN, TRUE);

    // jump all pc's in the area to the manor
    int nIndex = 0;
    object oPC = GetPCInArea(oThisArea, 0);

    //K2 - 4/12/2005 Update the tattooist plot.
    ExecuteScript("exe_a2_tttst50", oModule);

    while(GetIsObjectValid(oPC))
    {
        RemovePolymorph(oPC);
        AssignCommand(oPC, ClearAllActions(TRUE));
        // JE: JumpToObject is not reliable
        //AssignCommand(oPC, JumpToObject(oWP));
        JumpPCsToLocation(GetLocation(oWP), 0, oPC);
        nIndex++;
        oPC = GetPCInArea(oThisArea, nIndex);
    }

    // jump the tattooist there
    //ClearAllActions(TRUE);
    //oWP = GetWaypointByTag(a2w_Manor_XPM_Tattooist_1);
    //JumpToObject(oWP);

    // JE: No longer need to jump the tattooist. Technically he's in two
    // different areas at once for the duration of the cutscene. Big deal.
}
