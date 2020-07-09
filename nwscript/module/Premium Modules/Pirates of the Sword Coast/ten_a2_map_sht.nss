//::///////////////////////////////////////////////
//:: ten_a2_map_sht
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Cartographer in the city of spindrift
    barks his sales pitch to passers by.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Aug, 2004
//:://////////////////////////////////////////////

void main()
{
    object oEnter = GetEnteringObject();
    object oMapper = GetObjectByTag("a2_mapseller");

    if (GetIsPC(oEnter) == TRUE)
    {
        AssignCommand(oMapper, SpeakOneLinerConversation("a2_mapsell_sht", oEnter));
    }
}
