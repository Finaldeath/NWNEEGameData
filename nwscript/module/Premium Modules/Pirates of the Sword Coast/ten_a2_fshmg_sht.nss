//::///////////////////////////////////////////////
//:: ten_a2_fshmg_sht
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The FishMonger in the city of spindrift
    barks his sales pitch to passers by.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Aug, 2004
//:://////////////////////////////////////////////

void main()
{
    object oEnter = GetEnteringObject();
    object oFishMonger = GetObjectByTag("a2_fishmonger");

    if (GetIsPC(oEnter) == TRUE)
    {
        AssignCommand(oFishMonger, SpeakOneLinerConversation("a2_fishmonger", oEnter));
    }
}
