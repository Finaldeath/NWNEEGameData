//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_thayanam1
//:: DATE: January 30, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Thayan Ambassadors
//:: Teleports the PC and a single Henchmen into
//:: the Red Wizard enclave.
//:: Henchman is selected with HF_ARG.
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_henchman"

const string WP_TAG_THAYAN_EMBASSY_PC_JUMP = "WP_cut_thayanam1_pc_init";
const string NPC_TAG_ZAMAKUS = "CaptainZamakus";

const string HENCH_TAG_LYRESSA = "Lyressa";
const string HENCH_TAG_SHARALYN = "SharalynHenchman";
const string HENCH_TAG_BEIRMOURA = "Beirmoura";

// Dismiss all but one henchmen
void DismissHenchmen(object oPC, int nHF_ARG)
{
    // Get the tag of the henchman to keep
    string sHenchToKeep = "";
    switch(nHF_ARG)
    {
        case 4:
        {
            sHenchToKeep = HENCH_TAG_SHARALYN;
            break;
        }
        case 3:
        {
            sHenchToKeep = HENCH_TAG_LYRESSA;
            break;
        }
        case 2:
        {
            sHenchToKeep = HENCH_TAG_BEIRMOURA;
            break;
        }
        default:
        {
            sHenchToKeep = "abc"; // Going in alone
            break;
        }
    }
    // SendMessageToPC(oPC, sHenchToKeep);

    // Fire all henchmen except the one with the matching tag.
    int i = 1;
    object oHench = OBJECT_INVALID;
    for (i=1; i<=GetMaxHenchmen(); i++)
    {
        oHench = GetHenchman(oPC, i);
        if (GetIsObjectValid(oHench))
        {
            // SendMessageToPC(oPC, GetName(oHench) + "-" + GetTag(oHench));
            if (GetTag(oHench) != sHenchToKeep)
            {
                // SendMessageToPC(oPC, "Fire");
                DelayCommand(0.5f, HenchmanFire(oHench, oPC));
            }
        }
    }
}


void main()
{
    object oPC = GetPCSpeaker();
    object oZamakus = GetNearestObjectByTag(NPC_TAG_ZAMAKUS, oPC);
    object oWaypoint = GetWaypointByTag(WP_TAG_THAYAN_EMBASSY_PC_JUMP);

    int nHF_ARG = GetLocalInt(oZamakus, "HF_ARG");
    DismissHenchmen(oPC, nHF_ARG);

    DelayCommand(0.5f, AssignCommand(oPC, ClearAllActions(TRUE)));
    DelayCommand(2.0f, AssignCommand(oPC, JumpToLocation(GetLocation(oWaypoint))));

    // Prevent regression
    if (PlotLevelGet("thayanam_status") < 2)
    {
       PlotLevelSet("thayanam_status", 2);
       AddJournalQuestEntry("ThayanAmbassadors", 20, oPC);

       // Dialog for Thayan Guard (Officer)
       PlotLevelSet(NPC_TAG_ZAMAKUS, 3);
    }
}
