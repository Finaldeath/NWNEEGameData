//::///////////////////////////////////////////////
//:: aen_a0_seedytvrn
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Auto explore the area for PCs as they join
    for the first time. This is done to get rid
    of the black fog of war tiles in the area.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oPC, "aen_a0_seedytvrn");

    if ((iDoOnce == FALSE) && (GetIsPC(oPC) == TRUE))
    {
        SetLocalInt(oPC, "aen_a0_seedytvrn", TRUE);
        ExploreAreaForPlayer(oArea, oPC);
    }
}
