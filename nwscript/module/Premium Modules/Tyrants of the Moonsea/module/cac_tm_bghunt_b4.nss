//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_b4
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: PC managed to convince Baerdeth to stand down.
//:: Baerdeth leaves for Malar temple and takes his
//:: Malarites with him.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

// All Malarites with this tag will leave the forest (with hf_cs_exit)
const string NPC_TAG_FOREST_MALARITE = "CR_bghunt_forest_malarite";

const string NPC_RESREF_BAERDETH = "huntmasterbaerde";
const string NPC_TAG_BAERDETH = "HuntmasterBaerdeth";
const string WP_TAG_BAERDETH_JUMP = "WP_bghunt_temple_baerdeth";

const string WP_TAG_BGHUNT_EXIT = "WP_bghunt_forest_exit";

// Tag of Malarite Spawn location
// - Will be created in Malar temple
// - ResRef will be read from WP variables
const string WP_TAG_TEMPLE_MALARITE = "WP_bghunt_temple_malarite";
const string NPC_TAG_TEMPLE_MALARITE = "CR_bghunt_temple_malarite";

// Makes Baerdeth and Malarites leave the area
void npcExit(object oPC)
{
    // Make Baerdeth leave
    object oBaerdeth = GetNearestObjectByTag(NPC_TAG_BAERDETH, oPC);
    SetLocalString(oBaerdeth, "HF_EXIT_NAME", WP_TAG_BGHUNT_EXIT);
    ExecuteScript("hf_cs_exit", oBaerdeth);

    // Make a number of Malarites leave as well
    int nNth = 1;
    object oMalarite = GetNearestObjectByTag(NPC_TAG_FOREST_MALARITE, oPC, nNth);
    while (GetIsObjectValid(oMalarite))
    {
        SetLocalString(oMalarite, "HF_EXIT_NAME", WP_TAG_BGHUNT_EXIT);
        ExecuteScript("hf_cs_exit", oMalarite);

        nNth++;
        oMalarite = GetNearestObjectByTag(NPC_TAG_FOREST_MALARITE, oPC, nNth);
    }
}


// Spawns Baerdeth and Malarites back at the temple
void npcSpawn(object oPC)
{
    // Create a new Baerdeth in the temple
    object oBaerdethWp = GetObjectByTag(WP_TAG_BAERDETH_JUMP);
    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_BAERDETH, GetLocation(oBaerdethWp), FALSE, NPC_TAG_BAERDETH);

    // Create Malarites in the temple
    int nNth = 1;
    object oMalariteWp = GetObjectByTag(WP_TAG_TEMPLE_MALARITE, nNth);
    string sCreatureResRef = "";
    string sCreatureTag = "";
    while (GetIsObjectValid(oMalariteWp))
    {
        sCreatureResRef = GetLocalString(oMalariteWp, "resref");
        sCreatureTag = NPC_TAG_TEMPLE_MALARITE;
        CreateObject(OBJECT_TYPE_CREATURE, sCreatureResRef, GetLocation(oMalariteWp), FALSE, sCreatureTag);

        nNth++;
        oMalariteWp = GetObjectByTag(WP_TAG_TEMPLE_MALARITE, nNth);
    }
}

void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("BigGameHunt", 140, oPC);
    GiveXPToCreature(oPC, GetJournalQuestExperience("BigGameHunt"));

    PlotLevelSet("biggamehunt_status_main", 3); // Quest status
    PlotLevelSet(NPC_TAG_BAERDETH, 2); // Baerdeth dialog

    DelayCommand(2.0f, npcExit(oPC));
    DelayCommand(3.0f, npcSpawn(oPC));


}
