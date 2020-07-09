//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Starts Ilandras distraction at the docks
//::////////////////////////////////////////////////////

#include "hf_in_plot"
#include "hf_in_npc"


const string TRG_TAG_CUTSCENE_TRIGGER = "trg_elfchain_cutscene";

const string AREA_TAG_MELVAUNT_CENTER = "MelvauntCentralMarket";

// Ilandra's crew
const string NPC_TAG_ILANDRA_CREW = "IlandraCrew";


void npcExit(string sNPCtag, object oPC)
{
    int nNth = 0;
    object oNPC = GetNearestObjectByTag(sNPCtag, oPC, nNth);
    while (GetIsObjectValid(oNPC))
    {
        ExecuteScript("hf_cs_exit", oNPC);
        nNth++;
        oNPC = GetNearestObjectByTag(sNPCtag, oPC, nNth);
    }
}

void main()
{
    object oPC = GetPCSpeaker();

    // Setup plot variables and journal
    PlotLevelSet("ElfInChains-Status", 3);
    AddJournalQuestEntry("ElfinChains", 9, oPC);

    // Activate cutscene trigger
    object oCutsceneTrigger = GetObjectByTag(TRG_TAG_CUTSCENE_TRIGGER);
    SetLocalInt(oCutsceneTrigger, "nDone", 0);

    // Fade screen to simulate Ilandra talking to her crew
    AssignCommand(oPC, ActionPauseConversation());
    FadeToBlack(oPC, FADE_SPEED_FAST);
    DelayCommand(2.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
    DelayCommand(3.0, npcExit(NPC_TAG_ILANDRA_CREW, oPC)); // Ilandras crew leaves
    DelayCommand(3.0, AssignCommand(oPC, ActionResumeConversation()));
}
