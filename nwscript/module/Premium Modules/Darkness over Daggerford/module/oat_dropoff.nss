void main()
{
    //the destination area of the south cave entrance
    //in the Crab's Claw coast area varies depedning on the
    //state of the "hevesar_plot" integer

    object oPC = GetClickingObject();
    location lEmpty = GetLocation(GetWaypointByTag("dropoff_empty"));
    location lBusy = GetLocation(GetWaypointByTag("dropoff_busy"));
    if (GetLocalInt(GetModule(), "hevesar_plot") <5)
    //the missing farmers plot is not yet active
    {
        AssignCommand(oPC, ActionJumpToLocation(lEmpty));
    }
    else
    {
        AssignCommand(oPC,ActionJumpToLocation(lBusy));
    }
}
