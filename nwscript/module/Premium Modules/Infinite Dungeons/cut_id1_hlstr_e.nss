//::///////////////////////////////////////////////
//:: cut_id1_hlstr_e
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Halaster boss battle intro cutscene (end script).
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "inc_id1_halaster"
#include "_inc_cutscene"

void main()
{
    // Call the area setup function. Normally this is called in the area
    // OnEnter script, but when a cutscene runs we need to delay it until
    // the cutscene finishes.
    DebugMessage("  Area is not activated. Setting up.");
    Setup();

    // After a short delay Halaster should seek out the intruders.
    object oHalaster = GetObjectByTag(HALASTER_TAG);

    if (GetIsObjectValid(oHalaster) == TRUE)
    {
        DelayCommand(10.0, AssignCommand(oHalaster, ActionMoveToObject(GetPCInArea())));
    }
}
