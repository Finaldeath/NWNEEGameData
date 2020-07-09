// onEnter event for Liam's Hold
// .. runs cutscenes and spawns day/night commoners in town

#include "hf_in_spawn"
#include "hf_in_cutscene"
#include "hf_in_util"
#include "inc_stronghold"

// spawn yani
void SpawnYani(object oPC)
{
    // spawn Yani
    object oWP = GetWaypointByTag("WP_AR1300_CUT2_MERCHANT");
    object oYani = CreateObject(OBJECT_TYPE_CREATURE, "ks_yani", GetLocation(oWP));

    // spawn Yani's ox
    oWP = GetWaypointByTag("WP_AR1300_CUT2_MERCHANT_OX");
    object oOx = CreateObject(OBJECT_TYPE_CREATURE, "nw_ox", GetLocation(oWP));
    ChangeFaction(oOx, oYani);

    // spawn Yani's wagon
    oWP = GetWaypointByTag("WP_AR1300_CUT2_MERCHANT_WAGON");
    CreateObject(OBJECT_TYPE_PLACEABLE, "am_wagon1", GetLocation(oWP));

    // spawn Yani's fire
    oWP = GetWaypointByTag("WP_AR1300_CUT2_MERCHANT_FIRE");
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_campfrwpot", GetLocation(oWP));
}

// did the player exit the front door?
int IsFrontDoorExit(object oPC)
{
    object oStrongholdDoor = GetObjectByTag("AR1300_AR1301_EXIT1");
    float fDist = GetDistanceBetween(oStrongholdDoor, oPC);
    if (fDist >= 0.0 && fDist <= 5.0)
    {
        return(TRUE);
    }
    return(FALSE);
}

void main()
{
    object oPC = GetEnteringObject();

    if (GetIsPC(oPC))
    {
        // Yani appears when the player first exits the stronghold and the area
        if (GetLocalInt(GetModule(), "yani_appears") == 2)
        {
            SetLocalInt(GetModule(), "yani_appears", 3);
            SpawnYani(oPC);
        }

        // Teygan confronts the player
        if(GetLocalInt(GetModule(), "teygan_start") == 1)
        {
            // teygan confronts the player if we're coming out
            if (IsFrontDoorExit(oPC))
            {
                SetWeather(OBJECT_SELF, WEATHER_RAIN);
                CutscenePlay(oPC, "mv_ar1300_1");
            }
        }
        else
        {
            // restore the default weather settings for this area
            SetWeather(OBJECT_SELF, WEATHER_USE_AREA_SETTINGS);

            // spawn the stronghold messenger if one is waiting
            // .. and we're coming out of the stronghold
            if (IsFrontDoorExit(oPC))
            {
                QuestMessengerSpawn(oPC);
                QuestMessengerTalk(oPC);
            }
        }

        //create Lashar the shopkeeper if daytime
        location lLashar = GetLocation(GetWaypointByTag("wp_lashar_day"));
        object oLashar = GetObjectInArea("db_lashar", OBJECT_SELF);
        if(GetIsDay() || GetIsDawn())
        {
            if (!GetIsObjectValid(oLashar))
            {
                CreateObject(OBJECT_TYPE_CREATURE, "db_lashar" ,lLashar, FALSE);
            }
        }
        else
        {
            if (GetIsObjectValid(oLashar))
            {
                DestroyObject(oLashar,0.1);
            }
        }

        //this section deals with the day/night cycle of spawns in the town
        int nSpawnType = 1;
        if (GetIsNight())
            nSpawnType = -1;

        int nLastSpawnType = GetLocalInt(OBJECT_SELF, "nLastSpawnType");
        if (nLastSpawnType != nSpawnType)
        {
            SpawnRemoveAllCreatures(oPC);
            SpawnEnter(oPC);
            SetLocalInt(OBJECT_SELF, "nLastSpawnType", nSpawnType);
        }

        // should we do an autosave?
        // .. remember that this doesn't work if we're inside a cutscene
        if (GetIsPC(oPC))
        {
            if (GetLocalInt(oPC, "HF_DO_AUTOSAVE") == 1)
            {
                SetLocalInt(oPC, "HF_DO_AUTOSAVE", 0);
                DoSinglePlayerAutoSave();
            }
        }
    }
}
