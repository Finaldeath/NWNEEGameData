//::///////////////////////////////////////////////
//:: cut_a2_tas2_end
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Act 2 cutscene where Tasina portals out
    peacefully. (end script)
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 17/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    // A "just in case" thing - I probably don't have to deactivate the
    // trigger, the objects it would act on should be destroyed by now.
    object oTrig = GetObjectByTag(a2t_temple_portal);
    SetLocalInt(oTrig, l_n_A2_TEMPLE_PORTAL_OUT_ACTIVE, FALSE);

    // move real henchmen into position, destroy fake ones
    object oRealNisar = GetObjectByTagInArea(a2c_tag_Nisar);
    object oRealGarm = GetObjectByTagInArea(a1c_tag_Garm);
    object oNisarCopy = GetObjectByTagInArea("nisar_copy");
    object oGarmCopy = GetObjectByTagInArea("garm_copy");

    // move people into end positions
    AssignCommand(oRealNisar, ClearAllActions(TRUE));
    AssignCommand(oRealNisar, ActionJumpToLocation(GetLocation(oNisarCopy)));
    AssignCommand(oRealGarm, ClearAllActions(TRUE));
    AssignCommand(oRealGarm, ActionJumpToLocation(GetLocation(oGarmCopy)));

    // destroy henchmen copies
    DestroyObject(oNisarCopy);
    DestroyObject(oGarmCopy);
}
