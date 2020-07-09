//::///////////////////////////////////////////////
//:: cac_a3_tptemple
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Send the player and his party up and into
    the temple where the ceremony is taking
    place.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
#include "inc_polymorphfix"
#include "_inc_generic"

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oCursor;
    object oTarget = GetWaypointByTag("A3_TSN_HOLDING");

    location lTarg = GetLocation(oTarget);

    oCursor = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oCursor) == TRUE)
    {
        RemovePolymorph(oCursor);
        // JE: JumpToLocation is not reliable
        //AssignCommand(oCursor, JumpToLocation(lTarg));
        JumpPCsToLocation(lTarg, 0, oCursor);
        oCursor = GetNextFactionMember(oPC, FALSE);
    }
}
