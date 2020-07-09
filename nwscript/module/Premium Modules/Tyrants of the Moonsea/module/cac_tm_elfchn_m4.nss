//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NOTE: Quest script for "Elf In Chains" Quest
//::////////////////////////////////////////////////////
//:: Slaves are freed by buying them
//:: (even at 0 gp price through blackmail)
//::////////////////////////////////////////////////////

#include "hf_in_plot"


const string NPC_TAG_SLAVE = "tm_cr_melv_slave";
const string NPC_TAG_CREEL = "SlavemasterCreel";

void main()
{
    object oPC = GetPCSpeaker();
    object oNPC = OBJECT_SELF;
    int nPlotCreelStatus = PlotLevelGet("ElfInChains-Creel-Status");
    int nGoldToPay = 100000;
    int nJournalEntry = 7;

    switch (nPlotCreelStatus)
    {
        case 5: // free
        {
            nGoldToPay = 0;
            nJournalEntry = 6;
            break;
        }
        case 4: // 50k gp
        {
            nGoldToPay = 50000;
            nJournalEntry = 8;
            break;
        }
        case 3: // 25k gp
        {
            nGoldToPay = 25000;
            nJournalEntry = 8;
            break;
        }
        default: // 100k gp
        {
            nGoldToPay = 100000;
            nJournalEntry = 7;
            break;
        }
    }

    // Re-check gold
    if (GetGold(oPC) >= nGoldToPay)
    {
        PlotLevelSet("ElfInChains-Status", 4); // Ends quest
        PlotLevelSet("Elf", 11); // Set up Elf dialog for when he was bought
        PlotLevelSet(NPC_TAG_CREEL, 1); // Set up Creel dialog (purely for safety as he will leave)
        AddJournalQuestEntry("ElfinChains", nJournalEntry, oPC);
        GiveXPToCreature(oPC, GetJournalQuestExperience("ElfinChains"));
        TakeGoldFromCreature(nGoldToPay, oPC, TRUE);

        // Slaves leave
        int nNth = 0;
        object oSlave = GetObjectByTag(NPC_TAG_SLAVE, nNth);
        while (GetIsObjectValid(oSlave))
        {
            ExecuteScript("hf_cs_exit", oSlave);
            nNth++;
            oSlave = GetObjectByTag(NPC_TAG_SLAVE, nNth);
        }

        // Creel leaves
        object oCreel = GetObjectByTag(NPC_TAG_CREEL);
        ExecuteScript("hf_cs_exit", oCreel);
    }
    else
    {
        AssignCommand(oNPC, SpeakString("Pah! Come back when you have enough gold."));
    }
}
