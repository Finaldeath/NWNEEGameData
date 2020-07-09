// jared/vetrixia lets down a rope leading to umgatlik's cave

void main()
{
    // create the rope leading down the cliff
    object oWP1 = GetWaypointByTag("WP_AR2100_CLERIC_ROPE_TOP");
    object oWP2 = GetWaypointByTag("WP_AR2100_CLERIC_ROPE_BOT");
    object oRopeImg = CreateObject(OBJECT_TYPE_PLACEABLE, "pdag_ropewodcvl1", GetLocation(oWP1));
    object oRopeTop = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_ar2100_rope1", GetLocation(oWP1));
    SetLocalString(oRopeTop, "HF_DEST", "WP_AR2100_CLERIC_ROPE_BOT");
    object oRopeBot = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_ar2100_rope1", GetLocation(oWP2));
    SetLocalString(oRopeBot, "HF_DEST", "WP_AR2100_CLERIC_ROPE_TOP");

    // enable the map note
    object oMP = GetWaypointByTag("WP_AR2100_MAP_UMGATLIK");
    SetMapPinEnabled(oMP, 1);

    // the cleric climbs down the rope and enters the cave
    SetFacingPoint(GetPosition(oRopeTop));
    SpeakString("Follow me down.");
    ActionMoveToObject(oRopeTop);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 1.0);
    SetLocalInt(OBJECT_SELF, "HF_EXIT_STARTED", 1);
    SetIsDestroyable(TRUE);
    DestroyObject(OBJECT_SELF, 2.0);
}
