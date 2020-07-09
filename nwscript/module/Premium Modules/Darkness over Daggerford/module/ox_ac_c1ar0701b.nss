// onExit event for ar0701b (bricket house upstairs)
// .. both alicine and muriel must be downstairs if they are upstairs

void main()
{
    object oPC = GetExitingObject();
    if (GetIsPC(oPC))
    {
        object oM = GetObjectByTag("ac_muriel");
        object oA = GetObjectByTag("ac_alicine");
        object oWP2 = GetWaypointByTag("wp_ac_downstairs");

        //Don't move sisters downstairs if neither have been encountered
        if(GetLocalInt(GetArea(OBJECT_SELF), "iMetSister") == 0)
        {
            return;
        }

        if (!GetIsDead(oM))
        {
            if (GetArea(oM) == OBJECT_SELF)
            {
                SetLocalInt(oM, "no_banter", 0);
                AssignCommand(oM, ClearAllActions());
                AssignCommand(oM, ActionJumpToObject(oWP2, FALSE));
                SetLocalInt(oPC, "elveronne_quest", 3);
                SetLocalInt(oPC, "muriel_downstairs", 3);
            }
        }
        if (!GetIsDead(oA))
        {
            if (GetArea(oA) == OBJECT_SELF)
            {
                SetLocalInt(oA, "no_banter", 0);
                AssignCommand(oA, ClearAllActions());
                AssignCommand(oA, ActionJumpToObject(oWP2, FALSE));
                SetLocalInt(oPC, "elveronne_quest", 3);
                SetLocalInt(oPC, "alicine_downstairs", 3);
            }
        }
        if(GetLocalInt(GetObjectByTag("trg_ac_chest"), "fired") == 0)
        {
            object oChest = GetObjectByTag("ac_plc_chest");
            AssignCommand(oChest, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
            SetLocalInt(GetObjectByTag("trg_ac_chest"), "fired", 1);
        }
    }
}
