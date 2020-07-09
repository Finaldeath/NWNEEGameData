// area enter script that just spawns all encounters in this area

#include "hf_in_spawn"
#include "hf_in_plot"
#include "x3_inc_horse"

// Display an informative message about the spawns in this area
void DisplayEncounterInfo(object oPC)
{
    if (GetLocalInt(OBJECT_SELF, "aen_tm_info") > 0)
    {
        if (PlotLevelGet("DukesOfDaggerFordDone") <= 0)
        {
            DelayCommand(0.5, AssignCommand(oPC, SpeakString("Without guidance, you become hopelessly lost. You require directions before delving deeper into Thar.")));
            return;
        }
        if (!HorseGetIsMounted(oPC))
        {
            DelayCommand(0.5, AssignCommand(oPC, SpeakString("Without mounts, your progress is slow. Before long, your journey is interrupted!")));
            return;
        }
    }
}


// Cleanup all random encounter in the area if more than a single set of
// encounters is specified
void CleanupRandomEncounter(object oEncTrigger, object oPC)
{
    string sEncName = GetLocalString(oEncTrigger, "aen_tm_spawn_name");
    int nNumEncSets = GetLocalInt(oEncTrigger, "aen_tm_spawn_sets");
    int i = 0;
    string sEncTag = "";
    object oEnc = OBJECT_INVALID;

    int nSet;
    for (nSet=0; nSet < nNumEncSets; nSet++)
    {
        i = 1;
        sEncTag = sEncName+IntToString(nSet);
        oEnc = GetObjectInArea(sEncTag, oPC, i);
        while (GetIsObjectValid(oEnc))
        {
            SpawnRemoveCreatures(oEnc, oPC);
            oEnc = GetObjectInArea(sEncTag, oPC, ++i);
        }
    }
}

// Overwrite HF_SP_NAME if more than a single set of encounters is specified
void SetupRandomEncounter(object oEncTrigger)
{
    int nNumEncSets = GetLocalInt(oEncTrigger, "aen_tm_spawn_sets");
    if (nNumEncSets > 0)
    {
        string sEncName = GetLocalString(oEncTrigger, "aen_tm_spawn_name");
        int nEncSet = Random(nNumEncSets);

        SetLocalString(oEncTrigger, "HF_SP_NAME", sEncName+IntToString(nEncSet));
    }
}


void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        int nGlobalSpawnChance = GetLocalInt(OBJECT_SELF, "aen_tm_spawn_chance");
        if ( (Random(100) <= nGlobalSpawnChance) || (nGlobalSpawnChance <= 0) )
        {
            CleanupRandomEncounter(OBJECT_SELF, oPC);
            SetupRandomEncounter(OBJECT_SELF);
            SpawnEnter(oPC);
            DisplayEncounterInfo(oPC);
        }
    }
}
