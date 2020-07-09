// onEnter event for AR2100
// .. sets up the Umgatlik quest

#include "hf_in_spawn"
#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        // damian's special halloween code
        if (GetLocalInt(GetModule(), "area_trans_popup") == 1)
        {
            SetLocalInt(GetModule(), "area_trans_popup", 0);
            DelayCommand(4.0, AssignCommand(oPC,SpeakString
            ("The forest is dense and many times you fear that you have lost your way.")));
        }

        // spawn some footprints for hevesar's final quest (missing shepherds)
        if (GetLocalInt(GetModule(), "hevesar_plot") == 5)
        {
            if (GetLocalInt(OBJECT_SELF, "nSpawnedOrcFootprints") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nSpawnedOrcFootprints", 1);
                object oWP = GetWaypointByTag("WP_AR2100_ORC_FOOTPRINTS");
                CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_orcfoots", GetLocation(oWP));
            }
        }

        // spawn the cleric if the player has umgatlik's quest
        string sClericTag = GetLocalString(GetModule(), "UmgatlikCleric");
        if (sClericTag != "")
        {
            // the player has umgatlik's quest, so spawn the cleric
            if (GetLocalInt(OBJECT_SELF, "nClericSpawned") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nClericSpawned", 1);
                object oWP = GetWaypointByTag("WP_AR2100_CLERIC_SPAWN");
                CreateObject(OBJECT_TYPE_CREATURE, sClericTag, GetLocation(oWP));
                PlotLevelSet(sClericTag, 2);
                oWP = GetWaypointByTag("WP_AR2100_CLERIC_FIRE");
                CreateObject(OBJECT_TYPE_PLACEABLE, "plc_campfrwpot", GetLocation(oWP));
            }
        }

        // run the standard spawns for this area
        SpawnEnter(oPC);
    }
}
