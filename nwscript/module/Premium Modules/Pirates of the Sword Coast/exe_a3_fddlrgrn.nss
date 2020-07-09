//::///////////////////////////////////////////////
//:: exe_a3_fddlrgrn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Teleport all PC's to Fiddlers Green.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
//:: Turned into an exe by: Rob Bartel
//:: April 27, 2005
//:://////////////////////////////////////////////
#include "inc_polymorphfix"
#include "_inc_generic"

void main()
{
    object oPC = OBJECT_SELF;
    object oCursor = GetFirstPC();
    object oWPTarg = GetObjectByTag("A3_FDDLRGRN_STRT");
    location lTarg = GetLocation(oWPTarg);

    if (GetIsPC(oPC) == TRUE)
    {
        while (GetIsObjectValid(oCursor) == TRUE)
        {
            RemovePolymorph(oCursor);
            // JE: JumpToLocation is not reliable
            //AssignCommand(oCursor, JumpToLocation(lTarg));
            JumpPCsToLocation(lTarg, 0, oCursor);
            oCursor = GetNextPC();
        }
    }
}
