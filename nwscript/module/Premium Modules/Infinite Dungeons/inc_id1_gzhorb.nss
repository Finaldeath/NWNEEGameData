//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_gzhorb
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the fight with G'Zhorb. Contains utility functions
    and constants relevant to the fight.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 19, 2005
//::////////////////////////////////////////////////////////////////////////////



#include "inc_id1_boss"
#include "inc_id1_creature"

// DEBUG
//  void main(){}



/*------------------------------------------------------------------------------
    CONSTANTS
------------------------------------------------------------------------------*/



// Creature ResRef constants.
const string BEHOLDER_RESREF = "id_gzrbhldr";
const string EYEBALL_RESREF = "id_gzreyeball";

// Placeable ResRef constants.
const string BOULDER_RESREF = "plc_boulder";
const string STONES_RESREF = "plc_stones";
const string WALL_RESREF = "id1_gzboulder";
const string CHASM_RESREF = "id1_gzhorb_chasm";

// Placeable Tag constants.
const string HOLE_PLC_PRFX = "plc_gzhorb_0";

// Local variable names.
const string NUM_PCS = "nPCs";
const string ROOM_NUM = "nRoom";
const string HOLE_CAVE_IN_CHANCE = "nCaveIn";
const string HOLE_DESTROYED = "bDestroyed";
const string HOLE_SUMMONING = "bSummoning";
const string HOLE_GZHORB = "bGzhorb";
const string ROOMS_CAVED = "nRoomsCavedIn";
const string BEHOLDERS_SUMMONED = "nBeholdersSummoned";
const string GZHORB_HITS = "nHits";

// Waypoint tag constants.
const string WALL_WP_PRFX = "ID1_STATIC_WP_WALL_ROOM_";
const string CHASM_WP_PRFX = "ID1_STATIC_WP_CHASM_";
const string SUMMON_WAYPOINT_TAG = "ID1_STATIC_WP_SUMMON";


/*------------------------------------------------------------------------------
    FUNCTION TEMPLATES
------------------------------------------------------------------------------*/



// Name: Setup
//
// Defined in: inc_id1_gzhorb
//
// Setup function to spawn in temporary placeables and creatures.
//
// Parameters:
// NONE
//
// Return:
// NONE
void Setup();

// Name: Create Gzhorb
//
// Defined in: inc_id1_gzhorb
//
// Creates Gzhorb and initializes him, providing him with level up variables etc
//
// Parameters:
// lLoc - The location at which Gzhorb should be created.
//
// Return:
// A reference to the newly created Gzhorb.
object CreateGzhorb(location lLoc);

// Name: Jump Rooms
//
// Defined in: inc_id1_gzhorb
//
// This function causes G'Zhorb to jump to a different room using the disappear
// appear animation to make it seem as though he is traveling through holes in
// the ground.
//
// Parameters:
// NONE
//
// Return:
// NONE
void GZ_JumpRooms();

// Name: Run Cave In
//
// Defined in: inc_id1_gzhorb
//
// Manages a cave in event by calling the CaveIn and CreateCaveInPlaceables etc.
// functions. Designed as a wrapper function to be assigned to the invisible
// object representing the hole to avoid the object running the event going
// invalid.
//
// Parameters:
// oHole - The hole in the center of the room which is about to experience the
//         cave in.
//
// Return:
// NONE
void RunCaveIn(object oHole);

// Name: CaveIn
//
// Defined in: inc_id1_gzhorb
//
// Causes a cave-in in the area around oHole. A cave in consists of some screen
// shaking, rubble falling effects and the appearance of some placeables to
// block off the hole.
//
// Parameters:
// oHole - The hole which is going to be blocked off by the cave-in.
// bDamage - If this argument is TRUE nearby players will take some damage from
//           falling debris.
//
// Return:
// NONE
void CaveIn(object oHole, int bDamage = TRUE);

// Name: Create Cave In Placeables
//
// Defined in: inc_id1_gzhorb
//
// Creates the rubble, representative of a cave in, in and around a given hole.
//
// Parameters:
// oHole - The hole which is being blocked off by the cave-in.
//
// Return:
// NONE
void CreateCaveInPlaceables(object oHole);

// Name: Summon Beholder
//
// Defined in: inc_id1_gzhorb
//
// Summons a beholder to a given hole and sends it after a random player.
//
// Parameters:
// oHole - The hole from which the beholder should start it's journey to eat PCs
//
// Return:
// NONE
void SummonBeholder(object oHole);

// Name: Create Boulders
//
// Defined in: inc_id1_gzhorb
//
// Cycles through each of the 8 rooms in Gzhorb's area and creates four boulder
// placeables on the waypoints there in representing support structures in
// the walls.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateBoulders();

// Name: CreateChasms
//
// Defined in: inc_id1_gzhorb
//
// Creates 8 invisible object placeables in the center of the chasms through out
// the area. These objects are used by gzhorb as a reference point to jump to
// and track information about the state of the room they are in, i.e. caved in,
// about to cave in etc.
//
// Parameters:
// NONE
//
// Return:
// NONE
void CreateChasms();

// Name: Get Random Free Hole
//
// Defined in: inc_id1_gzhorb
//
// Retrieves the number of a random free hole. That is a random hole that is
// not currently summoning beholders.
//
// Parameters:
// NONE
//
// Return:
// The number of the hole or -1 if no free hole is available.
int GetRandomFreeHole();

// Name: Apply Cave In Damage
//
// Defined in: inc_id1_gzhorb
//
// Applys some damage from falling rocks during a cave in.
//
// Parameters:
// lLoc - The location of the hole that is caving in. Used to determine which
//        creatures will take damage (i.e. those creatures near this location).
// nLevel - The party level; used in determining the amount of damage done.
//
// Return:
// NONE
void ApplyCaveInDamage(location lLoc, int nLevel);

// Name: Fill Hole VFX
//
// Defined in: inc_id1_gzhorb
//
// Creates a visual effect emulating a bunch of rocks falling into oHole and
// thereby filling it.
//
// Parameters:
// oHole - The hole to be filled.
//
// Return:
// NONE
void FillHoleVFX(object oHole);


/*------------------------------------------------------------------------------
    FUNCTION IMPLEMENTATIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: Setup
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 30, 2005
//::////////////////////////////////////////////////////////////////////////////
void Setup()
{
    int nLevel;

    // get dungeon
    object oDungeon = GetCurrentDungeon();

    // Set the boss level as having been activated.
    SetLocalInt(oDungeon, BOSS_ACTIVATED, TRUE);

    // check to see if boss area has been setup already
    if (GetLocalInt(oDungeon, BOSS_GENERATED) == FALSE)
    {
          DebugMessage("  Area has never been activated before.");

        // boss level stats have been determined
        SetLocalInt(oDungeon, BOSS_GENERATED, TRUE);

        int nPartyLevel;
        nPartyLevel = GetPartyLevel(GetFirstPC(), TRUE);
        nPartyLevel += 2;
        DebugMessage("  Party level is " + IntToString(nPartyLevel));

        int nPartySize = GetPartySize(GetFirstPC(), TRUE);
        DebugMessage("  Party size is " + IntToString(nPartySize));

        nPartyLevel = GetPartyLevelSize(nPartyLevel, nPartySize);

        int nDifficulty = GetModuleFlagValue(ID1_FLAG_ENCOUNTER_DIFFICULTY);
        DebugMessage("  Encounter difficulty adjustment is " + IntToString(nDifficulty));
        nPartyLevel += nDifficulty;
        DebugMessage("    Party level adjusted for difficulty is " + IntToString(nPartyLevel));

        // level of all PCs in the dungeon has been determined
        nLevel = nPartyLevel;

        // record the boss level
        SetLocalInt(oDungeon, "nBossLevel", nLevel);
    }
    else
    {
        DebugMessage("  Area has been activated before.");

        // Boss level should already be recorded.
        nLevel = GetLocalInt(oDungeon, "nBossLevel");
    }

    DebugMessage("  Boss level is " + IntToString(nLevel));

    int bQuestCompleted = GetLocalInt(GetModule(), "bGzhorbQuestCompleted");
    int bHostile = GetLocalInt(GetModule(), "bGzhorbHostile");
    int bQuestActive = GetLocalInt(GetModule(), "bGzhorbQuestActive");
    int bSurrender = GetLocalInt(GetModule(), "bGzhorbSurrender");
    int bSurrender2 = GetLocalInt(GetModule(), "bGzhorbSurrender2");

    DebugMessage("  Gzhorb Completed = " + IntToString(bQuestCompleted) + ", Hostile = " + IntToString(bHostile) + ", Active = " + IntToString(bQuestActive) + ", Surrender = " + IntToString(bSurrender) + ", Surrender2 = " + IntToString(bSurrender2));

    // default variables
    SetLocalInt(OBJECT_SELF, ROOMS_CAVED, 0);

    // create boulder placeables
    CreateBoulders();

    // create chasm objects
    CreateChasms();

    // Create G'Zhorb at a random hole.
    int nHole = GetRandomFreeHole();
    object oHole = DB_GetObjectByTag(HOLE_PLC_PRFX + IntToString(nHole));

    int bDead = GetLocalInt(oDungeon, "bBossDead");
    DebugMessage("bDead is " + IntToString(bDead));
    if (bDead == TRUE)
    {
        return;
    }

    // If the plot with G'Zhorb has not been completed spawn him in.
    if (!bQuestCompleted && !bDead)
    {
        object oGzhorb = CreateGzhorb(GetLocation(oHole));

        SetLocalInt(oGzhorb, ROOM_NUM, nHole);

        if (bHostile == TRUE)
        {
            SetImmortal(oGzhorb, FALSE);
        }
    }

    // If G'Zhorb has previously surrendered he should not be hostile.
    if ((bSurrender || bSurrender2) && !bHostile)
    {
        // change to neutral faction
        ChangeFaction(GetObjectByTag(GZHORB_TAG), GetObjectByTag("DungeonAngel"));

        // If quest completed or still active spawn in the teleporter.
        if (bQuestCompleted || bQuestActive)
        {
            // enable and spawn the boss lair teleporter
            object oTeleporter = GetNearestObjectByTag("ID1_STATIC_BOSS_LAIR_TELEPORTER", GetFirstObjectInArea(OBJECT_SELF));

            SetMapPinEnabled(oTeleporter, TRUE);

            DB_CreateObject(OBJECT_TYPE_PLACEABLE, "id1_bosstel", GetLocation(oTeleporter));

            DebugMessage("Teleporter is in area " + GetTag(GetArea(oTeleporter)));
        }
    }
    else // Otherwise set up the fight.
    {
        // start summoning beholders
        SetLocalInt(oHole, HOLE_SUMMONING, TRUE);
        AssignCommand(oHole, SummonBeholder(oHole));

        // get random free hole
        nHole = GetRandomFreeHole();
        oHole = DB_GetObjectByTag(HOLE_PLC_PRFX + IntToString(nHole));

        // start summoning beholders
        SetLocalInt(oHole, HOLE_SUMMONING, TRUE);
        AssignCommand(oHole, SummonBeholder(oHole));

        // Lock the area for the duration of the fight.
        //LockArea();
    }

    // Generate some loot for the boss should the player choose to kill them.
    object oBoss = DB_GetObjectByTag(GZHORB_TAG);

    BossGenerateLoot(oBoss);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateGzhorb
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Jan 30, 2006
//::////////////////////////////////////////////////////////////////////////////
object CreateGzhorb(location lLoc)
{
    object oDungeon = GetCurrentDungeon();
    int nEncounter = GetLocalInt(oDungeon, "nBossLevel");
    object oGzhorb = DB_CreateObject(OBJECT_TYPE_CREATURE, GZHORB_TAG, lLoc);

    SetLocalInt(oGzhorb, "nCreatureType", 3);
    SetLocalInt(oGzhorb, "nCR", nEncounter + 4);
    SetLocalInt(oGzhorb, "nBaseHD", 1);
    SetLocalInt(oGzhorb, "nClass", -1);

    return oGzhorb;
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateBoulders
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 03, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateBoulders()
{
    object oBoulder, oWaypoint;
    int nRoom, nBoulder;
    location lLoc;

    // For each room in Gzhorb's area.
    for (nRoom = 1; nRoom <= 8; ++nRoom)
    {
        // Create 4 "Wall Boulders".
        for (nBoulder = 1; nBoulder <= 4; ++nBoulder)
        {
            oWaypoint = DB_GetWaypointByTag(WALL_WP_PRFX + IntToString(nRoom) + "_" + IntToString(nBoulder));
            lLoc = GetLocation(oWaypoint);
            oBoulder = DB_CreateObject(OBJECT_TYPE_PLACEABLE, WALL_RESREF, lLoc);
            SetLocalInt(oBoulder, ROOM_NUM, nRoom);
        }
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateChasms
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 03, 2006
//::////////////////////////////////////////////////////////////////////////////
void CreateChasms()
{
    object oWaypoint;
    location lLoc;
    int i;

    // Create the 8 chasm placeables.
    for (i = 0; i <= 8; ++i)
    {
        oWaypoint = DB_GetWaypointByTag(CHASM_WP_PRFX + IntToString(i));

        lLoc = GetLocation(oWaypoint);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, CHASM_RESREF, lLoc, FALSE, HOLE_PLC_PRFX + IntToString(i));
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: GetRandomFreeHole
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Feb 03, 2006
//::////////////////////////////////////////////////////////////////////////////
int GetRandomFreeHole()
{
    // Randomly determine one of the 8 holes to start summoning.
    int nHoleNum = 8;
    int nHole = Random(nHoleNum) + 1;
    int nCount = 1;

    // Determine if the random hole is already summoning.
    object oHole = DB_GetObjectByTag(HOLE_PLC_PRFX + IntToString(nHole));
    int bSummoning = GetLocalInt(oHole, HOLE_SUMMONING);

    // Explore each of the holes in turn from the random one until either a hole
    // that isn't currently summoning is discovered or all the holes have been
    // checked.
    while (bSummoning && (nCount < nHoleNum))
    {
        nHole++;

        if (nHole > nHoleNum)
        {
            nHole = 1;
        }

        nCount++;

        oHole = DB_GetObjectByTag(HOLE_PLC_PRFX + IntToString(nHole));
        bSummoning = GetLocalInt(oHole, HOLE_SUMMONING);
    }

    // if all holes were summoning
    if (nCount >= nHoleNum)
    {
        return -1;
    }
    else
    {
        return nHole;
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: GZ_JumpRooms
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void GZ_JumpRooms()
{
    object oArea = GetArea(OBJECT_SELF);
    object oGzhorb = DB_GetObjectByTag(GZHORB_TAG);

    // If all but one of the rooms has been destroyed G'Zhorb has no where to go
    if (GetLocalInt(oArea, ROOMS_CAVED) == 7) return;

    // Determine a random hole to jump to.
    int nHole = Random(8) + 1;
    object oHole = DB_GetObjectByTag(HOLE_PLC_PRFX + IntToString(nHole));

    if (!GetIsObjectValid(oHole)) return;

    // While the hole being grabbed is one that has been destroyed or the one
    // that G'Zhorb is currently inhabiting keep searching.
    int bDestroyed = GetLocalInt(oHole, HOLE_DESTROYED);
    int nPreviousHole = GetLocalInt(oGzhorb, ROOM_NUM);

    while (bDestroyed)
    {
        nHole++;

        // Handle over-flow.
        if (nHole > 8)
        {
            nHole = 1;
        }

        if (nHole == nPreviousHole) continue;

        oHole = DB_GetObjectByTag(HOLE_PLC_PRFX + IntToString(nHole));

        // In order to avoid glitches exit the process if an invalid hole.
        if (!GetIsObjectValid(oHole))
        {
            return;
        }

        bDestroyed = GetLocalInt(oHole, HOLE_DESTROYED);
    }

    // Jump G'Zhorb over to the hole.
    location lLoc = GetLocation(oHole);
    effect eJump = EffectDisappearAppear(lLoc, 2);

    SetLocalInt(oGzhorb, ROOM_NUM, nHole);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eJump, oGzhorb, 3.0);

    // To prevent surrendering while in transition set plot.
    SetPlotFlag(oGzhorb, TRUE);
    DelayCommand(3.0, SetPlotFlag(oGzhorb, FALSE));

    // If the hole Gzhorb is moving to is already summoning set a random hole
    // to start summoning since the one being jumped from will stop and two
    // holes should always be active.
    if (GetLocalInt(oHole, HOLE_SUMMONING))
    {
        int nRand = Random(8) + 1;

        if (nRand == nHole)
        {
            nRand++;

            if (nRand > 8) nRand = 1;
        }

        oHole = DB_GetObjectByTag(HOLE_PLC_PRFX + IntToString(nRand));

    }

    SetLocalInt(oHole, HOLE_SUMMONING, TRUE);

    SummonBeholder(oHole);

    // Shut off the hole formerly inhabited by Gzhorb.
    oHole = DB_GetObjectByTag(HOLE_PLC_PRFX + IntToString(nPreviousHole));

    SetLocalInt(oHole, HOLE_SUMMONING, FALSE);
}

//::////////////////////////////////////////////////////////////////////////////
//:: RunCaveIn
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On:Sep 21, 2005
//::////////////////////////////////////////////////////////////////////////////
void RunCaveIn(object oHole)
{
    // Set the boolean indicator so that G'Zhorb no longer comes here.
    SetLocalInt(oHole, HOLE_DESTROYED, TRUE);

    // play the animation series a couple of times.
    CaveIn(oHole);

    FillHoleVFX(oHole);

    DelayCommand(3.0, CaveIn(oHole));

    // Create the rubble placeables from the cave in.
    DelayCommand(3.0, CreateCaveInPlaceables(oHole));

    // Set the indicator of number of cave ins.
    object oArea = GetArea(oHole);
    int nCaveIns = GetLocalInt(oArea, ROOMS_CAVED);

    nCaveIns++;

    SetLocalInt(oArea, ROOMS_CAVED, nCaveIns);
}

//::////////////////////////////////////////////////////////////////////////////
//:: CaveIn
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 19, 2005
//::////////////////////////////////////////////////////////////////////////////
void CaveIn(object oHole, int bDamage = TRUE)
{
    // Based on the location of the hole drop some rubble.
    object oArea = GetArea(oHole);
    vector vPos1 = GetPosition(oHole);
    effect eVFX = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
    float fDelay = 0.0;
    float fDelay2 = 0.0;
    int nRand = Random(8) + 8;

    location lLoc;
    vector vPos2;
    float fX, fY, fZ = 0.0;
    int i, nLevel;

    object oDungeon = GetCurrentDungeon();

    object oCollateral;

    // Scatter some falling rock animations around the area.
    for (i = 0; i < nRand; ++i)
    {
        // Randomly determine a positive/negative multiplier for the scew.
        if (Random(10) < 4)
        {
            fX = -1.0;
        }
        else
        {
            fX = 1.0;
        }

        if (Random(10) < 4)
        {
            fY = -1.0;
        }
        else
        {
            fY = 1.0;
        }

        // Scew the position by 3-7 for each drop.
        fX = vPos1.x + fX * (IntToFloat(Random(5)) + 3.0);
        fY = vPos1.y + fY * (IntToFloat(Random(5)) + 3.0);

        vPos2 = Vector(fX, fY, 0.0);
        lLoc = Location(oArea, vPos2, 0.0);

        DelayCommand(fDelay,
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc));

        // Drop some more rock nearer the center of the hole.
        fX = vPos1.x + fX * IntToFloat(Random(4));
        fY = vPos1.y + fY * IntToFloat(Random(4));

        vPos2 = Vector(fX, fY, 0.0);
        lLoc = Location(oArea, vPos2, 0.0);

        DelayCommand(fDelay,
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc));

        fDelay += 0.5;
    } // end for

    // Apply a random amount of damage (from falling rocks).
    if (bDamage)
    {
        nLevel = GetLocalInt(oDungeon, "nBossLevel");

        ApplyCaveInDamage(GetLocation(oHole), nLevel);
    }

    // Shake the player's screens some.
    ShakeScreen();
}

//::////////////////////////////////////////////////////////////////////////////
//:: CreateCaveInPlaceables
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 20, 2005
//::////////////////////////////////////////////////////////////////////////////
void CreateCaveInPlaceables(object oHole)
{
    // Fill the hole with boulders and drop some boulders in the area.
    int nInit, nBound, i;
    float fX, fY, fZ;
    vector vPos1, vPos2;
    location lLoc;
    object oArea;

    oArea = GetArea(oHole);
    vPos1 = GetPosition(oHole);

    // The hole will be filled boulder placeables of varying z values.
    for (i = -3; i < 3; ++i)
    {
        fY = vPos1.y + i + (IntToFloat(Random(50) + 1) / 100.0);

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
            fX = vPos1.x + nInit + (IntToFloat(Random(50) + 1) / 100.0);
            fZ = 0.0 - (IntToFloat(Random(200) + 1) / 100);

            vPos2 = Vector(fX, fY, fZ);
            lLoc = Location(oArea, vPos2, IntToFloat(Random(360)));

            DB_CreateObject(OBJECT_TYPE_PLACEABLE, BOULDER_RESREF, lLoc);

            nInit++;
        } //end while
    } // end for

    // Some scattered rock placeables should show up along with the main cave in
    int nRand = Random(3) + 3;

    for (i = 0; i < nRand; ++i)
    {
        // Randomly determine a positive/negative multiplier for the scew.
        if (Random(10) < 4)
        {
            fX = -1.0;
        }
        else
        {
            fX = 1.0;
        }

        if (Random(10) < 4)
        {
            fY = -1.0;
        }
        else
        {
            fY = 1.0;
        }

        // Scew the position by 3-7 for each rock.
        fX = vPos1.x + fX * (IntToFloat(Random(5)) + 3.0);
        fY = vPos1.y + fY * (IntToFloat(Random(5)) + 3.0);

        vPos2 = Vector(fX, fY, 0.0);
        lLoc = Location(oArea, vPos2, 0.0);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, STONES_RESREF, lLoc);
    } // end for
}

//::////////////////////////////////////////////////////////////////////////////
//:: SummonBeholder
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 21, 2005
//::////////////////////////////////////////////////////////////////////////////
void SummonBeholder(object oHole)
{
    // If the hole isn't supposed to be summoning return.
    if (GetLocalInt(oHole, HOLE_SUMMONING) == FALSE) return;


    // If Gzhorb has surrendered stop summoning.
    object oGzhorb = DB_GetObjectByTag(GZHORB_TAG);

    if (GetLocalInt(GetModule(), "bGzhorbSurrender") == TRUE) //(GetLocalInt(oGzhorb, SURRENDER_FLAG)) return;
    {
        return;
    }

    object oDungeon = GetCurrentDungeon();
    int nEnc = GetLocalInt(oDungeon, "nBossLevel");

    int nBeholders = GetLocalInt(oGzhorb, BEHOLDERS_SUMMONED);

    // Only a small chance of summoning if there are already half the party
    // level of the players or more beholders present to a max of ten.
    if (nBeholders > (nEnc/2) || nBeholders > 10)
    {
        if (Random(100) < 10)
        {
            DelayCommand(40.0, SummonBeholder(oHole));
            return;
        }
    }

    SetLocalInt(oGzhorb, BEHOLDERS_SUMMONED, nBeholders++);

    object oArea, oTarget, oBeholder, oTemp, oWP;
    location lLoc;
    float fDelay;
    int nPCs, nTarget, i;

    // Determine a random player to send the beholder after them.
    oArea = GetArea(oHole);
    nPCs = GetLocalInt(oArea, NUM_PCS);
    nTarget = Random(nPCs) + 1;

    oTarget = GetFirstPC();

    // Cycle through the players to establish a target.
    for (i = 1; i < nTarget; ++i)
    {
        oTarget = GetNextPC();
    }

    // Create the beholder and send him after the target.
    oWP = DB_GetNearestObjectByTag(SUMMON_WAYPOINT_TAG);
    lLoc = GetLocation(oWP);

    // Jan 30, 2006: Set some level up information on the beholder.
    nEnc -= 2;

    if (nEnc <= 0) nEnc = 1;

    string sResref;

    // Based on the encounter level determine what type of beholder to summon.
    if (nEnc < 9)
    {
        sResref = EYEBALL_RESREF;
    }
    else
    {
        sResref = BEHOLDER_RESREF;
    }

    oBeholder = DB_CreateObject(OBJECT_TYPE_CREATURE, BEHOLDER_RESREF, lLoc,
        TRUE, MINION_TAG);

    SetLocalInt(oBeholder, "nCreatureType", 3);
    SetLocalInt(oBeholder, "nCR", nEnc);
    SetLocalInt(oBeholder, "nBaseHD", 1);
    SetLocalInt(oBeholder, "nClass", -1);

    AssignCommand(oBeholder, ActionMoveToObject(oTarget, TRUE, 5.0));

    // Determine a callback time for the next summon based on party level.
    fDelay = IntToFloat(Random(15) + (50 - nEnc));

    // For extreme cases...
    if (fDelay < 30.0)
    {
        fDelay = 30.0;
    }

    DelayCommand(fDelay, SummonBeholder(oHole));
}

//::////////////////////////////////////////////////////////////////////////////
//:: ApplyCaveInDamage
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 06, 2006
//::////////////////////////////////////////////////////////////////////////////
void ApplyCaveInDamage(location lLoc, int nLevel)
{
    object oCollateral = GetFirstObjectInShape(SHAPE_SPHERE, 20.0, lLoc);
    float fDelay = 0.0;

    float fRand;
    int nDMG, nCount;
    effect eDMG;

    // Cycle all the objects near the hole and damage them.
    while (GetIsObjectValid(oCollateral))
    {
        nDMG = Random(nLevel) + 1;
        eDMG = EffectDamage(nDMG, DAMAGE_TYPE_BLUDGEONING);

        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oCollateral));

        nCount = 1;

        // Randomly repeat the damage a few times.
        while (Random(100) < 30 && nCount < nLevel)
        {
            fRand = (IntToFloat(Random(10)) * 0.1) + fDelay;

            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDMG, oCollateral));

            nCount++;
        }

        fDelay += 0.1;

        oCollateral = GetNextObjectInShape(SHAPE_SPHERE, 20.0, lLoc);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: FillHoleVFX
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Feb 06, 2006
//::////////////////////////////////////////////////////////////////////////////
void FillHoleVFX(object oHole)
{
    // Fill the hole with falling rock animations.
    int nInit, nBound, i;
    float fX, fY;
    vector vPos1, vPos2;
    location lLoc;
    object oArea;

    float fZ = 0.0;
    float fDelay = 0.0;

    effect eVFX = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);

    oArea = GetArea(oHole);
    vPos1 = GetPosition(oHole);

    // The hole will be filled boulder placeables of varying z values.
    for (i = -3; i < 3; ++i)
    {
        fY = vPos1.y + i + (IntToFloat(Random(50) + 1) / 100.0);

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
            fX = vPos1.x + nInit + (IntToFloat(Random(50) + 1) / 100.0);

            vPos2 = Vector(fX, fY, fZ);
            lLoc = Location(oArea, vPos2, IntToFloat(Random(360)));

            DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX, lLoc));

            fDelay += 0.2;
            nInit++;
        } //end while
    } // end for
}
