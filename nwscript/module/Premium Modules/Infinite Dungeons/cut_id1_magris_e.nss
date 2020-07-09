//::///////////////////////////////////////////////
//:: cut_id1_magris_e
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Magris boss battle intro cutscene (end script).
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "inc_id1_maggris"
#include "_inc_cutscene"

void main()
{
    // Check for objects that were created by the cutscene that need
    // to be removed by this special scripting.
    object oObject = GetFirstObjectInArea(OBJECT_SELF);
    while (GetIsObjectValid(oObject))
    {
        if (GetTag(oObject)=="cs_to_delete")
        {
            DestroyObject(oObject, 0.1);
        }
        oObject = GetNextObjectInArea(OBJECT_SELF);
    }

    // Call the area setup function. Normally this is called in the area
    // OnEnter script, but when a cutscene runs we need to delay it until
    // the cutscene finishes.
    DebugMessage("  Area is not activated. Setting up.");
    Setup();
}
