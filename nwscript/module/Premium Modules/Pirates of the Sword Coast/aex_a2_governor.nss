//::///////////////////////////////////////////////
//:: aex_a2_governor
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Governor's Manor, OnExit script.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: April 21/05
//:://////////////////////////////////////////////
#include "inc_govmanor"

void main()
{
    object oExitPC = GetExitingObject();

    // abort if not a PC
    if(!GetIsPCNotDM(oExitPC)) return;

    // Is there another PC still in the area?
    int bPCStillInArea = FALSE;
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        // if oPC isn't the pc who is exiting, and oPC is in this area,
        // then we have determined that there is at least one other pc here.
        if( oPC != oExitPC &&
            GetArea(oPC) == OBJECT_SELF)
        {
            bPCStillInArea = TRUE;
            break;
        }
        oPC = GetNextPC();
    }

    // Only do this stuff if the exiting PC is the last one in the area
    if(!bPCStillInArea)
    {
        object oModule = GetModule();
        // Should we get rid of the tattooist?
        if(GetLocalInt(oModule, "A2_TTTST") >= 20)
        {
            TattooistLeavesPrison(oExitPC, OBJECT_SELF);
        }

        // Should Langer be moved to the Monkey's Cutlass?
        // if the cutscene has played, that means Langer has been "piratized"
        // and is waiting for the PC to talk to him. We double-check the plot
        // variable just in case the PC has talked to him, and he's just in
        // the process of leaving the area.
        if(cs_GetCutsceneEnded(1) && GetLocalInt(oModule, "A2_LANGER") < 70)
        {
            LangerLeavesPrison(oExitPC, OBJECT_SELF);
        }
    }
}
