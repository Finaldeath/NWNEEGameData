// npc heartbeat script for jonas sr/jr day/night activities

void ahcFace(object o1)
{
    SetFacingPoint(GetPosition(o1));
}

void main()
{
    object oJonas1 = GetObjectByTag("ac_jonas1");
    object oJonas2 = GetObjectByTag("ac_jonas2");
    if (GetLocalInt(OBJECT_SELF, "no_banter") == 1) return;
    if (GetLocalInt(OBJECT_SELF, "no_hb") == 1)     return;
    if (GetLocalInt(oJonas1, "has_met_pc") == 1)    return;
    if (GetLocalInt(GetModule(), "ac_werewolf") >= 1)   return;
    if (IsInConversation(oJonas1) || IsInConversation(oJonas2))
    {
        SetLocalInt(oJonas1, "BUSY", 0);
        SetLocalInt(oJonas2, "BUSY", 0);
        return;
    }

    // do some work outside
    if (GetIsDay() || GetIsDawn())
    {
         if (GetLocalInt(OBJECT_SELF, "BUSY") == 0)
        {
            // walk to a tree
            SetLocalInt(OBJECT_SELF, "BUSY", 1);
            object oTree = GetNearestObjectByTag("wp_ac_tree", OBJECT_SELF, d3());
            ActionMoveToObject(oTree);
            ActionDoCommand(ahcFace(GetNearestObjectByTag("TNOOrangeTreeSm")));
            ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 6.0);
            ActionWait(1.0);

            // walk to basket
            object oBasket = GetWaypointByTag("wp_ac_wheelbarrow2");
            ActionMoveToObject(oBasket);
            ActionDoCommand(ahcFace(GetNearestObjectByTag("dag_apple")));
            ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0);
            ActionDoCommand(SetLocalInt(OBJECT_SELF, "BUSY", 0));
        }
    }
}
