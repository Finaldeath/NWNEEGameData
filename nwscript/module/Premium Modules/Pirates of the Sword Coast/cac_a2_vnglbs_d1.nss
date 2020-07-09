//::///////////////////////////////////////////////
//:: cac_a2_vnglbs_d1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Set that the PC has talked to Vengaul
    atleast once.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Nov 2004
//:://////////////////////////////////////////////

void main()
{
    object oVengaul = OBJECT_SELF;
    object oPC = GetPCSpeaker();

    ExecuteScript("cac_a2_midrse10", oVengaul);
    SetLocalInt(oVengaul, "cac_a2_vnglbs_d1", TRUE);

    //JE: The trigger script ten_a2_initdela sets the NPC to NO_TALKIE
    //and puts the PC into cutscene mode - we need to reverse that here
    SetLocalInt(oVengaul, "NO_TALKIE", FALSE);
    SetCutsceneMode(oPC, FALSE);

    // this variable is used by a failsafe check I have, which ensures
    // the PC doesn't get stuck in cutscene mode if something goes wrong
    // We've just disabled cutscene mode, so we can get rid of this variable
    DeleteLocalInt(oPC, "ten_a2_initdela_cutscene_check");

}
