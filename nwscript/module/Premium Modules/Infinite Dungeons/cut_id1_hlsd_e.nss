//::///////////////////////////////////////////////
//:: cut_id1_hlsd_e
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Halaster surrender cutscene (end script).
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

void main()
{
    object oHalaster = GetObjectByTagInArea("id1_halaster");

    int nNth = 0;
    int nWP;
    object oPC = GetPCInArea(OBJECT_SELF, 0);
    object oFirstPC = oPC;
    object oWP;
    while(GetIsObjectValid(oPC))
    {
        if(nNth < 6) nWP = nNth + 1;
        else nWP = 6;

        AssignCommand(oPC, ClearAllActions(TRUE));
        // skip the jump for the first PC - he's already where he's supposed to be
        if(nWP > 1)
        {
            oWP = GetObjectByTagInArea("ID1_STATIC_CS_PC"+IntToString(nWP));
            DelayCommand(0.2, JumpPCsToLocation(GetLocation(oWP), 0, oPC, 1.0));
        }
        nNth++;
        oPC = GetPCInArea(OBJECT_SELF, nNth);
    }

    if(GetIsObjectValid(oFirstPC))
    {
        AssignCommand(oHalaster, ActionStartConversation(oFirstPC, "", FALSE, FALSE));
    }

    // if for some reason oFirstPC is not valid, Halaster will simply wait for a
    // PC to approach and talk to him, and it will continue from there
}
