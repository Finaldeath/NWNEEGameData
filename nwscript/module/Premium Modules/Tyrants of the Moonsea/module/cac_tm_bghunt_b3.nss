//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: cac_tm_bghunt_b3
//:: DATE: January 10, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Quest: Big Game Hunt - Main (Baerdeth)
//:: Baerdeth leaves for Cormathor forest and takes some
//:: Malarites with him.
//::////////////////////////////////////////////////////

#include "hf_in_plot"

// All Malarites with this tag will leave the temple (with hf_cs_exit)
const string NPC_TAG_TEMPLE_MALARITE = "CR_bghunt_temple_malarite";

const string NPC_RESREF_BAERDETH = "huntmasterbaerde";
const string NPC_TAG_BAERDETH = "HuntmasterBaerdeth";
const string WP_TAG_BAERDETH_JUMP = "WP_bghunt_forest_baerdeth";

const string WP_TAG_BGHUNT_EXIT = "WP_bghunt_temple_exit";

// Tag of Malarite Spawn location
// - Will be created in Cormathor Forest
// - ResRef will be read from WP variable
const string WP_TAG_FOREST_MALARITE = "WP_bghunt_forest_malarite";
const string NPC_TAG_FOREST_MALARITE = "CR_bghunt_forest_malarite";


// Makes Baerdeth and Malarites leave the area
void NpcExit(object oPC)
{
    // Make Baerdeth leave
    object oBaerdeth = GetNearestObjectByTag(NPC_TAG_BAERDETH, oPC);
    SetLocalString(oBaerdeth, "HF_EXIT_NAME", WP_TAG_BGHUNT_EXIT);
    ExecuteScript("hf_cs_exit", oBaerdeth);

    // Make Malarites leave as well
    int nNth = 1;
    object oMalarite = GetNearestObjectByTag(NPC_TAG_TEMPLE_MALARITE, oPC, nNth);
    while (GetIsObjectValid(oMalarite))
    {
        SetLocalString(oMalarite, "HF_EXIT_NAME", WP_TAG_BGHUNT_EXIT);
        ExecuteScript("hf_cs_exit", oMalarite);

        nNth++;
        oMalarite = GetNearestObjectByTag(NPC_TAG_TEMPLE_MALARITE, oPC, nNth);
    }
}


void NpcSpawn(object oPC)
{
    // Create a new Baerdeth in Cormathor
    object oBaerdethWp = GetObjectByTag(WP_TAG_BAERDETH_JUMP);
    CreateObject(OBJECT_TYPE_CREATURE, NPC_RESREF_BAERDETH, GetLocation(oBaerdethWp), FALSE, NPC_TAG_BAERDETH);

    // Create Malarites in Cormanthor
    int nNth = 1;
    object oMalariteWp = GetObjectByTag(WP_TAG_FOREST_MALARITE, nNth);
    string sCreatureResRef = "";
    while (GetIsObjectValid(oMalariteWp))
    {
        sCreatureResRef = GetLocalString(oMalariteWp, "resref");
        CreateObject(OBJECT_TYPE_CREATURE, sCreatureResRef, GetLocation(oMalariteWp), FALSE, NPC_TAG_FOREST_MALARITE);

        nNth++;
        oMalariteWp = GetObjectByTag(WP_TAG_FOREST_MALARITE, nNth);
    }
}


// Destroy all creatures spawned from encounters in the area
void DestroyEncounterCreatures(object oArea)
{
    object oObject = GetFirstObjectInArea(oArea);
    int nNumEncountersInArea = 0;
    while (GetIsObjectValid(oObject))
    {
        if ( (GetObjectType(oObject) == OBJECT_TYPE_CREATURE) &&
             GetIsEncounterCreature(oObject) )
        {
            DestroyObject(oObject);
        }

        oObject = GetNextObjectInArea(oArea);
    }
}


void main()
{
    object oPC = GetPCSpeaker();

    object oForestWaypoint = GetWaypointByTag(WP_TAG_FOREST_MALARITE);
    DestroyEncounterCreatures(GetArea(oForestWaypoint));

    DelayCommand(2.0f, NpcExit(oPC));
    DelayCommand(3.0f, NpcSpawn(oPC));
}
