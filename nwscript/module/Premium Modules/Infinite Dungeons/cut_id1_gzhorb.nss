//::///////////////////////////////////////////////
//:: cut_id1_gzhorb
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gzhorb boss battle intro cutscene.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 6, 2006
//:://////////////////////////////////////////////
#include "_inc_cutscene"

// CONSTANTS
//////////////

const int MUSIC_SCENE = TRACK_FORESTDAY2;
const int MUSIC_BATTLE = 76; // ID music


const string WP_CHASM = "ID1_STATIC_WP_CHASM_4";
const string WP_SUMMON = "ID1_STATIC_WP_CS_SUMMON";
const string WP_NPC1_1 = "ID1_STATIC_WP_CS_NPC1_1";
const string WP_NPC2_1 = "ID1_STATIC_WP_CS_NPC2_1";
const string WP_NPC1_2 = "ID1_STATIC_WP_CS_NPC1_2";
const string WP_NPC2_2 = "ID1_STATIC_WP_CS_NPC2_2";
const string WP_NPC1_3 = "ID1_STATIC_WP_CS_NPC1_3";
const string WP_NPC2_3 = "ID1_STATIC_WP_CS_NPC2_3";
const string WP_BEHOLDER_1 = "ID1_STATIC_WP_CS_CRE_1";
const string WP_GZHORB_SPAWN = "ID1_STATIC_WP_CS_CRE_2";
const string WP_BOULDER = "ID1_STATIC_WP_WALL_ROOM_4_2";

// tag and resrefs are the same for these guys
const string TAG_NPC1 = "id1_cs_gzh_npc1";
const string TAG_NPC2 = "id1_cs_gzh_npc2";
const string TAG_GZHORB = "id1_cs_gzh_gzhrb";
const string TAG_BEHOLDER = "id1_cs_gzh_behld";
const string WALL_RESREF = "id1_gzboulder";
const string BOULDER_RESREF = "plc_boulder";
const string STONES_RESREF = "plc_stones";
const string TAG_AUDIO_ROCK1 = "ID1_STATIC_gzh_rock1";
const string TAG_AUDIO_ROCK2 = "ID1_STATIC_gzh_rock2";

void CreateRock(string sResRef, location lLoc, int nCutNumber);
int NotSoRandom(int nMaxInteger, int nNewSeed = 0);

void main()
{
    int nCutNumber = GetLocalInt(OBJECT_SELF, "cs_last_cut_number");
    float fDelay, fPreCaveInDelay;
    // seed "random" routine
    NotSoRandom(1, 44);

    // Object setup

    // waypoints
    object oWP_Chasm = GetObjectByTagInArea(WP_CHASM);
    object oWP_Summon = GetObjectByTagInArea(WP_SUMMON);
    object oWP_NPC1_1 = GetObjectByTagInArea(WP_NPC1_1);
    object oWP_NPC2_1 = GetObjectByTagInArea(WP_NPC2_1);
    object oWP_NPC1_2 = GetObjectByTagInArea(WP_NPC1_2);
    object oWP_NPC2_2 = GetObjectByTagInArea(WP_NPC2_2);
    object oWP_NPC1_3 = GetObjectByTagInArea(WP_NPC1_3);
    object oWP_NPC2_3 = GetObjectByTagInArea(WP_NPC2_3);
    object oWP_Beholder_1 = GetObjectByTagInArea(WP_BEHOLDER_1);
    object oWP_Boulder = GetObjectByTagInArea(WP_BOULDER);
    object oWP_Gzhorb_Spawn = GetObjectByTagInArea(WP_GZHORB_SPAWN);

    // creatures
    object oCre_NPC1 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NPC1, GetLocation(oWP_NPC1_1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectModifyAttacks(2), oCre_NPC1);
    object oCre_NPC2 = CreateObject(OBJECT_TYPE_CREATURE, TAG_NPC2, GetLocation(oWP_NPC2_1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectModifyAttacks(2), oCre_NPC2);
    object oCre_Beholder = CreateObject(OBJECT_TYPE_CREATURE, TAG_BEHOLDER, GetLocation(oWP_Beholder_1));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectModifyAttacks(2), oCre_Beholder);
    object oCre_Gzhorb = CreateObject(OBJECT_TYPE_CREATURE, TAG_GZHORB, GetLocation(oWP_Gzhorb_Spawn));

    // placeables
    object oPla_Boulder = CreateObject(OBJECT_TYPE_PLACEABLE, WALL_RESREF, GetLocation(oWP_Boulder));

    // sounds
    object oAud_Rock1 = GetObjectByTagInArea(TAG_AUDIO_ROCK1);
    object oAud_Rock2 = GetObjectByTagInArea(TAG_AUDIO_ROCK2);

    //==========================================================================

    // set music (both day & night, just to be sure)
    cs_MusicBackgroundChangeDay(0.0, MUSIC_SCENE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_SCENE);

    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);

    // initial camera
    cs_CameraUseCameraWaypoint(1.0, 1);


    // set NPC's in motion before fading in
    // other guy fighting beholder
    cs_ActionAttack(0.0, oCre_NPC2, oCre_Beholder, FALSE);
    // one guy hitting rock
    cs_ActionAttack(0.0, oCre_NPC1, oPla_Boulder, FALSE);

    // fade-in
    cs_CameraDoFade(0.6, CS_FADE_TYPE_FROM_BLACK, FADE_SPEED_FAST);

    // beholder fighting other guy back
    cs_ActionAttack(1.0, oCre_Beholder, oCre_NPC2, FALSE);

    // beholder dies
    cs_ApplyEffectToObject(2.5, DURATION_TYPE_INSTANT, EffectDeath(FALSE, FALSE), oCre_Beholder);
    cs_ClearAllActions(0.1, oCre_NPC2);

    fDelay = cs_GetDelay();
    cs_SetDelayType(CS_DELAY_TYPE_TOTAL);
    // NPC2 is immobilized at the start, is released as he kills beholder
    cs_ApplyEffectToObject(0.5, DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oCre_NPC2, fDelay - 0.7);
    // beholder also immobilized, never released cuz he dies
    cs_ApplyEffectToObject(0.5, DURATION_TYPE_PERMANENT, EffectCutsceneImmobilize(), oCre_Beholder);
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);
    cs_ResetDelay(-1.0, fDelay);

    cs_CameraUseCameraWaypoint(0.1, 3);

    // guy moves towards tunnel
    cs_ActionMoveToObject(0.2, oCre_NPC2, oWP_NPC2_3, FALSE, 0.2);
    cs_ActionSetFacing(0.1, oCre_NPC2, GetFacing(oWP_NPC2_3));

    // rock destroyed
    cs_ApplyEffectToObject(2.2, DURATION_TYPE_INSTANT, EffectDamage(1000), oPla_Boulder);
    cs_ClearAllActions(0.1, oCre_NPC1);

    fDelay = cs_GetDelay();
    cs_SetDelayType(CS_DELAY_TYPE_TOTAL);
    // NPC1 is immobilized at the start, is released as he destroys rock
    cs_ApplyEffectToObject(0.5, DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oCre_NPC1, fDelay - 0.7);
    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);
    cs_ResetDelay(-1.0, fDelay);

    // other guy moves towards tunnel
    cs_ActionMoveToObject(0.4, oCre_NPC1, oWP_NPC1_3, FALSE, 0.2);

    fPreCaveInDelay = cs_GetDelay();
    cs_SetDelayType(CS_DELAY_TYPE_TOTAL);

// CaveIn

    fDelay = fPreCaveInDelay + 1.0;
    // Based on the location of the hole drop some rubble.
    object oArea = GetArea(oWP_Chasm);
    vector vPos1 = GetPosition(oWP_Chasm);
    effect eVFX = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
    //int nRand = Random(8) + 8;

    location lLoc;
    vector vPos2;
    float fX, fY, fZ = 0.0;
    int i, nLevel;
    int nPosNeg = 0;

    // Scatter some falling rock animations around the area.
    //for (i = 0; i < nRand; ++i)
    for (i = 0; i < 10; ++i)
    {
        // /*Randomly*/ determine a positive/negative multiplier for the scew.
        nPosNeg ++;
        if(nPosNeg > 4) nPosNeg = 1;
        switch(nPosNeg)
        {
            case 1: fX = 1.0; fY = 1.0; break;
            case 2: fX = -1.0; fY = 1.0; break;
            case 3: fX = 1.0; fY = -1.0; break;
            case 4: fX = -1.0; fY = -1.0; break;
        }

        // Scew the position by 3-7 for each drop.
        //fX = vPos1.x + fX * (IntToFloat(Random(5)) + 3.0);
        //fY = vPos1.y + fY * (IntToFloat(Random(5)) + 3.0);
        fX = vPos1.x + fX * (IntToFloat(NotSoRandom(5)) + 3.0);
        fY = vPos1.y + fY * (IntToFloat(NotSoRandom(5)) + 3.0);

        vPos2 = Vector(fX, fY, 0.0);
        lLoc = Location(oArea, vPos2, 0.0);

        //DelayCommand(fDelay,
        //    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc));
        cs_ApplyEffectAtLocation(fDelay, DURATION_TYPE_INSTANT, eVFX, lLoc);

        // Drop some more rock nearer the center of the hole.
        //fX = vPos1.x + fX * IntToFloat(Random(4));
        //fY = vPos1.y + fY * IntToFloat(Random(4));
        fX = vPos1.x + fX * IntToFloat(NotSoRandom(4));
        fY = vPos1.y + fY * IntToFloat(NotSoRandom(4));

        vPos2 = Vector(fX, fY, 0.0);
        lLoc = Location(oArea, vPos2, 0.0);

        //DelayCommand(fDelay,
        //    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc));
        cs_ApplyEffectAtLocation(fDelay, DURATION_TYPE_INSTANT, eVFX, lLoc);

        fDelay += 0.5;
    } // end for


// FillHoleVFX

    fDelay = fPreCaveInDelay + 1.0;

    // Fill the hole with falling rock animations.
    //int nInit, nBound, i;
    int nInit, nBound;
    //float fX, fY;
    //vector vPos1, vPos2;
    //location lLoc;
    //object oArea;

    fZ = 0.0;

    eVFX = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);

    oArea = GetArea(oWP_Chasm);
    vPos1 = GetPosition(oWP_Chasm);

    // The hole will be filled boulder placeables of varying z values.
    for (i = -3; i < 3; ++i)
    {
        //fY = vPos1.y + i + (IntToFloat(Random(50) + 1) / 100.0);
        fY = vPos1.y + i + (IntToFloat(NotSoRandom(50) + 1) / 100.0);

        // In order to create a vaguely daimond shape the bounds of the inner
        // loop are based on itereation of the outer loop.
        if (i == -3 || i == 3)
        {
            nInit = -1;
            nBound = 1;
        }
        else if (i == -2 || i == 2)
        {
            nInit = -2;
            nBound = 2;
        }
        else
        {
            nInit = -3;
            nBound = 3;
        }

        while (nInit < nBound)
        {
            //fX = vPos1.x + nInit + (IntToFloat(Random(50) + 1) / 100.0);
            fX = vPos1.x + nInit + (IntToFloat(NotSoRandom(50) + 1) / 100.0);

            vPos2 = Vector(fX, fY, fZ);
            //lLoc = Location(oArea, vPos2, IntToFloat(Random(360)));
            lLoc = Location(oArea, vPos2, IntToFloat(NotSoRandom(360)));

            //DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc));
            cs_ApplyEffectAtLocation(fDelay, DURATION_TYPE_INSTANT, eVFX, lLoc);

            fDelay += 0.2;
            nInit++;
        } //end while
    } // end for

// CreateCaveInPlaceables

    fDelay = fPreCaveInDelay + 4.0;

    // Fill the hole with boulders and drop some boulders in the area.
    //int nInit, nBound, i;
    //float fX, fY, fZ;
    //vector vPos1, vPos2;
    //location lLoc;
    //object oArea;
    object oObject;

    oArea = GetArea(oWP_Chasm);
    vPos1 = GetPosition(oWP_Chasm);

    // The hole will be filled boulder placeables of varying z values.
    for (i = -3; i < 3; ++i)
    {
        //fY = vPos1.y + i + (IntToFloat(Random(50) + 1) / 100.0);
        fY = vPos1.y + i + (IntToFloat(NotSoRandom(50) + 1) / 100.0);

        // In order to create a vaguely daimond shape the bounds of the inner
        // loop are based on itereation of the outer loop.
        if (i == -3 || i == 3)
        {
            nInit = -1;
            nBound = 1;
        }
        else if (i == -2 || i == 2)
        {
            nInit = -2;
            nBound = 2;
        }
        else
        {
            nInit = -3;
            nBound = 3;
        }

        while (nInit < nBound)
        {
            //fX = vPos1.x + nInit + (IntToFloat(Random(50) + 1) / 100.0);
            //fZ = 0.0 - (IntToFloat(Random(200) + 1) / 100);
            fX = vPos1.x + nInit + (IntToFloat(NotSoRandom(50) + 1) / 100.0);
            fZ = 0.0 - (IntToFloat(NotSoRandom(200) + 1) / 100);

            vPos2 = Vector(fX, fY, fZ);
            //lLoc = Location(oArea, vPos2, IntToFloat(Random(360)));
            lLoc = Location(oArea, vPos2, IntToFloat(NotSoRandom(360)));

            DelayCommand(fDelay, CreateRock(BOULDER_RESREF, lLoc, nCutNumber));

            nInit++;
        } //end while
    } // end for

    // Some scattered rock placeables should show up along with the main cave in
    //nRand = Random(3) + 3;

    //for (i = 0; i < nRand; ++i)
    for (i = 0; i < 3; ++i)
    {
        // Randomly determine a positive/negative multiplier for the scew.
        if (NotSoRandom(10) < 4)
        {
            fX = -1.0;
        }
        else
        {
            fX = 1.0;
        }

        if (NotSoRandom(10) < 4)
        {
            fY = -1.0;
        }
        else
        {
            fY = 1.0;
        }

        // Scew the position by 3-7 for each rock.
        fX = vPos1.x + fX * (IntToFloat(NotSoRandom(5)) + 3.0);
        fY = vPos1.y + fY * (IntToFloat(NotSoRandom(5)) + 3.0);

        vPos2 = Vector(fX, fY, 0.0);
        lLoc = Location(oArea, vPos2, 0.0);

        DelayCommand(fDelay, CreateRock(STONES_RESREF, lLoc, nCutNumber));
    } // end for

////


    // Gzhorb disappears right away, reappears at end of effect
    cs_ApplyEffectToObject(1.2, DURATION_TYPE_TEMPORARY, EffectDisappearAppear(GetLocation(oWP_Summon), 2), oCre_Gzhorb, fPreCaveInDelay + 3.8);


    cs_SetDelayType(CS_DELAY_TYPE_INCREMENTED);
    cs_ResetDelay(-1.0, fPreCaveInDelay + 1.7);

    // rock sound 1
    cs_SoundObjectPlay(0.0, oAud_Rock1);

    // pre-run-away-from-rocks camera
    cs_CameraUseCameraWaypoint(0.0, 4);

    // guys run to next room
    cs_ActionMoveToObject(1.0, oCre_NPC2, oWP_NPC2_2, TRUE);
    cs_ActionMoveToObject(0.4, oCre_NPC1, oWP_NPC1_2, TRUE);

    // rock sound 2
    cs_SoundObjectPlay(0.0, oAud_Rock2);

    cs_CameraUseCameraWaypoint(2.0, 2);

    // change music
    cs_MusicBackgroundChangeDay(1.5, MUSIC_BATTLE);
    cs_MusicBackgroundChangeNight(0.0, MUSIC_BATTLE);

    // guys see Gzhorb, turn around and try to run away
    cs_PlayAnimation(1.8, oCre_NPC2, ANIMATION_FIREFORGET_HEAD_TURN_LEFT);
    cs_PlayAnimation(0.2, oCre_NPC1, ANIMATION_FIREFORGET_HEAD_TURN_RIGHT);

    // Gzhorb sound
    cs_PlayVoiceChat(0.0, oCre_Gzhorb, VOICE_CHAT_BATTLECRY2);

    cs_ClearAllActions(0.3, oCre_NPC1);
    cs_ClearAllActions(0.0, oCre_NPC2);
    cs_ActionMoveToObject(0.1, oCre_NPC1, oWP_NPC1_3, TRUE);
    cs_ActionMoveToObject(0.0, oCre_NPC2, oWP_NPC2_3, TRUE);

    // Gzhorb attack
    cs_ClearAllActions(0.7, oCre_Gzhorb);
    cs_ActionCastSpellAtObject(0.1, oCre_Gzhorb, 776, oCre_NPC1, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
    cs_ActionCastSpellAtObject(1.4, oCre_Gzhorb, 787, oCre_NPC2, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);

    // Gzhorb sound, and disappears just before fadeout
    cs_PlayVoiceChat(2.0, oCre_Gzhorb, VOICE_CHAT_ATTACK);
    cs_ApplyEffectToObject(1.0, DURATION_TYPE_INSTANT, EffectDisappear(2), oCre_Gzhorb);

    // fade-out
    cs_CameraDoFade(0.6, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // clean-up
    cs_DestroyObject(1.5, oCre_NPC1);
    cs_DestroyObject(0.0, oCre_NPC2);
    cs_DestroyObject(0.0, oCre_Beholder);
    cs_DestroyObject(0.0, oCre_Gzhorb);
    cs_DestroyObject(0.0, oPla_Boulder);

    cs_SoundObjectStop(0.0, oAud_Rock1);
    cs_SoundObjectStop(0.0, oAud_Rock2);

    cs_EndCutscene(0.5);
}

void CreateRock(string sResRef, location lLoc, int nCutNumber)
{
    if(csm_CutsceneAborted(nCutNumber, OBJECT_SELF)) return;

    CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc, FALSE, "cs_to_delete");
}

// Yes, this isn't even close to being a real random routine - but it's
// "random" enough to fit my needs here. I needed a random routine I could
// seed, so the results would be predictable (and poor results could be changed
// simply by changing the seed).
// Note: cut_id1_narr02.nss has a better random routine. This one was working
// well enough for this scene, so I didn't feel the need to use the other
// one here.
int NotSoRandom(int nMaxInteger, int nNewSeed = 0)
{
    int nSeed;

    if (nNewSeed > 0) nSeed = nNewSeed;
    else nSeed = GetLocalInt(OBJECT_SELF, "NotSoRandomSeed");

    nSeed = nSeed + 83;
    while (nSeed > 100) nSeed -= 100;
    SetLocalInt(OBJECT_SELF, "NotSoRandomSeed", nSeed);
    return (nSeed * nMaxInteger / 100);
}
