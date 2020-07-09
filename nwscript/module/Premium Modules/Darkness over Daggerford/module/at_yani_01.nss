// yani redecorates the player's stronghold

#include "hf_in_plot"

void ActivateLights()
{
    int i = 0;
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20);
    object oLight = GetObjectByTag("Stronghold_Candelabra", i);

    while(GetIsObjectValid(oLight))
    {
        if(GetLocalInt(oLight, "NW_L_AMION") == 0)
        {
            AssignCommand(oLight, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            SetLocalInt(oLight, "NW_L_AMION",1);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oLight);
        }
        oLight = GetObjectByTag("Stronghold_Candelabra", ++i);
    }
}


// create instances of the chosen rug type in the stronghold
void PlaceRugs(int nChoice)
{
    string s;
    if      (nChoice == 1) s = "dag_x0_rg1_3";    // blue
    else if (nChoice == 2) s = "dag_x0_rg1_4";    // yellow
    else if (nChoice == 3) s = "dag_x0_rg1_1";    // purple
    else if (nChoice == 4) s = "x0_rugoriental";  // red
    else if (nChoice == 5) s = "x0_bearskinrug1"; // bearskin

    int i = 0;
    object oWP = GetObjectByTag("WP_AR1301_FURN_RUG", i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, s, GetLocation(oWP));
        oWP = GetObjectByTag("WP_AR1301_FURN_RUG", ++i);
    }
}

// create instances of the chosen container type in the stronghold
void PlaceContainers(int nChoice)
{
    string s;
    if      (nChoice == 1) s = "plc_chest2";      // chest
    else if (nChoice == 2) s = "plc_armoire";     // armoire
    else if (nChoice == 3) s = "plc_desk";        // desk
    else if (nChoice == 4) s = "plc_chstdrwrs";   // cabinet
    else if (nChoice == 5) s = "x0_tomb";         // coffin

    int i = 0;
    object oWP = GetObjectByTag("WP_AR1301_FURN_CHEST", i);
    while (GetIsObjectValid(oWP))
    {
        object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, s, GetLocation(oWP));
        SetLocalInt(oChest, "NW_DO_ONCE", 1);
        oWP = GetObjectByTag("WP_AR1301_FURN_CHEST", ++i);
    }
}

// create the chosen throne type in the stronghold
void PlaceThrone(int nChoice)
{
    string s;
    if      (nChoice == 1) s = "plc_thronegood";
    else if (nChoice == 2) s = "x0_thronewood";
    else if (nChoice == 3) s = "x0_cushions";
    else if (nChoice == 4) s = "plc_throneevil";
    else if (nChoice == 5) s = "";

    object oWP = GetWaypointByTag("WP_AR1301_FURN_THRONE");
    CreateObject(OBJECT_TYPE_PLACEABLE, s, GetLocation(oWP));

    int i = 0;
    oWP = GetObjectByTag("WP_AR1301_FURN_THRONE_URN", i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_urn", GetLocation(oWP));
        oWP = GetObjectByTag("WP_AR1301_FURN_THRONE_URN", ++i);
    }
}

// create the chosen seating arrangement in the stronghold
void PlaceSeats(int nChoice)
{
    string s;
    if      (nChoice == 1) s = "pdag_tablebest";   // table
    else if (nChoice == 2) s = "plc_couch";        // couch
    else if (nChoice == 3) s = "dag_x0_cus1";      // cushions
    else if (nChoice == 4) s = "pdag_postbed";     // bed
    else if (nChoice == 5) s = "x0_largebench";    // bench

    object oWP = GetWaypointByTag("WP_AR1301_FURN_TABLE");
    CreateObject(OBJECT_TYPE_PLACEABLE, s, GetLocation(oWP));
}

// create the chosen theme in the stronghold
void PlaceTheme(int nChoice)
{
    string s1;
    string s2;
    string s3;
    if      (nChoice == 1)
        { s1 = "plc_statue3"; s2 = "plc_statue1"; s3 = "plc_pedestal"; }            // stone
    else if (nChoice == 2)
        { s1 = "x2_plc_statue_h"; s2 = "tnoshieldrack"; s3 = "tnoflage24"; }        // military
    else if (nChoice == 3)
        { s1 = "tnotree1sm"; s2 = "pdag_vase2grn"; s3 = "pdag_bushsm"; }            // earthy
    else if (nChoice == 4)
        { s1 = "tnogiantpot"; s2 = "plc_torture1"; s3 = "x0_skullpole"; }           // dungeon
    else if (nChoice == 5)
        { s1 = "x2_plc_statue_fl";  s2 = "plc_magicred"; s3 = "x2_plc_mfdevice1"; } // mystic

    int i = 0;
    object oWP = GetObjectByTag("WP_AR1301_FURN_THEME_LARGE", i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, s1, GetLocation(oWP));
        oWP = GetObjectByTag("WP_AR1301_FURN_THEME_LARGE", ++i);
    }

    i = 0;
    oWP = GetObjectByTag("WP_AR1301_FURN_THEME_MEDIUM", i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, s2, GetLocation(oWP));
        oWP = GetObjectByTag("WP_AR1301_FURN_THEME_MEDIUM", ++i);
    }

    i = 0;
    oWP = GetObjectByTag("WP_AR1301_FURN_THEME_SMALL", i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, s3, GetLocation(oWP));
        oWP = GetObjectByTag("WP_AR1301_FURN_THEME_SMALL", ++i);
    }
}

// change the background music in the stronghold
void PlaceMusic()
{
    object oWP = GetObjectByTag("WP_AR1301_FURN_CHEST");
    object oArea = GetArea(oWP);
    MusicBackgroundChangeDay(oArea, TRACK_THEME_GEND);
    MusicBackgroundChangeNight(oArea, TRACK_THEME_GEND);
}

void main()
{
    object oPC = GetPCSpeaker();
    int nChoice;

    // update yani's plot
    PlotLevelSet("ks_yani", 2);

    // take gold from the player
    if (GetLocalInt(OBJECT_SELF, "nBribed") == 0)
        TakeGoldFromCreature(500, oPC);
    else
        TakeGoldFromCreature(100, oPC);

    // fade to black
    ActionPauseConversation();
    DelayCommand(1.0, FadeToBlack(oPC, FADE_SPEED_FAST));
    DelayCommand(4.0, FadeFromBlack(oPC, FADE_SPEED_FAST));
    DelayCommand(6.0, ActionResumeConversation());

    // cleanup the junk inside the stronghold
    int i = 0;
    object oJunk = GetObjectByTag("ar1301_junk", i);
    while (GetIsObjectValid(oJunk))
    {
        DestroyObject(oJunk);
        oJunk = GetObjectByTag("ar1301_junk", ++i);
    }

    // adjust music
    PlaceMusic();
    ActivateLights();

    // place rugs
    nChoice = GetLocalInt(OBJECT_SELF, "nChoice_1");
    DelayCommand(1.0, PlaceRugs(nChoice));

    // place containers
    nChoice = GetLocalInt(OBJECT_SELF, "nChoice_2");
    DelayCommand(2.0, PlaceContainers(nChoice));

    // place throne
    nChoice = GetLocalInt(OBJECT_SELF, "nChoice_3");
    DelayCommand(3.0, PlaceThrone(nChoice));

    // place seating area
    nChoice = GetLocalInt(OBJECT_SELF, "nChoice_4");
    DelayCommand(4.0, PlaceSeats(nChoice));

    // place "theme"
    nChoice = GetLocalInt(OBJECT_SELF, "nChoice_5");
    DelayCommand(5.0, PlaceTheme(nChoice));
}
