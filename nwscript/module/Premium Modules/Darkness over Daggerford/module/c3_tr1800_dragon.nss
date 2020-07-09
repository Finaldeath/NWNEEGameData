// the dragon in AR1800 is spawned by an area spawn point
// .. this trigger just makes it lie down in the water to look like
// .. an ambush of some kind

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        object oDragon = GetNearestObjectByTag("ks_dragon_blk", oPC);
        if (GetIsObjectValid(oDragon))
        {
            if (!GetIsInCombat(oDragon) && !IsInConversation(oDragon))
            {
                object oWP = GetWaypointByTag("WP_AR1800_DRAGON");
                AssignCommand(oDragon, ActionJumpToObject(oWP, FALSE));
                AssignCommand(oDragon, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 65535.0));
            }
        }
    }
}
