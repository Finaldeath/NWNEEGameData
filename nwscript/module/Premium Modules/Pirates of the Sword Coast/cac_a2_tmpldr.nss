//::///////////////////////////////////////////////
//:: cac_a2_tmpldr
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Open the gate into the temple
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////
#include "_inc_experience"

void main()
{
    object oPC = GetPCSpeaker();
    object oDoor = GetNearestObjectByTag("a2_tmpl_prtclls");

    SetLocked(oDoor, FALSE);
    DelayCommand(0.5f, AssignCommand(oDoor, ActionOpenDoor(oDoor)));
}
