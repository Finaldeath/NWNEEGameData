//::///////////////////////////////////////////////
//:: mex_potscdflt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    A client object has exited the game.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "x0_i0_henchman"
#include "inc_balance"

void FindNewMaster(object oHench, object oOldMaster);

void main()
{
    object oExit = GetExitingObject();
    object oNisar0 = GetObjectByTag("a0_hench_nisar");
    object oNisar2 = GetObjectByTag("a2_hench_nisar");
    object oGarm = GetObjectByTag("a1_hench_garm");

    // If the PC is Leaveing and has henchmen, Find a new master for the
    // Henchmen NPC

    if (GetMaster(oNisar0) == oExit)
    {
        FindNewMaster(oNisar0, oExit);
    }
    if (GetMaster(oNisar2) == oExit)
    {
        FindNewMaster(oNisar2, oExit);
    }
    if (GetMaster(oGarm) == oExit)
    {
        FindNewMaster(oGarm, oExit);
    }

    // update the gobal difficulty now the the Party is short a PC
    ReCalcGlobalDif();
}

void FindNewMaster(object oHench, object oOldMaster)
{
    object oCursorPC = GetFirstPC();
    int iFound = FALSE;

    // go through the valid players and find a new master.
    while (GetIsObjectValid(oCursorPC) == TRUE)
    {
        if ((iFound == FALSE) && (oCursorPC != oOldMaster))
        {
            RemoveHenchman(oOldMaster, oHench);
            DelayCommand(0.5f, AddHenchman(oCursorPC, oHench));
            DelayCommand(1.0f, AssignCommand(oHench, JumpToObject(oCursorPC, 0)));
            iFound = TRUE;
        }

        oCursorPC = GetNextPC();
    }
}
