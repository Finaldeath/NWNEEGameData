//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_thayanam0
//:: DATE: January 30, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassadors
//:: Gives the PC an Invitation (only one per NPC)
//::////////////////////////////////////////////////////

#include "hf_in_plot"

const string ITM_RESREF_CEREMONY_PASS = "tm_it_ceremonyp0";

void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;

    if (GetLocalInt(oNPC, "thayanam_invitation") == 0)
    {
        SetLocalInt(oNPC, "thayanam_invitation", 1);
        CreateItemOnObject(ITM_RESREF_CEREMONY_PASS, oPC);
    }

    // Prevent regression
    if (PlotLevelGet("thayanam_status") <= 1)
    {
        AddJournalQuestEntry("ThayanAmbassadors", 20, oPC);
    }
}
