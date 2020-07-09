//::///////////////////////////////////////////////
//:: Area Transition: Willigan's study to main floor
//:: tcl_will2_will1.nss
//:: Uses TCL_NoFamiliar.nss as template
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    When going from Willigan's study to the main
    floor, kick the henchman out and get them to
    stand at a waypoint.

    Note: This is only done if Willigan doesn't
    have all of his items yet. If that is done,
    this is a normal area transition.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 30, 2005
//:://////////////////////////////////////////////
#include "inc_polymorphfix"
#include "x0_i0_henchman"

void main()
{
    object oClicker = GetClickingObject();
    if (GetIsPossessedFamiliar(oClicker) == TRUE)
    {
        string sMessage = "You dare not stray far from your master.";
        FloatingTextStringOnCreature(sMessage, oClicker);
    }
    else
    {
        object oModule = GetModule();

        // only do special scripting if the exiting object is a PC, and if
        // Willigan hasn't received all of his items yet
        if(GetIsPCNotDM(oClicker) && GetLocalInt(oModule, "A2_WHIPD") < 40)
        {
            // ok, since there can be more than one henchman, let's make this
            // support as many as we want

            // store all of this PC's henchmen in an array, on the PC
            int nIndex = 0;
            object oHench = GetHenchman(oClicker, 1);
            while(GetIsObjectValid(oHench))
            {
                SetObjectArray(oClicker, g_oa_A2_WILLIGAN_HENCH, nIndex, oHench);
                nIndex++;
                oHench = GetHenchman(oClicker, nIndex+1);
            }
            // null-terminated array, just for fun
            SetObjectArray(oClicker, g_oa_A2_WILLIGAN_HENCH, nIndex, OBJECT_INVALID);

            // yeah, another loop - I thought about including the functionality
            // of this loop in the one above, but I didn't want to screw up the
            // henchman index by removing them in that loop
            object oWP = GetWaypointByTag("WP_a2_willstudy_hench");
            nIndex = 0;
            oHench = GetObjectArray(oClicker, g_oa_A2_WILLIGAN_HENCH, nIndex);
            while(GetIsObjectValid(oHench))
            {
                //RemoveHenchman(oClicker, oHench);
                FireHenchman(oClicker, oHench);
                AssignCommand(oHench, ClearAllActions(TRUE));
                DelayCommand(1.0, AssignCommand(oHench, ActionMoveToObject(oWP)));

                nIndex++;
                oHench = GetObjectArray(oClicker, g_oa_A2_WILLIGAN_HENCH, nIndex);
            }

        }

        // do the normal transition stuff

        object oTarget = GetTransitionTarget(OBJECT_SELF);

        Transition_RemovePolymorphIfNecessary(oClicker, oTarget);

        //SetAreaTransitionBMP(AREA_TRANSITION_RANDOM);
        AssignCommand(oClicker,JumpToObject(oTarget));
    }
}
