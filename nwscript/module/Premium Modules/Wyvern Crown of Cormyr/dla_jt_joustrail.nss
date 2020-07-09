const int TILT_RAIL_NORMAL = ANIMATION_PLACEABLE_DEACTIVATE;
const int TILT_RAIL_SMALL  = ANIMATION_PLACEABLE_CLOSE;

void main()
{
    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;

    // Get the area object
    object oArea = GetArea(oPC);

    // Set up tilt rails if they have not been setup already
    // Height of tilt rails is determined by PC size/race
    if (GetLocalInt(GetArea(OBJECT_SELF), "bTiltRailSet")) return;

    int bSmall   = (GetCreatureSize(oPC)<CREATURE_SIZE_MEDIUM || GetRacialType(oPC)==RACIAL_TYPE_DWARF);
    int nRail    = bSmall ? TILT_RAIL_SMALL : TILT_RAIL_NORMAL;
    int i=0;
    object oWPTiltRail = GetObjectByTag("JoustList4", i);
    while (GetIsObjectValid(oWPTiltRail))
    {
        AssignCommand(oWPTiltRail, ActionPlayAnimation(nRail));
        oWPTiltRail = GetObjectByTag("JoustList4", ++i);
    }
    SetLocalInt(oArea, "bTiltRailSet", TRUE);
    // End tilt rail check/setup
}
