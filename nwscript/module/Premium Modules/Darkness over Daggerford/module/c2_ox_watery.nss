//::///////////////////////////////////////////////
//::
//:: a3_bw_ox_watery
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Enter script for areas.
//::
//:: Restore footstep type.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 9/21/2005
//::
//:://////////////////////////////////////////////


void main()
{
    object oExiter = GetExitingObject();

    SetFootstepType(FOOTSTEP_TYPE_DEFAULT, oExiter);
}
