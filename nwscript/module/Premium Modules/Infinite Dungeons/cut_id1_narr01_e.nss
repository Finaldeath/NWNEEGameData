//::///////////////////////////////////////////////
//:: cut_id1_narr01_e
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    First narrator cutscene (end script).
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 9, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "x2_inc_toollib"

void DestroyFakeDungeonMap();

void main()
{
    // The cutscene will expose areas on the map that they shouldn't see.
    // This will fix that.
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        ExploreAreaForPlayer(OBJECT_SELF, oPC, FALSE);
        oPC = GetNextPC();
    }

    // kill the map we laid out for the cutscene
    DestroyFakeDungeonMap();

    // kill black tile trick
    TLResetAreaGroundTilesEx(OBJECT_SELF);

    int nTriggerPlot = GetLocalInt(GetModule(), "nTriggerPlot");
    nTriggerPlot++;
    SetLocalInt(GetModule(), "nTriggerPlot", nTriggerPlot);
}

//::////////////////////////////////////////////////////////////////////////////
//:: DestroyFakeDungeonMap
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Jan 27, 2006
//::////////////////////////////////////////////////////////////////////////////
void DestroyFakeDungeonMap()
{
    object oTile;
    string sTag;
    int i, j;

    // Iterate through all the possible tile tags and destroy them.
    for (i = 0; i < 13; ++i)
    {
        if (i < 10)
        {
            sTag = "Tile0" + IntToString(i);
        }
        else
        {
            sTag = "Tile" + IntToString(i);
        }

        // Start with the nearest and iterate in case of duplicates.
        j = 0;

        oTile = GetObjectByTagInArea(sTag, OBJECT_SELF, j);
        //oTile = GetNearestObjectByTag(sTag, OBJECT_SELF, j);

        while (GetIsObjectValid(oTile))
        {
            DestroyObject(oTile, 0.1);

            j++;

            //oTile = GetNearestObjectByTag(sTag, OBJECT_SELF, j);
            oTile = GetObjectByTagInArea(sTag, OBJECT_SELF, j);
        } // while
    } // for
}
