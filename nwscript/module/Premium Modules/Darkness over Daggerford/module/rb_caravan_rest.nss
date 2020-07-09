void CaravanRest(object oPC)
{
    object oBed =GetWaypointByTag("WP_BED_REST");

    ActionMoveToObject(oBed);
    ActionDoCommand(SetFacing(0.0));
    ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE, 1.0, 4.0);
    ActionDoCommand(ForceRest(OBJECT_SELF));
}

void main()
{

    object oPC = GetPCSpeaker();
    AssignCommand(oPC, CaravanRest(oPC));
}
