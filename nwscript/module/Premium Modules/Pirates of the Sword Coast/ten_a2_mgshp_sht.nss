//::///////////////////////////////////////////////
//:: ten_a2_mgshp_sht
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The magic dealer in the city of spindrift
    barks her sales pitch to passers by.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Aug, 2004
//:://////////////////////////////////////////////

void main()
{
    object oEnter = GetEnteringObject();
    object oMagicDealer = GetObjectByTag("a2_magicshop");

    if (GetIsPC(oEnter) == TRUE)
    {
        AssignCommand(oMagicDealer, SpeakOneLinerConversation("a2_mgcstor_sht", oEnter));
    }
}
