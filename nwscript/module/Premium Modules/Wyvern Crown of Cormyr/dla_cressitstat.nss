//:://////////////////////////////////////////////
//:: Created By:  Ben W-Husey
//:: Created On:  June 2003
//   For: Creatures that sit and do nothing
//:://////////////////////////////////////////////


/*
   DLA_CRESSITSTAT.NSS
   modified by : gaoneng erick
   modified on : may 6, 2006
*/

// ++++
/*
   gao : whatever's in the other two's already included in nw_i0_generic
*/
//#include "x0_i0_anims"
//#include "x0_i0_treasure"
#include "nw_i0_generic"
// ++++

void main()
{
    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.

// ++++
/*
    gao : modified to
    + make sure npc always find a vacant seat (no fighting!)
    + record chair as local object
    + mark self as a sitter (this last two is used later to prevent NPC from standing up when talked to)
*/
    object self = OBJECT_SELF;
    int i = 1;
    object chair = GetNearestObjectByTag("CHAIR");
    while (GetIsObjectValid(chair) && GetIsObjectValid(GetSittingCreature(chair)))
    {
        i++;
        chair = GetNearestObjectByTag("CHAIR", self, i);
    }
    if (GetIsObjectValid(chair))
    {
        ActionSit(chair);
        SetLocalObject(self, "GN_CHAIR", chair);
        SetLocalInt(self, "GN_CHAIR", TRUE);
// set plot flag on chair so players can destroy it
//        SetPlotFlag(chair, TRUE);
    }
}
/*
    ActionSit (GetNearestObjectByTag ("CHAIR", OBJECT_SELF));
}
*/
// ++++
