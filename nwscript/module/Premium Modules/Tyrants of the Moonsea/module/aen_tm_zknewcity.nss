// zhentil keep new city area enter event

void exploreArea(object oPC)
{
    if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
    }
}

void moveDoor(object oPC)
{
    if (GetLocalInt(OBJECT_SELF, "nDoorMoved") == 0)
    {
        SetLocalInt(OBJECT_SELF, "nDoorMoved", 1);

        object oDoor = GetObjectByTag("dr_zk0_drawbridge_alwaysopen");
        SetObjectVisualTransform(oDoor, OBJECT_VISUAL_TRANSFORM_TRANSLATE_Y, -5.0f);
        SetObjectVisualTransform(oDoor, OBJECT_VISUAL_TRANSFORM_TRANSLATE_X, -5.0f);
    }
}

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        exploreArea(oPC);
        moveDoor(oPC);
    }
}
