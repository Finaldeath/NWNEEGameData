#include "hf_in_plot"

void main()
{
    // bridge offers gold as thanks for fighting griswald
    object oPC = GetPCSpeaker();
    string sMe = GetTag(OBJECT_SELF);
    PlotLevelSet(sMe, 6);

    // gold is ready for player
    object oWP = GetNearestObjectByTag("WP_AR2000_GOLD", oPC);
    object oBag = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_lootbag6", GetLocation(oWP));
    SetLocalInt(oBag, "NW_DO_ONCE", 1);
    CreateItemOnObject("nw_it_gold001", oBag, 500);

    // enable map note
    object oMapNote = GetNearestObjectByTag("MN_AR2000_GNARLED_TREE", oPC);
    SetMapPinEnabled(oMapNote, TRUE);
}
