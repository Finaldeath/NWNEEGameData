//::///////////////////////////////////////////////
//:: FileName con_ac_dax_flee
//:: Dax flees and variable is set
//:: Don't forget to set flag on NPC
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/25/2005 4:53:00 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
void main()
{
    SetPlotFlag(OBJECT_SELF, 1);
    SetLocalInt(GetPCSpeaker(), "ac_plague_quest", 3);
    SetLocalInt(GetModule(), "iDaxiongFled", 1);
    SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "EXIT_ac_daxiong");
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
