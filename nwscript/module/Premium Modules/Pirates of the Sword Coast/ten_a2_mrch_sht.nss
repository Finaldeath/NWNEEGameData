//::///////////////////////////////////////////////
//:: ten_a2_mrch_sht
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The rogue merchant in the city of spindrift
    barks his sales pitch to passers by.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Aug, 2004
//:://////////////////////////////////////////////

void main()
{
    object oEnter = GetEnteringObject();
    object oMerchant = GetObjectByTag("a2_rgmrchnt");

    if (GetIsPC(oEnter) == TRUE)
    {
        AssignCommand(oMerchant, SpeakOneLinerConversation("a2_blckmrkt_sht", oEnter));
    }
}
