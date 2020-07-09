//::///////////////////////////////////////////////
//:: cac_a2_sewermn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Enable the Mappoints for free
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetPCSpeaker();
    object oPete = OBJECT_SELF;

    object oFightClb = GetWaypointByTag("a2_sewers_fightclub");
    object oBlkBPrison = GetWaypointByTag("a2_sewers_prison");
    object oSpnDrftDocks = GetWaypointByTag("a2_sewers_docks");
    object oUmbTemple = GetWaypointByTag("a2_sewers_btemple");

    //Explore the area.
    ExploreAreaForPlayer(GetArea(oPete), oPC);

    //Enable the Map Pins and mark their locals as such.
    SetLocalInt(oFightClb, "SEWER_ENABLED", TRUE);
    SetMapPinEnabled(oFightClb, TRUE);

    SetLocalInt(oBlkBPrison, "SEWER_ENABLED", TRUE);
    SetMapPinEnabled(oBlkBPrison, TRUE);

    SetLocalInt(oSpnDrftDocks, "SEWER_ENABLED", TRUE);
    SetMapPinEnabled(oSpnDrftDocks, TRUE);

    SetLocalInt(oUmbTemple, "SEWER_ENABLED", TRUE);
    SetMapPinEnabled(oUmbTemple, TRUE);
}
