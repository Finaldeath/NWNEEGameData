//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cut_tm_battle
// DATE: February 16, 2019
// AUTH: Rich Barker
// NOTE: Cutscene of Pirate Blockade
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"
#include "hf_in_util"
#include "inc_ktgate"

const string NPC_TAG_KRAMER = "Kramer";
const string NPC_TAG_MESSENGER = "MulmasterMessenger";

const string NPC_TAG_PIRATE1 = "PirateBattle1";
const string NPC_TAG_PIRATE2 = "PirateBattle2";
const string NPC_TAG_PIRATE3 = "PirateBattle3";
const string NPC_TAG_PIRATE4 = "PirateBattle4";
const string NPC_TAG_PIRATE5 = "PirateBattle5";
const string NPC_TAG_PIRATE6 = "PirateBattle6";
const string NPC_TAG_PIRATE7 = "PirateBattle7";
const string NPC_TAG_PIRATE8 = "PirateBattle8";
const string NPC_TAG_PIRATE9 = "PirateBattle9";
const string NPC_TAG_PIRATE10 = "PirateBattle10";
const string NPC_TAG_PIRATE11 = "PirateBattle11";
const string NPC_TAG_PIRATE12 = "PirateBattle12";
const string NPC_TAG_PIRATE13 = "PirateBattle13";
const string NPC_TAG_PIRATE14 = "PirateBattle14";
const string NPC_TAG_PIRATE15 = "PirateBattle15";
const string NPC_TAG_PIRATE16 = "PirateBattle16";
const string NPC_TAG_PIRATE17 = "PirateBattle17";

const string NPC_TAG_CAPTAIN = "MulmasterCaptain";
const string NPC_TAG_SAILOR1 = "MulmasterSailor1";
const string NPC_TAG_SAILOR2 = "MulmasterSailor2";
const string NPC_TAG_SAILOR3 = "MulmasterSailor3";
const string NPC_TAG_SAILOR4 = "MulmasterSailor4";
const string NPC_TAG_SAILOR5 = "MulmasterSailor5";
const string NPC_TAG_SAILOR6 = "MulmasterSailor6";
const string NPC_TAG_SAILOR7 = "MulmasterSailor7";
const string NPC_TAG_SAILOR8 = "MulmasterSailor8";
const string NPC_TAG_SAILOR9 = "MulmasterSailor9";
const string NPC_TAG_SAILOR10 = "MulmasterSailor10";
const string NPC_TAG_SAILOR11 = "MulmasterSailor11";
const string NPC_TAG_SAILOR12 = "MulmasterSailor12";
const string NPC_TAG_SAILOR13 = "MulmasterSailor13";
const string NPC_TAG_SAILOR14 = "MulmasterSailor14";
const string NPC_TAG_SAILOR15 = "MulmasterSailor15";

const string PLC_TAG_CATAPULT = "NavalCatapult";
const string PLC_TAG_BALLISTA = "NavalBallista";

const string WP_TAG_PC_INIT = "WP_MOBT_CS_PC_START";

void SetupActors(object oPC)
{
    object oActor = GetObjectInArea(NPC_TAG_KRAMER, oPC);
    CutsceneAddActor(NPC_TAG_KRAMER, oActor);
    oActor = GetObjectInArea(NPC_TAG_MESSENGER, oPC);
    CutsceneAddActor(NPC_TAG_MESSENGER, oActor);

    oActor = GetObjectInArea(NPC_TAG_PIRATE1, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE1, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE2, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE2, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE3, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE3, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE4, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE4, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE16, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE16, oActor);

    oActor = GetObjectInArea(NPC_TAG_CAPTAIN, oPC);
    CutsceneAddActor(NPC_TAG_CAPTAIN, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR1, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR1, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR2, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR2, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR3, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR3, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR4, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR4, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR5, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR5, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR13, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR13, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR14, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR14, oActor);

    oActor = GetObjectInArea(PLC_TAG_BALLISTA, oPC);
    CutsceneAddActor(PLC_TAG_BALLISTA, oActor);
    oActor = GetObjectInArea(PLC_TAG_CATAPULT, oPC);
    CutsceneAddActor(PLC_TAG_CATAPULT, oActor);
}

void SetUpSceneTwoActors(object oPC)
{
    object oActor = GetObjectInArea(NPC_TAG_PIRATE5, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE5, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE6, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE6, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE7, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE7, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE8, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE8, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE9, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE9, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE10, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE10, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE11, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE11, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE12, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE12, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE13, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE13, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE14, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE14, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE15, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE15, oActor);
    oActor = GetObjectInArea(NPC_TAG_PIRATE17, oPC);
    CutsceneAddActor(NPC_TAG_PIRATE17, oActor);

    oActor = GetObjectInArea(NPC_TAG_SAILOR6, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR6, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR7, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR7, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR8, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR8, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR9, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR9, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR10, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR10, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR11, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR11, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR12, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR12, oActor);
    oActor = GetObjectInArea(NPC_TAG_SAILOR15, oPC);
    CutsceneAddActor(NPC_TAG_SAILOR15, oActor);

    oActor = GetObjectInArea(PLC_TAG_CATAPULT, oPC);
    CutsceneAddActor(PLC_TAG_CATAPULT, oActor);
}

//Create a wall of fire at a specified waypoint
void CreateShipFire(string sWaypoint)
{
    effect eFire = EffectAreaOfEffect(AOE_PER_WALLFIRE);
    location lTarget = GetLocation(GetWaypointByTag(sWaypoint));

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eFire, lTarget, 20.0);
}


//Fire a ship ballista at a target
void FireNavalBallista(object oTarget)
{
    int nBallistaSpell = 794;

    float fFacing = 0.0;
    float fNewFacing = 0.0;

    //Face target adjusted by 90 degrees to the right due to placeable facing
    SetFacingPoint(GetPosition(oTarget));
    fFacing = GetFacing(OBJECT_SELF);
    fNewFacing = GetCustomRightDirection(fFacing, 90.0);
    SetFacing(fNewFacing);

    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);

    ActionCastSpellAtObject(nBallistaSpell,
                            oTarget,
                            METAMAGIC_ANY,
                            TRUE,
                            15,
                            PROJECTILE_PATH_TYPE_HOMING,
                            TRUE);
}

//Fire a large (fireball) catapult at a target
void FireNavalCatapult(object oTarget)
{
    int nSpell = 553;

    ActionCastSpellAtObject(nSpell,
                            oTarget,
                            METAMAGIC_ANY,
                            TRUE,
                            15,
                            PROJECTILE_PATH_TYPE_BALLISTIC,
                            TRUE);
}

//Fire a small (fire bolt) catapult at a target, optionally at a miss location
void FireSmallCatapult(object oTarget, int nMiss = FALSE)
{
    int nSpell = SPELLABILITY_BOLT_FIRE;
    effect eVFX = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eDam = EffectDamage(100);

    if(!nMiss)
    {
        ActionCastFakeSpellAtObject(nSpell, oTarget, PROJECTILE_PATH_TYPE_BALLISTIC);

        float fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
        float fDelay = fDist/(3.0 * log(fDist) + 2.0);

        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
    }
    else
    {
        location lMiss = GetRandomMissLocation(oTarget);
        ActionCastFakeSpellAtLocation(nSpell, lMiss, PROJECTILE_PATH_TYPE_BALLISTIC);

        float fDist = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF), lMiss);
        float fDelay = fDist/(3.0 * log(fDist) + 2.0);

        DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lMiss));
    }
}

//Fire a volley of nNumber arrows over course of a second close to oTarget
void FireArrowVolley(object oTarget, int nNumber)
{
    int i;
    float fDelay = IntToFloat(nNumber) / 10.0;

    object oSource = GetNearestObjectByTag("ArrowEffect", oTarget);

    for( i = 1; i <= nNumber; i++)
    {
        //fDelay = IntToFloat(i) / 10.0;

        DelayCommand((fDelay * i),
            AssignCommand(oSource,
                ActionCastSpellAtLocation(SPELL_TRAP_ARROW,
                                          GetRandomMissLocation(oTarget),
                                          METAMAGIC_ANY,
                                          TRUE,
                                          PROJECTILE_PATH_TYPE_HOMING,
                                          TRUE)));
    }
}

//Kill a pirate with a crossbow bolt effect
void KillPirate(object oPirate)
{
    if(!GetIsDead(oPirate))
    {
        AssignCommand(GetNearestObjectByTag("BoltEffect", oPirate),
            ActionCastSpellAtObject(SPELL_TRAP_BOLT,
                                    oPirate,
                                    METAMAGIC_ANY,
                                    TRUE,
                                    15,
                                    PROJECTILE_PATH_TYPE_HOMING,
                                    TRUE));
        if(!GetIsDead(oPirate))
        {
            DelayCommand(0.6,
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oPirate));
        }
    }
}

//Remove pirates from area at end of cutscene
void DestroyPirates()
{
    int i = 1;

    string sTag = "";
    string sTagPrefix = "PirateBattle";

    object oPC = CutsceneGetPC();
    object oPirate;

    for(i = 1; i <= 17; i++)
    {
        sTag = sTagPrefix + IntToString(i);
        oPirate = GetNearestObjectByTag(sTag, oPC);
        if(GetIsObjectValid(oPirate) && !GetIsDead(oPirate))
        {
            DestroyObject(oPirate);
        }
    }
}

// just start the scene
void start()
{
    object oPC = CutsceneGetPC();

    CutsceneStart(TRUE, FALSE, WP_TAG_PC_INIT, FALSE);
    BlackScreen(oPC);
    SetupActors(oPC);
}

void next0(float fTime)
{
    object oBallista = CutsceneGetActor(PLC_TAG_BALLISTA);
    object oCaptain = CutsceneGetActor(NPC_TAG_CAPTAIN);
    object oCatapult = CutsceneGetActor(PLC_TAG_CATAPULT);
    object oPC = CutsceneGetPC();
    object oPirate1 = CutsceneGetActor(NPC_TAG_PIRATE1);
    object oPirate2 = CutsceneGetActor(NPC_TAG_PIRATE2);
    object oPirate3 = CutsceneGetActor(NPC_TAG_PIRATE3);
    object oPirate4 = CutsceneGetActor(NPC_TAG_PIRATE4);
    object oPirate16 = CutsceneGetActor(NPC_TAG_PIRATE16);
    object oSailor1 = CutsceneGetActor(NPC_TAG_SAILOR1);
    object oSailor2 = CutsceneGetActor(NPC_TAG_SAILOR2);
    object oSailor3 = CutsceneGetActor(NPC_TAG_SAILOR3);
    object oSailor4 = CutsceneGetActor(NPC_TAG_SAILOR4);
    object oSailor5 = CutsceneGetActor(NPC_TAG_SAILOR5);
    object oSailor13 = CutsceneGetActor(NPC_TAG_SAILOR13);
    object oSailor14 = CutsceneGetActor(NPC_TAG_SAILOR14);

    //Go to first pirate ship
    if (fTime == 0.0)
    {
       BlackScreen(oPC);
      // position the camera (height, dir, dist, pitch)
       CutsceneCameraSetup(1.0, 0.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
       CreateShipFire("WP_MOBT_WALL_OF_FIRE3");
       AssignCommand(oSailor13, ActionAttack(oPirate3));
       AssignCommand(oSailor14, ActionAttack(oPirate16));
       CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        StopFade(oPC);
        AssignCommand(oCatapult, FireSmallCatapult(oSailor14, TRUE));
        AssignCommand(oCatapult, FireSmallCatapult(oPirate3, TRUE));
        CutsceneNext(4.0);
    }
    //Show arrows and bolts of fire behind the boat
    else if (fTime == 4.0)
    {
        AssignCommand(oCatapult, FireSmallCatapult(oSailor14, TRUE));
        AssignCommand(oCatapult, FireSmallCatapult(oPirate3, TRUE));
        FireArrowVolley(oPirate3, 5);
        FireArrowVolley(oPirate16, 5);

        AssignCommand(oPirate1,
            SpeakString("Ha! They couldn't hit the gates of Kur-Tharsu with an axe!"));
        AssignCommand(oPirate1, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT));
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
       AssignCommand(oPirate2, PlayVoiceChat(VOICE_CHAT_LAUGH));
       AssignCommand(oPirate2, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 2.0));
       CutsceneNext(11.0);
    }
    else if(fTime == 11.0)
    {
        CutsceneCameraSetup(1.0, 180.0, 5.0, 70.0, CAMERA_TRANSITION_TYPE_SNAP);
        CutsceneNext(15.0);
    }
    else if(fTime == 15.0)
    {
        AssignCommand(oCaptain, SpeakString("Fire!"));
        AssignCommand(oSailor1, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0));
        CutsceneNext(17.0);
    }
    //Ballista and crossbowmen kill pirates
    else if(fTime == 17.0)
    {
        AssignCommand(oSailor1, SetFacingPoint(GetPosition(oPirate1)));
        AssignCommand(oBallista, FireNavalBallista(oPirate1));
        CutsceneNext(20.0);
    }
    else if(fTime == 20.0)
    {
        AssignCommand(oSailor2, ActionAttack(oPirate2));
        DelayCommand(0.2, AssignCommand(oSailor3, ActionAttack(oPirate4)));
        DelayCommand(0.4, AssignCommand(oSailor4, ActionAttack(oPirate2)));
        DelayCommand(0.6, AssignCommand(oSailor5, ActionAttack(oPirate4)));
        CutsceneNext(22.0);
    }
    //Ensure all of the pirates on this ship are dead
    else if(fTime == 22.0)
    {
        KillPirate(oPirate1);
        KillPirate(oPirate2);
        KillPirate(oPirate4);
        CutsceneNext(23.0);
    }
    else if(fTime == 23.0)
    {
        FadeToBlack(oPC, FADE_SPEED_FASTEST);
        CutsceneNext(25.0);
    }
    else if(fTime == 25.0)
    {
        AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_MOBT_CS_PC_JUMP"))));
        CutsceneNextShot();
    }
}

//Second pirate ship boarded by navy
void next1(float fTime)
{
    object oCatapult = CutsceneGetActor(PLC_TAG_CATAPULT);
    object oPC = CutsceneGetPC();
    object oPirate5 = CutsceneGetActor(NPC_TAG_PIRATE5);
    object oPirate6 = CutsceneGetActor(NPC_TAG_PIRATE6);
    object oPirate7 = CutsceneGetActor(NPC_TAG_PIRATE7);
    object oPirate8 = CutsceneGetActor(NPC_TAG_PIRATE8);
    object oPirate9 = CutsceneGetActor(NPC_TAG_PIRATE9);
    object oPirate10 = CutsceneGetActor(NPC_TAG_PIRATE10);
    object oPirate11 = CutsceneGetActor(NPC_TAG_PIRATE11);
    object oPirate12 = CutsceneGetActor(NPC_TAG_PIRATE12);
    object oPirate13 = CutsceneGetActor(NPC_TAG_PIRATE13);
    object oPirate14 = CutsceneGetActor(NPC_TAG_PIRATE14);
    object oPirate15 = CutsceneGetActor(NPC_TAG_PIRATE15);
    object oPirate17 = CutsceneGetActor(NPC_TAG_PIRATE17);
    object oSailor6 = CutsceneGetActor(NPC_TAG_SAILOR6);
    object oSailor7 = CutsceneGetActor(NPC_TAG_SAILOR7);
    object oSailor8 = CutsceneGetActor(NPC_TAG_SAILOR8);
    object oSailor9 = CutsceneGetActor(NPC_TAG_SAILOR9);
    object oSailor10 = CutsceneGetActor(NPC_TAG_SAILOR10);
    object oSailor11 = CutsceneGetActor(NPC_TAG_SAILOR11);
    object oSailor12 = CutsceneGetActor(NPC_TAG_SAILOR12);
    object oSailor15 = CutsceneGetActor(NPC_TAG_SAILOR15);

    if(fTime == 0.0)
    {
        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 90.0, 15.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP);
        SetUpSceneTwoActors(oPC);
        CutsceneNext(2.0);
    }
    //Show sailors fighting pirates on nearby ship
    else if(fTime == 2.0)
    {
        AssignCommand(oSailor10, ActionAttack(oPirate13));
        AssignCommand(oSailor11, ActionAttack(oPirate14));
        AssignCommand(oSailor12, ActionAttack(oPirate15));
        AssignCommand(oSailor15, ActionAttack(oPirate17));
        CutsceneNext(3.0);
    }
    //Fireball strikes sails of nearby ship
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        AssignCommand(oCatapult, FireNavalCatapult(GetWaypointByTag("WP_MOBT_WALL_OF_FIRE2")));
        CutsceneNext(5.0);
    }
    //Small bolts of fire rain down on nearby ship
    else if(fTime == 5.0)
    {
        AssignCommand(oCatapult, FireSmallCatapult(oPirate13, TRUE));
        CutsceneNext(6.0);
    }
    else if(fTime == 6.0)
    {
        AssignCommand(oPirate5, SpeakString("Come on then, who wants a flayin'?"));
        AssignCommand(oCatapult, FireSmallCatapult(oPirate14, TRUE));
        CutsceneNext(7.0);
    }
    else if(fTime == 7.0)
    {
        AssignCommand(oCatapult, FireSmallCatapult(oPirate15, TRUE));
        CutsceneNext(8.0);
    }
    //Sailors cross gangplank to attack second pirate ship
    else if (fTime == 8.0)
    {
        AssignCommand(oPirate5, ActionAttack(oSailor6));
        AssignCommand(oSailor6, ActionAttack(oPirate5));
        CutsceneNext(10.0);
    }
    else if(fTime == 10.0)
    {
        FireArrowVolley(oSailor6, 3);
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
         CutsceneCameraSetup(-1.0, 0.0, 5.0, 80.0, CAMERA_TRANSITION_TYPE_FAST);
         AssignCommand(oSailor6,
            ActionMoveToObject(GetWaypointByTag("WP_MOBT_CS_NAVY_BOARD"), TRUE));
          AssignCommand(oSailor6,
            ActionMoveToObject(GetWaypointByTag("WP_MOBT_CS_NAVY6_MOVE"), TRUE));
         AssignCommand(oSailor6, ActionAttack(oPirate8));
         AssignCommand(oSailor7,
            ActionMoveToObject(GetWaypointByTag("WP_MOBT_CS_NAVY_BOARD"), TRUE));
         AssignCommand(oSailor7,
            ActionMoveToObject(GetWaypointByTag("WP_MOBT_CS_NAVY7_MOVE"), TRUE));
         AssignCommand(oSailor7, ActionAttack(oPirate7));
         AssignCommand(oSailor8,
            ActionMoveToObject(GetWaypointByTag("WP_MOBT_CS_NAVY_BOARD"), TRUE));
         AssignCommand(oSailor8,
            ActionMoveToObject(GetWaypointByTag("WP_MOBT_CS_NAVY8_MOVE"), TRUE));
         AssignCommand(oSailor8, ActionAttack(oPirate6));

         FireArrowVolley(oSailor6, 3);
         FireArrowVolley(oSailor7, 3);
         FireArrowVolley(oSailor8, 3);
         CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        FireArrowVolley(oSailor6, 3);
        FireArrowVolley(oSailor7, 3);
        FireArrowVolley(oSailor8, 3);

        AssignCommand(oSailor9,
            ActionMoveToObject(GetWaypointByTag("WP_MOBT_CS_NAVY_BOARD"), TRUE));
        AssignCommand(oCatapult, FireSmallCatapult(oSailor9));
        AssignCommand(oCatapult, FireNavalCatapult(oPirate11));
        AssignCommand(oPirate12,
            ActionMoveToObject(GetWaypointByTag("WP_MOBT_CS_NAVY_BOARD"), TRUE));
        AssignCommand(oPirate12, ActionAttack(oSailor6));
        CutsceneNext(17.0);
    }
    //Kill some of the pirates with bolts from nearby ship
    else if (fTime == 17.0)
    {
         KillPirate(oPirate9);
         KillPirate(oPirate11);
         CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        KillPirate(oPirate10);
        CreateShipFire("WP_MOBT_WALL_OF_FIRE");
        CutsceneNext(24.0);
    }
    else if (fTime == 24.0)
    {
        BlackScreen(oPC);
        CutsceneNextShot();
    }
}

//Converse with Kramer
void next2(float fTime)
{
    object oKramer = CutsceneGetActor(NPC_TAG_KRAMER);
    object oMessenger = CutsceneGetActor(NPC_TAG_MESSENGER);
    object oPC = CutsceneGetPC();

    if (fTime == 0.0)
    {
        //Make PC visible for Kramer dialog
        RemoveAssociateEffects(oPC);

        // position the camera (height, dir, dist, pitch)
        CutsceneCameraSetup(-1.0, 0.0, 15.0, 40.0, CAMERA_TRANSITION_TYPE_SNAP);

        AssignCommand(oPC,
            JumpToLocation(GetLocation(GetWaypointByTag("WP_MOBT_CS_PC_KRAMER"))));
        CutsceneNext(3.0);
    }
    //Dialog with Kramer
    else if (fTime == 3.0)
    {
        AssignCommand(oMessenger, ActionForceMoveToObject(oKramer, TRUE, 1.0, 2.0));
        FadeFromBlack(oPC, FADE_SPEED_FASTEST);
        //CutsceneNextShot called from Kramer dialog
        AssignCommand(oKramer, ActionStartConversation(oPC, "", FALSE, FALSE));
    }
}

// just end the scene
void next3(float fTime)
{
    if (fTime == 0.0)
    {
        CutsceneEnd();
    }
}

//Clear any dialog and ensure PC is on Kramer's ship
void abort()
{
    object oPC = CutsceneGetPC();

     AssignCommand(oPC,
        JumpToLocation(GetLocation(GetWaypointByTag("WP_MOBT_CS_PC_KRAMER"))));
     AssignCommand(oPC, ActionStartConversation(oPC, "invalid_dialog"));
}

void end()
{
    object oPC = CutsceneGetPC();

    AssignCommand(oPC, SetCameraFacing(0.0, 15.0, 40.0));
    AssignCommand(oPC, StoreCameraFacing());

    DestroyPirates();
    PlotLevelSet(NPC_TAG_KRAMER, 1);
    AddJournalQuestEntry("ThePirateKingsBlockade", 30, oPC);
    AssignCommand(oPC, RestoreCameraFacing());
}

void main()
{
    int nShot = CutsceneGetShot();
    float fTime = CutsceneGetTime();
    int nEvent = CutsceneGetEvent();

    if (nEvent == CUTSCENE_EVENT_START)
    {
        start();
        CutsceneNext(0.0);
    }
    else if (nEvent == CUTSCENE_EVENT_SHOT ||
             nEvent == CUTSCENE_EVENT_NEXT)
    {
        if (nShot == 0) next0(fTime);
        if (nShot == 1) next1(fTime);
        if (nShot == 2) next2(fTime);
        if (nShot == 3) next3(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        abort();
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
