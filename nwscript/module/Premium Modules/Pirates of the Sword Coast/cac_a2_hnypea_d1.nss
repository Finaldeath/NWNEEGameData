//::///////////////////////////////////////////////
//:: cac_a2_hnypea_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Honey Pea
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

void main()
{
    object oHoney = OBJECT_SELF;
    object oPC = GetPCSpeaker();

    ExecuteScript("cac_a2_midrse10", oHoney);
    SetLocalInt(oHoney, "cac_a2_hnypea_d1", TRUE);

    //JE: The trigger script ten_a2_initdela sets the NPC to NO_TALKIE
    //and puts the PC into cutscene mode - we need to reverse that here
    SetLocalInt(oHoney, "NO_TALKIE", FALSE);
    SetCutsceneMode(oPC, FALSE);
    // this variable is used by a failsafe check I have, which ensures
    // the PC doesn't get stuck in cutscene mode if something goes wrong
    // We've just disabled cutscene mode, so we can get rid of this variable
    DeleteLocalInt(oPC, "ten_a2_initdela_cutscene_check");

}
