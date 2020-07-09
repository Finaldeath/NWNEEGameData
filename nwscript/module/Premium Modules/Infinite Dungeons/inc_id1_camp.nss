//::////////////////////////////////////////////////////////////////////////////
//:: inc_id1_camp
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    Main include file for the camp generation system.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 02, 2005
//::////////////////////////////////////////////////////////////////////////////


#include "inc_id1_debug"
#include "inc_puz_general"
#include "inc_id1_creature"
#include "inc_id1_utility"
#include "inc_id1_store"


// DEBUG
// void main() {}



/*------------------------------------------------------------------------------
    VARIABLE NAME CONSTANTS
------------------------------------------------------------------------------*/


// Camp generation variables.
const string NODE = "Node";
const string NODE_TYPE = "Type";
const string NODE_SUBTYPE = "SubType";
const string NODE_NPC_DEAD = "NPCDead";
const string NODE_NPC_VAR = "DeathVarName";



/*------------------------------------------------------------------------------
    NODE CONSTANTS
------------------------------------------------------------------------------*/



const int CAMP_NODE_REST = 1;
const int CAMP_NODE_STORE = 2;
const int CAMP_NODE_FORGE = 3;
const int CAMP_NODE_HIRELING = 4;
const int CAMP_NODE_MONSTER = 5;
const int CAMP_NODE_CASTER = 6;
const int CAMP_NODE_HEALER = 6;
const int CAMP_NODE_BUFFER = 7;
const int CAMP_NODE_QUEST = 8;
const int CAMP_NODE_DECOR = 9;
const int CAMP_NODE_CENTER = 10;

const int N_TYPES = 9; // Number of possible types for each node.
const int N_SUBTYPES = 24; // Number of possible subtypes for each type of node.
const int N_TOTAL_NODES = 6;
const int N_MONSTERS = 6; // Number of monsters available from a monster seller.



/*------------------------------------------------------------------------------
    PLACEABLE RESREF CONSTANTS
------------------------------------------------------------------------------*/



const string ANVIL = "id1_plc007";
const string BARREL = "id1_plc012";
const string BEDROLL = "id1_plc190";
const string BOLTS_OF_CLOTH = "id1_plc191";
const string CAMPFIRE_1 = "id1_plc044";
const string CAMPFIRE_2 = "id1_plc045";
const string CAMPFIRE_3 = "id1_plc046";
const string CHEST = "id1_plc051";
const string CUSHIONS = "id1_plc192"; //
const string CRATE_1 = "id1_plc193";
const string CRATE_2 = "id1_plc194";
const string CRATE_3 = "id1_plc195";
const string CRATE_4 = "id1_plc196";
const string FORGE = "id1_mysticforge";
const string GARBAGE = "id1_plc197";
const string HAY_BALE = "id1_plc198";
const string KEG = "id1_plc199";
const string THROW_RUG = "id1_plc200";
const string SACK_OF_FLOUR = "id1_plc201";
const string TENT_1 = "id1_plc202";
const string TENT_2 = "id1_plc203";
const string WAGON_1 = "id1_plc204";
const string WAGON_2 = "id1_plc205";
const string WAGON_3 = "id1_plc206";
const string WAGON_4 = "id1_plc207";
const string WAGON_WHEEL = "id1_plc208";
const string WATER_TROUGH = "id1_plc209";
const string WEAPON_RACK = "id1_plc210";
const string WOODPILE = "id1_plc189";

const string REST_TENT_1 = "id1_resttent01";
const string REST_TENT_2 = "id1_resttent02";



/*------------------------------------------------------------------------------
    CREATURE RESREF CONSTANTS
------------------------------------------------------------------------------*/



// All currently placeholders.
const string NPC_STORE_RESREF = "nw_shopkeep";
const string NPC_HIRELING_RESREF = "nw_shopkeep";
const string NPC_MONSTER_WRANGLER_RESREF = "nw_shopkeep";
const string NPC_QUEST_GIVER_RESREF = "nw_shopkeep";
const string NPC_HEALER_RESREF = "nw_shopkeep";
const string NPC_BUFFER_RESREF = "nw_shopkeep";

const string TYPE_1_MONSTER_RESREF = "nw_battdevour";
const string TYPE_2_MONSTER_RESREF = "nw_battdevour";
const string TYPE_3_MONSTER_RESREF = "nw_battdevour";
const string TYPE_4_MONSTER_RESREF = "nw_battdevour";
const string TYPE_5_MONSTER_RESREF = "nw_battdevour";



/*------------------------------------------------------------------------------
    FUNCTION PROTOTYPES
------------------------------------------------------------------------------*/



// Name: Get Encampment Variable Prefix
//
// Defined in: inc_id1_camp
//
// Retruns the string prefix for variables names relating to the state of the
// encampment based around oWaypoint.
//
// Parameters:
// oWaypoint - The waypoint which serves as the center for the encampment
//
// Return:
// A string prefix for variable names which define the state of the encampment
// on the global dungeon object.
string GetEncampmentVariablePrefix(object oWaypoint);

// Name: Generate Encampment
//
// Defined in: inc_id1_camp
//
// Generates a random encampment state by setting variables on the dungeon
// object. The SpawnEncampment method can then spawn the encampment using these
// variables.
//
// Parameters:
// oWaypoint - The waypoint at which the encampment will be spawned.
//
// Return:
// NONE
void GenerateEncampment(string sVariable, string sIcon);

// Name: Spawn Encampment
//
// Defined in: inc_id1_camp
//
// Spawns in an encampment around oWaypoint based on variables set on the
// Dungeon object by a call to GenerateEncampment.
//
// Parameters:
// oWaypoint - The waypoint at which the encampment will be spawned.
//
// Return:
// NONE
void SpawnEncampment(object oWaypoint);

// Name: Make Center Camp Node
//
// Defined in: inc_id1_camp
//
// Creates the center node for a campsite circle. This node normally consists of
// a campfire.
//
// Parameters:
// lLocation - The location where the node should be created.
// nSubType - The subtype of center node to be spawned.
//
// Return:
// NONE
void SpawnCenterCampNode(location lLocation, int nSubType);

// Name: Spawn Store Node
//
// Defined in: inc_id1_camp
//
// Creates a store node for a camp. This node will be the base location for a
// store-keeper NPC.
//
// Parameters:
// lLocation - The location at which the store node should be created.
// nSubType - The subtype of store node to be created; effects appearance.
//
// Return:
// NONE
void SpawnStoreNode(location lLocation, int nSubType);

// Name: Make Forge Node
//
// Defined in: inc_id1_camp
//
// Creates a forge node for a camp. This node will be the base location for a
// forge interactable.
//
// Parameters:
// lLocation - The location at which the forge should be created.
// nSubType - The subtype of forge node to be created; effects appearance.
//
// Return:
// NONE
void SpawnForgeNode(location lLocation, int nSubType, int nCharges, string sNode);

// Name: Make Rest Node
//
// Defined in: inc_id1_camp
//
// Create a rest node for a camp which contains resting mats the player will
// be able to use to rest up.
//
// Parameters:
// lLocation - The location at which the node should be created.
// nSubType - The subtype of node to be created; effects appearance.
//
// Return:
// NONE
void SpawnRestNode(location lLocation, int nSubType, object oWaypoint);

// Name: Make Perimiter Camp Node
//
// Defined in: inc_id1_camp
//
// Creates a peremiter node for a campsite circle. A node consists of any
// number of possible placeables.
//
// Parameters:
// lLocation - The location to create the node.
// bTent - If this parameter is FALSE then a tent placeable will not be used.
//
// Return:
// NONE
void SpawnPerimiterCampNode(location lLocation, int nSubType);

// Name: Spawn Monsters For Hire
//
// Defined in: inc_id1_camp
//
// Spawns in some monsters for hire, based on the subtype of the camp node.
//
// Parameters:
// lLocation - The location of the node where the monsters should be spawned.
// nSubtype - The sub-type of the node; determines monster type.
//
// Return:
// NONE
void SpawnMonstersForHire(location lLocation, int nSubType);

object SpawnCreature(string sCreature, location lLocation, object oDungeon = OBJECT_INVALID);

int GetCasterSpellsAtLevel(int nLevel);
int GetCasterSpellNumberAtLevel(int nLevel, int nSpell);
string GetSpellName(int nSpell);


/*------------------------------------------------------------------------------
    FUNCTION DEFINITIONS
------------------------------------------------------------------------------*/



//::////////////////////////////////////////////////////////////////////////////
//:: GetEncampmentVariablePrefix
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 07, 2005
//::////////////////////////////////////////////////////////////////////////////
string GetEncampmentVariablePrefix(object oWaypoint)
{
    return GetVariableNamePrefix(oWaypoint);
}

//::////////////////////////////////////////////////////////////////////////////
//:: GenerateEncampment
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 07, 2005
//::////////////////////////////////////////////////////////////////////////////
void GenerateEncampment(string sVariable, string sIcon)
{
    DebugMessage("");
    DebugMessage("Generating encampment");

    object oDungeon = GetCurrentDungeon();

    // generate the camp center node
    int nType = CAMP_NODE_CENTER;
    int nSubType = Random(N_SUBTYPES);
    string sNode = sVariable + "Node0";
    SetLocalInt(oDungeon, "n" + sNode + "Type", nType);
    SetLocalInt(oDungeon, "n" + sNode + "SubType", nSubType);

    DebugMessage("Node type " + IntToString(nType) + " is present");
    DebugMessage("Node at " + sNode);

    int nNode;
    object oPC = GetLocalObject(GetModule(), "oTempPC");
    int nCR;
    if (oPC != OBJECT_INVALID)
    {
        nCR = GetPartyLevel(oPC, FALSE);
    } else
    {
        nCR = 1;
    }

    DebugMessage("nCR in camp is " + IntToString(nCR));

    int nCRModifier;
    int nCreatureNum;

    int nPartySize;
    int nCharges;

    object oMicroCPU;
    int nMicroNum;

    int nCount;

    int nLineNum;
    int nLine;
    int nAttitude;

    int nPercentage;
    int nRandom;

    int nNodePercentage;
    int bNodeFixed;

    int nSpell;
    int nSpellLevel;
    int nSpellNum;
    int nSpellNew;
    int nSpellOld;
    int nSpellOld2;
    int bFound;

    int nMax;

    // check to see if each type of node is present (1 = rest, 2 = store, 3 = forge, 4 = hireling, 5 = monster seller, 6 = caster)
    nType = 1;
    while (nType <= 6)
    {
        if (nType == 1) // rest
        {
            nNodePercentage = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_REST_FREQUENCY);
        } else if (nType == 2) // store
        {
            nNodePercentage = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_STORE_FREQUENCY);
        } else if (nType == 3) // forge
        {
            nNodePercentage = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_FORGE_FREQUENCY);
        } else if (nType == 4) // hireling
        {
            nNodePercentage = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_HIRELING_FREQUENCY);
        } else if (nType == 5) // seller
        {
            nNodePercentage = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_SELLER_FREQUENCY);
        } else if (nType == 6) // caster
        {
            nNodePercentage = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_CASTER_FREQUENCY);
        }
        DebugMessage("Node has percentage " + IntToString(nNodePercentage));

        nRandom = Random(100) + 1;
        DebugMessage("  Random number is " + IntToString(nRandom) + " vs " + IntToString(nNodePercentage));

        if (nRandom <= nNodePercentage)
        {
            DebugMessage("Node type " + IntToString(nType) + " is present");

            // generate subtype
            nSubType = Random(N_SUBTYPES) + 1;

            // find a position in the circle (limit of 6 currently)
            nNode = Random(N_TOTAL_NODES) + 1;
            sNode = sVariable + "Node" + IntToString(nNode);
            while (GetLocalInt(oDungeon, "n" + sNode + "Type") > 0)
            {
                nNode++;

                // loop back to beginning
                if (nNode > N_TOTAL_NODES)
                {
                    nNode = 1;
                }

                sNode = sVariable + "Node" + IntToString(nNode);
            }

            DebugMessage("Node at " + sNode);

            // Set the corresponding variables for the node type and subtype.
            SetLocalInt(oDungeon, "n" + sNode + "Type", nType);
            SetLocalInt(oDungeon, "n" + sNode + "SubType", nSubType);

            // determine creature/object based on node type
            if (nType == 1) // rest node
            {
                DebugMessage("Rest node.");

                // no special code needed
            } else if (nType == 2) // store node
            {
                DebugMessage("Store node.");

                // microprocess object
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU106");
                SetLocalString(oMicroCPU, "sCreature", sNode + "Creature");
                SetLocalInt(oMicroCPU, "nCR", nCR);
                SetLocalInt(oMicroCPU, "bIntelligentOnly", TRUE);
                SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMiniBoss", FALSE);
                SetLocalInt(oMicroCPU, "nTileset", -1);
                SetLocalInt(oMicroCPU, "nTheme", 1);
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bHold", TRUE);
                SetLocalInt(oMicroCPU, "bNoTreasure", TRUE);

                // increment number of active microprocessors
                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                nMicroNum++;
                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                // set name
                SetLocalString(oDungeon, "s" + sNode + "CreatureName", RandomName());

                // set attitude
                nAttitude = Random(2) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineAttitude", nAttitude);

                // set greeting
                nLineNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "GreetingNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineGreeting", nLine);
                nMax = GetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Greeting");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Greeting", nLine);
                    DebugMessage("  Set max greeting to " + IntToString(nLine));
                }

                // set offer
                nLineNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "OfferNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineOffer", nLine);
                nMax = GetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Offer");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Offer", nLine);
                    DebugMessage("  Set max offer to " + IntToString(nLine));
                }

                // set good
                nLineNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "GoodNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineGood", nLine);
                nMax = GetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Good");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Good", nLine);
                    DebugMessage("  Set max good to " + IntToString(nLine));
                }

                // set show
                nLineNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "ShowNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineShow", nLine);
                nMax = GetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Show");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Show", nLine);
                    DebugMessage("  Set max show to " + IntToString(nLine));
                }

                // set farewell
                nLineNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "FarewellNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineFarewell", nLine);
                nMax = GetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Farewell");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListMerchantAttitude" + IntToString(nAttitude) + "Farewell", nLine);
                    DebugMessage("  Set max farewell to " + IntToString(nLine));
                }

                // generate storekeeper
                // intelligent
                DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
            } else if (nType == 3) // forge node
            {
                DebugMessage("Forge node.");

                // generate number of charges
                nPartySize = GetPartySize(oPC, FALSE);
                nCharges = Random(nPartySize) + 1;
                if (nCharges > 8)
                {
                    nCharges = 8;
                }
                SetLocalInt(oDungeon, "n" + sNode + "Charges", nCharges);
                SetLocalInt(oDungeon, "n" + sNode + "ChargeMax", nCharges);
                DebugMessage("Setting n" + sNode + "ChargeMax to " + IntToString(nCharges));

                // set this area as having a forge
                SetLocalInt(oDungeon, "b" + sIcon + "Forge", TRUE);
            } else if (nType == 4) // hireling
            {
                DebugMessage("Hireling node.");

                nCRModifier = -2;

                // microprocess object
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU107");
                SetLocalString(oMicroCPU, "sCreature", sNode + "Creature");
                SetLocalInt(oMicroCPU, "nCR", nCR + nCRModifier);
                SetLocalInt(oMicroCPU, "bIntelligentOnly", TRUE);
                SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMediumSizeOnly", TRUE);
                SetLocalInt(oMicroCPU, "bMiniBoss", FALSE);
                SetLocalInt(oMicroCPU, "nTileset", -1);
                SetLocalInt(oMicroCPU, "nTheme", 1);
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bHold", TRUE);
                SetLocalInt(oMicroCPU, "bNoTreasure", TRUE);

                // increment number of active microprocessors
                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                nMicroNum++;
                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                // set name
                SetLocalString(oDungeon, "s" + sNode + "CreatureName", RandomName());

                // set greeting
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingGreetingNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineGreeting", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingGreeting");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingGreeting", nLine);
                    DebugMessage("  Set max attitude to " + IntToString(nLine));
                }

                // set adventurer
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingAdventurerNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineAdventurer", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingAdventurer");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingAdventurer", nLine);
                    DebugMessage("  Set max adventurer to " + IntToString(nLine));
                }

                // set been/lived
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingBeenLivedNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineBeenLived", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingBeenLived");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingBeenLived", nLine);
                    DebugMessage("  Set max been/lived to " + IntToString(nLine));
                }

                // set time
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingTimeNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineTime", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingTime");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingTime", nLine);
                    DebugMessage("  Set max time to " + IntToString(nLine));
                }

                // set useful
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingUsefulNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineUseful", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingUseful");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingUseful", nLine);
                    DebugMessage("  Set max useful to " + IntToString(nLine));
                }

                // set hiring
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingHiringNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineHiring", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingHiring");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingHiring", nLine);
                    DebugMessage("  Set max hiring to " + IntToString(nLine));
                }

                // set ask
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingAskNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineAsk", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingAsk");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingAsk", nLine);
                    DebugMessage("  Set max ask to " + IntToString(nLine));
                }

                // set percentage (1-8%)
                nLine = IntRandomExponentialCurve(2, 9);
                nLine = 11 - nLine;
                SetLocalInt(oDungeon, "n" + sNode + "CreaturePercentage", nLine);
                DebugMessage("  Hireling loot percentage is " + IntToString(nLine));

                // set treasure
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingTreasureNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineTreasure", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingTreasure");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingTreasure", nLine);
                    DebugMessage("  Set max treasure to " + IntToString(nLine));
                }

                // set refused
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingRefusedNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineRefused", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingRefused");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingRefused", nLine);
                    DebugMessage("  Set max refused to " + IntToString(nLine));
                }

                // set accepted
                nLineNum = GetLocalInt(GetModule(), "nLinesHirelingAcceptedNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineAccepted", nLine);
                nMax = GetLocalInt(oDungeon, "nListHirelingAccepted");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListHirelingAccepted", nLine);
                    DebugMessage("  Set max accepted to " + IntToString(nLine));
                }

                // generate hireling
                // intelligent, medium size
                DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
            } else if (nType == 5) // monster seller
            {
                DebugMessage("Monster seller node.");

                // microprocess object
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU109");
                SetLocalString(oMicroCPU, "sCreature", sNode + "Creature");
                SetLocalInt(oMicroCPU, "nCR", nCR);
                SetLocalInt(oMicroCPU, "bIntelligentOnly", TRUE);
                SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMiniBoss", FALSE);
                SetLocalInt(oMicroCPU, "nTileset", -1);
                SetLocalInt(oMicroCPU, "nTheme", 1);
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bHold", TRUE);
                SetLocalInt(oMicroCPU, "bNoTreasure", TRUE);

                // increment number of active microprocessors
                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                nMicroNum++;
                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                // set name
                SetLocalString(oDungeon, "s" + sNode + "CreatureName", RandomName());

                // generate monster seller
                // intelligent
                DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));

                // set greeting
                nLineNum = GetLocalInt(GetModule(), "nLinesSellerGreetingNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineGreeting", nLine);
                nMax = GetLocalInt(oDungeon, "nListSellerGreeting");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListSellerGreeting", nLine);
                    DebugMessage("  Set max greeting to " + IntToString(nLine));
                }

                // set asking
                nLineNum = GetLocalInt(GetModule(), "nLinesSellerAskingNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineAsking", nLine);
                nMax = GetLocalInt(oDungeon, "nListSellerAsking");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListSellerAsking", nLine);
                    DebugMessage("  Set max asking to " + IntToString(nLine));
                }

                // set purchase
                nLineNum = GetLocalInt(GetModule(), "nLinesSellerPurchaseNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLinePurchase", nLine);
                nMax = GetLocalInt(oDungeon, "nListSellerPurchase");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListSellerPurchase", nLine);
                    DebugMessage("  Set max purchase to " + IntToString(nLine));
                }

                // set poor
                nLineNum = GetLocalInt(GetModule(), "nLinesSellerPoorNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLinePoor", nLine);
                nMax = GetLocalInt(oDungeon, "nListSellerPoor");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListSellerPoor", nLine);
                    DebugMessage("  Set max poor to " + IntToString(nLine));
                }

                // set bought
                nLineNum = GetLocalInt(GetModule(), "nLinesSellerBoughtNum");
                nLine = Random(nLineNum) + 1;
                DebugMessage("  nLinesSellerBoughtNum is " + IntToString(nLineNum) + " and chose line " + IntToString(nLine));
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineBought", nLine);
                DebugMessage("  Set n" + sNode + "CreatureLineBought");
                nMax = GetLocalInt(oDungeon, "nListSellerBought");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListSellerBought", nLine);
                    DebugMessage("  Set max bought to " + IntToString(nLine));
                }

                // set goodbye
                nLineNum = GetLocalInt(GetModule(), "nLinesSellerGoodbyeNum");
                nLine = Random(nLineNum) + 1;
                DebugMessage("  nLinesSellerGoodbyeNum is " + IntToString(nLineNum) + " and chose line " + IntToString(nLine));
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineGoodbye", nLine);
                DebugMessage("  Set n" + sNode + "CreatureLineGoodbye");
                nMax = GetLocalInt(oDungeon, "nListSellerGoodbye");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListSellerGoodbye", nLine);
                    DebugMessage("  Set max goodbye to " + IntToString(nLine));
                }

                // EDIT: add flag adjustments
                // generate number of creatures (up to 4)
                nCreatureNum = IntRandomExponentialCurve(2, 4);
                nCRModifier = -2;
                if (nCreatureNum > 4)
                {
                    nCreatureNum = 4;
                }
                if (nCreatureNum < 1)
                {
                    nCreatureNum = 1;
                }
                SetLocalInt(oDungeon, "n" + sNode + "MonsterNum", nCreatureNum);

                if (nCreatureNum == 4)
                {
                    nCRModifier -= 2;
                } else if (nCreatureNum > 1)
                {
                    nCRModifier -= 1;
                }
                if (nCRModifier + nCR < -1)
                {
                    nCRModifier += -1 - (nCR + nCRModifier);
                }

                // EDIT: add flag adjustments
                // generate cost
                if (nCR + nCRModifier < 0)
                {
                    nLine = 250;
                } else if (nCR + nCRModifier < 1)
                {
                    nLine = 500;
                } else
                {
                    nLine = 1000 * (nCR + nCRModifier);
                }
                SetLocalInt(oDungeon, "n" + sNode + "MonsterCost", nLine);

                // microprocess object
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU110");
                SetLocalString(oMicroCPU, "sCreature", sNode + "Monster");
                SetLocalInt(oMicroCPU, "nCR", nCR + nCRModifier);
                SetLocalInt(oMicroCPU, "bIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bUnIntelligentOnly", TRUE);
                SetLocalInt(oMicroCPU, "bMediumSizeOnly", TRUE);
                SetLocalInt(oMicroCPU, "bMiniBoss", FALSE);
                SetLocalInt(oMicroCPU, "nTileset", -1);
                SetLocalInt(oMicroCPU, "nTheme", 1); // EDIT: changed to theme_all from -1
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bHold", TRUE);
                SetLocalInt(oMicroCPU, "bNoTreasure", TRUE);

                // increment number of active microprocessors
                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                nMicroNum++;
                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                // generate monsters
                // medium size
                DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));
            } else if (nType == 6) // caster
            {
                DebugMessage("Caster node.");

                // microprocess object
                oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU111");
                SetLocalString(oMicroCPU, "sCreature", sNode + "Creature");
                SetLocalInt(oMicroCPU, "nCR", nCR);
                SetLocalInt(oMicroCPU, "bIntelligentOnly", TRUE);
                SetLocalInt(oMicroCPU, "bUnIntelligentOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMediumSizeOnly", FALSE);
                SetLocalInt(oMicroCPU, "bMiniBoss", FALSE);
                SetLocalInt(oMicroCPU, "nTileset", -1);
                SetLocalInt(oMicroCPU, "nTheme", 1);
                SetLocalObject(oMicroCPU, "oDungeon", oDungeon);
                SetLocalInt(oMicroCPU, "bHold", TRUE);
                SetLocalInt(oMicroCPU, "bNoTreasure", TRUE);

                // increment number of active microprocessors
                nMicroNum = GetLocalInt(GetModule(), "nMicroNum");
                nMicroNum++;
                SetLocalInt(GetModule(), "nMicroNum", nMicroNum);

                // set name
                SetLocalString(oDungeon, "s" + sNode + "CreatureName", RandomName());

                // generate caster
                // intelligent
                DelayCommand(0.01, ExecuteScript("exe_id1_micmon", oMicroCPU));

                // set greeting
                nLineNum = GetLocalInt(GetModule(), "nLinesCasterGreetingNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineGreeting", nLine);
                nMax = GetLocalInt(oDungeon, "nListCasterGreeting");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListCasterGreeting", nLine);
                    DebugMessage("  Set max greeting to " + IntToString(nLine));
                }

                // set description
                nLineNum = GetLocalInt(GetModule(), "nLinesCasterDescriptionNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineDescription", nLine);
                nMax = GetLocalInt(oDungeon, "nListCasterDescription");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListCasterDescription", nLine);
                    DebugMessage("  Set max description to " + IntToString(nLine));
                }

                // set question
                nLineNum = GetLocalInt(GetModule(), "nLinesCasterQuestionNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineQuestion", nLine);
                nMax = GetLocalInt(oDungeon, "nListCasterQuestion");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListCasterQuestion", nLine);
                    DebugMessage("  Set max question to " + IntToString(nLine));
                }

                // set healing
                nLineNum = GetLocalInt(GetModule(), "nLinesCasterHealingNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineHealing", nLine);
                nMax = GetLocalInt(oDungeon, "nListCasterHealing");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListCasterHealing", nLine);
                    DebugMessage("  Set max healing to " + IntToString(nLine));
                }

                // set remainder
                nLineNum = GetLocalInt(GetModule(), "nLinesCasterRemainderNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineRemainder", nLine);
                nMax = GetLocalInt(oDungeon, "nListCasterRemainder");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListCasterRemainder", nLine);
                    DebugMessage("  Set max remainder to " + IntToString(nLine));
                }

                // set spells
                nLineNum = GetLocalInt(GetModule(), "nLinesCasterSpellsNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineSpells", nLine);
                nMax = GetLocalInt(oDungeon, "nListCasterSpells");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListCasterSpells", nLine);
                    DebugMessage("  Set max spells to " + IntToString(nLine));
                }

                // set cast
                nLineNum = GetLocalInt(GetModule(), "nLinesCasterCastNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineCast", nLine);
                nMax = GetLocalInt(oDungeon, "nListCasterCast");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListCasterCast", nLine);
                    DebugMessage("  Set max question to " + IntToString(nLine));
                }

                // set farewell
                nLineNum = GetLocalInt(GetModule(), "nLinesCasterFarewellNum");
                nLine = Random(nLineNum) + 1;
                SetLocalInt(oDungeon, "n" + sNode + "CreatureLineFarewell", nLine);
                nMax = GetLocalInt(oDungeon, "nListCasterFarewell");
                if (nLine > nMax)
                {
                    SetLocalInt(oDungeon, "nListCasterFarewell", nLine);
                    DebugMessage("  Set max farewell to " + IntToString(nLine));
                }

                // pick 5 random spells
                nSpellLevel = (nCR + 1) / 2;
                if (nSpellLevel < 1)
                {
                    nSpellLevel = 1;
                }
                if (nSpellLevel > 9)
                {
                    nSpellLevel = 9;
                }
                SetLocalInt(oDungeon, "n" + sNode + "CreatureSpellLevel", nSpellLevel);
                nSpell = 1;
                while (nSpell <= 5)
                {
                    nSpellNum = GetCasterSpellsAtLevel(nSpellLevel);

                    nSpellNew = Random(nSpellNum) + 1;

                    // check to see if spell has been used already
                    bFound = FALSE;
                    nSpellOld = 1;
                    while ((nSpellOld < nSpell) && (bFound == FALSE))
                    {
                        nSpellOld2 = GetLocalInt(oDungeon, "n" + sNode + "CreatureSpell" + IntToString(nSpellOld));
                        DebugMessage("    n" + sNode + "CreatureSpell" + IntToString(nSpellOld) + " is " + IntToString(nSpellOld2) + " vs " + IntToString(nSpellNew));
                        if (nSpellOld2 == nSpellNew)
                        {
                            bFound = TRUE;
                        } else
                        {
                            nSpellOld++;
                        }
                    }

                    if (bFound == TRUE)
                    {
                        nSpellNew++;
                        if (nSpellNew > nSpellNum)
                        {
                            nSpellNew = 1;
                        }
                    }

                    while (bFound == TRUE)
                    {
                        bFound = FALSE;
                        nSpellOld = 1;
                        while ((nSpellOld < nSpell) && (bFound == FALSE))
                        {
                            nSpellOld2 = GetLocalInt(oDungeon, "n" + sNode + "CreatureSpell" + IntToString(nSpellOld));
                            DebugMessage("    n" + sNode + "CreatureSpell" + IntToString(nSpellOld) + " is " + IntToString(nSpellOld2) + " vs " + IntToString(nSpellNew));
                            if (nSpellOld2 == nSpellNew)
                            {
                                bFound = TRUE;
                            } else
                            {
                                nSpellOld++;
                            }
                        }

                        if (bFound == TRUE)
                        {
                            nSpellNew++;
                            if (nSpellNew > nSpellNum)
                            {
                                nSpellNew = 1;
                            }
                        }
                    }

                    SetLocalInt(oDungeon, "n" + sNode + "CreatureSpell" + IntToString(nSpell), nSpellNew);
                    DebugMessage("  Set n" + sNode + "CreatureSpell" + IntToString(nSpell) + " to " + IntToString(nSpellNew));

                    nSpell++;
                }
            }
        } else // if this type is not present
        {
            DebugMessage("  Node not present. Checking for decor.");

            nRandom = Random(100) + 1;
            nNodePercentage = GetModuleFlagValue(ID1_FLAG_CAMP_NODE_DECOR_FREQUENCY);
            DebugMessage("  Random number is " + IntToString(nRandom) + " vs " + IntToString(nNodePercentage));
            if (nRandom <= nNodePercentage)
            {
                // EDIT: put random decor in this camp node
            }
        }

        nType++;
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: SpawnEncampment
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 06, 2005
//::////////////////////////////////////////////////////////////////////////////
void SpawnEncampment(object oWaypoint)
{
    object oArea, oDungeon;
    string sVarPrfx;
    location lLoc;
    vector vPos;
    float fX1, fY1, fX, fY, fZ;
    int nType, nSubType, bDead, i;

    int nCharges;
    string sNode;
    string sCreature;
    object oCreature;
    string sMonster;
    object oMonster;
    int nMonsterNum;
    int nMonster;
    int nTemp;
    int nStoreLevel;
    int nStoreGold;
    string sName;
    object oStore;
    object oMicroCPU;

    int nCR;

    int nAlignment;

    int nPayment;

    sVarPrfx = GetEncampmentVariablePrefix(oWaypoint);

    // Get the position of the camp's center.
    oArea = GetArea(oWaypoint);
    oDungeon = GetCurrentDungeon();

    lLoc = GetLocation(oWaypoint);
    vPos = GetPosition(oWaypoint);

    fX1 = vPos.x;
    fY1 = vPos.y;
    fZ = vPos.z;

    // Create the center node.
    nSubType = GetLocalInt(oDungeon, sVarPrfx + "Node0SubType");
    SpawnCenterCampNode(lLoc, nSubType);

    // Create N_TOTAL_NODES placeables in a circle around the center position.
    for (i = 1; i <= N_TOTAL_NODES; ++i)
    {
        // Establish the node's location.
        fX = fX1 + GetNextCircleX(5.0, i, N_TOTAL_NODES);
        fY = fY1 + GetNextCircleY(5.0, i, N_TOTAL_NODES);
        vPos = Vector(fX, fY, fZ);
        lLoc = Location(oArea, vPos, 0.0);

        sNode = sVarPrfx + "Node" + IntToString(i);
        DebugMessage("sNode is " + sNode);
        sNode = GetSubString(sNode, 1, GetStringLength(sNode) - 1);
        DebugMessage("sNode is " + sNode);

        // Establish type and subtype.
        nType = GetLocalInt(oDungeon, "n" + sNode + "Type");
        nSubType = GetLocalInt(oDungeon, "n" + sNode + "SubType");

        // establish if creature is alive
        sCreature = sNode + "Creature";
        bDead = GetLocalInt(oDungeon, "b" + sCreature + "Dead");
        DebugMessage("sCreature is " + sCreature);

        switch (nType)
        {
            case CAMP_NODE_REST:
            {
                DebugMessage("Spawn rest node.");

                // spawn placeables
                SpawnRestNode(lLoc, nSubType, oWaypoint);

                break;
            }

            case CAMP_NODE_STORE:
            {
                DebugMessage("Spawn store node.");

                // spawn placeables
                SpawnStoreNode(lLoc, nSubType);

                // if not dead
                if (bDead == FALSE)
                {
                    // spawn creature
                    oCreature = SpawnCreature(sCreature, lLoc, oDungeon);

                    // set as friendly shopkeeper
                    AssignCommand(oCreature, SurrenderToEnemies());
                    ChangeToStandardFaction(oCreature, STANDARD_FACTION_COMMONER);
                    SetLocalString(oCreature, "sConversation", "id1_merchant");
                    SetName(oCreature, "Merchant");

                    // turn to face the center
                    TurnToFaceObject(oWaypoint, oCreature);

                    if (GetTag(oCreature) == "id1_penguin")
                    {
                        nCR = GetLocalInt(oDungeon, "n" + sCreature + "CR");

                        SetLocalInt(oCreature, "nCreatureType", 3);
                        SetLocalInt(oCreature, "nCR", nCR);
                        SetLocalInt(oCreature, "nBaseHD", 1);
                        SetLocalInt(oCreature, "nClassStartHD", 1);
                        SetLocalInt(oCreature, "nClass", -1);
                        SetName(oCreature, "Penguin CR " + IntToString(nCR));
                    } else
                    {
                        // set creature type (1 = enemy, 2 = ally)
                        SetLocalInt(oCreature, "nCreatureType", 2);
                    }

                    // can be lawful/neutral/chaotic
                    nAlignment = Random(100) + 1 - GetAlignmentLawChaos(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                    // can be neutral
                    nAlignment = 50 - GetAlignmentGoodEvil(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);

                    // generate a store
                    nStoreLevel = GetLocalInt(oDungeon, "n" + sCreature + "CR") + 2;
                    if (nStoreLevel < 1)
                    {
                        nStoreLevel = 1;
                    }
                    DebugMessage("  Spawning store.");

                    oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU112");
                    SetLocalInt(oMicroCPU, "nLevel", nStoreLevel);
                    SetLocalInt(oMicroCPU, "bTimmy", FALSE);
                    SetLocalObject(oMicroCPU, "oParent", oCreature);

                    DelayCommand(0.1, ExecuteScript("exe_id1_micstore", oMicroCPU));
                }

                break;
            }

            case CAMP_NODE_FORGE:
            {
                DebugMessage("Spawn forge node.");

                // get the number of charges
                nCharges = GetLocalInt(oDungeon, "n" + sNode + "Charges");
                DebugMessage("Forge has " + IntToString(nCharges) + " charges");

                // spawn placeables
                SpawnForgeNode(lLoc, nSubType, nCharges, sNode);

                break;
            }

            case CAMP_NODE_HIRELING:
            {
                DebugMessage("Spawn hireling node.");

                // spawn placeables
                SpawnPerimiterCampNode(lLoc, nSubType);

                // if not dead
                if (bDead == FALSE)
                {
                    // spawn creature
                    oCreature = SpawnCreature(sCreature, lLoc, oDungeon);

                    // set as friendly hireling
                    AssignCommand(oCreature, SurrenderToEnemies());
                    ChangeToStandardFaction(oCreature, STANDARD_FACTION_COMMONER);
                    SetLocalString(oCreature, "sConversation", "id1_hireling");
                    sName = GetName(oCreature) + " Hireling";
                    SetName(oCreature, sName);

                    // turn to face the center
                    TurnToFaceObject(oWaypoint, oCreature);

                    if (GetTag(oCreature) == "id1_penguin")
                    {
                        nCR = GetLocalInt(oDungeon, "n" + sCreature + "CR");

                        SetLocalInt(oCreature, "nCreatureType", 3);
                        SetLocalInt(oCreature, "nCR", nCR);
                        SetLocalInt(oCreature, "nBaseHD", 1);
                        SetLocalInt(oCreature, "nClassStartHD", 1);
                        SetLocalInt(oCreature, "nClass", -1);
                        SetName(oCreature, "Penguin CR " + IntToString(nCR));
                    } else
                    {
                        // set creature type (1 = enemy, 2 = ally)
                        SetLocalInt(oCreature, "nCreatureType", 2);
                    }

                    // can be lawful/neutral/chaotic
                    nAlignment = Random(100) + 1 - GetAlignmentLawChaos(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                    // can be neutral
                    nAlignment = 50 - GetAlignmentGoodEvil(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);

                    nPayment = GetLocalInt(oDungeon, "n" + sCreature + "Percentage");
                    SetLocalInt(oCreature, "nPayment", nPayment);
                }

                break;
            }

            case CAMP_NODE_MONSTER:
            {
                DebugMessage("Spawn monster seller node.");

                // spawn placeables
                SpawnPerimiterCampNode(lLoc, nSubType);

                // if not dead
                if (bDead == FALSE)
                {
                    // spawn creature
                    oCreature = SpawnCreature(sCreature, lLoc, oDungeon);

                    // set as friendly monster seller
                    AssignCommand(oCreature, SurrenderToEnemies());
                    ChangeToStandardFaction(oCreature, STANDARD_FACTION_COMMONER);
                    SetLocalString(oCreature, "sNode", sNode);
                    SetLocalString(oCreature, "sConversation", "id1_seller");
                    SetName(oCreature, "Monster Seller");

                    if (GetTag(oCreature) == "id1_penguin")
                    {
                        nCR = GetLocalInt(oDungeon, "n" + sCreature + "CR");

                        SetLocalInt(oCreature, "nCreatureType", 3);
                        SetLocalInt(oCreature, "nCR", nCR);
                        SetLocalInt(oCreature, "nBaseHD", 1);
                        SetLocalInt(oCreature, "nClassStartHD", 1);
                        SetLocalInt(oCreature, "nClass", -1);
                        SetName(oCreature, "Penguin CR " + IntToString(nCR));
                    } else
                    {
                        // set creature type (1 = enemy, 2 = ally)
                        SetLocalInt(oCreature, "nCreatureType", 2);
                    }

                    // turn to face the center
                    TurnToFaceObject(oWaypoint, oCreature);

                    // can be lawful/neutral/chaotic
                    nAlignment = Random(100) + 1 - GetAlignmentLawChaos(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                    // can be neutral
                    nAlignment = 50 - GetAlignmentGoodEvil(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);

                    // get number of monsters
                    nMonsterNum = GetLocalInt(oDungeon, "n" + sNode + "MonsterNum");
                    DebugMessage("There are " + IntToString(nMonsterNum) + " monsters to be spawned");
                    nMonster = 1;
                    while (nMonster <= nMonsterNum)
                    {
                        sMonster = sNode + "Monster" + IntToString(nMonster);

                        bDead = GetLocalInt(oDungeon, "b" + sMonster + "Dead");

                        // if the creature is not dead/sold
                        if (bDead == FALSE)
                        {
                            // copy variables
                            nTemp = GetLocalInt(oDungeon, "n" + sNode + "Monster");
                            SetLocalInt(oDungeon, "n" + sMonster, nTemp);
                            nTemp = GetLocalInt(oDungeon, "n" + sNode + "MonsterCR");
                            SetLocalInt(oDungeon, "n" + sMonster + "CR", nTemp);

                            // spawn creature
                            oMonster = SpawnCreature(sMonster, lLoc, oDungeon);

                            // set as friendly monster seller
                            AssignCommand(oMonster, SurrenderToEnemies());
                            ChangeToStandardFaction(oMonster, STANDARD_FACTION_COMMONER);
                            SetLocalString(oMonster, "sConversation", "id1_monster");
                            sName = GetName(oMonster) + " Minion";
                            SetName(oMonster, sName);

                            // turn to face the center
                            TurnToFaceObject(oCreature, oMonster);

                            if (GetTag(oCreature) == "id1_penguin")
                            {
                                nCR = GetLocalInt(oDungeon, "n" + sCreature + "CR");

                                SetLocalInt(oCreature, "nCreatureType", 3);
                                SetLocalInt(oCreature, "nCR", nCR);
                                SetLocalInt(oCreature, "nBaseHD", 1);
                                SetLocalInt(oCreature, "nClassStartHD", 1);
                                SetLocalInt(oCreature, "nClass", -1);
                                SetName(oCreature, "Penguin CR " + IntToString(nCR));
                            } else
                            {
                                // set creature type (1 = enemy, 2 = ally)
                                SetLocalInt(oCreature, "nCreatureType", 2);
                            }

                            // can be lawful/neutral/chaotic
                            nAlignment = 50 - GetAlignmentLawChaos(oCreature);
                            AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                            // can be neutral
                            nAlignment = 50 - GetAlignmentGoodEvil(oCreature);
                            AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);

                            SetLocalObject(oCreature, "oMonster" + IntToString(nMonster), oMonster);
                        }

                        // check the next monster
                        nMonster++;
                    }
                }

                break;
            }

            case CAMP_NODE_CASTER:
            {
                DebugMessage("Spawn caster node.");

                // spawn placeables
                SpawnPerimiterCampNode(lLoc, nSubType);

                // if not dead
                if (bDead == FALSE)
                {
                    // spawn creature
                    oCreature = SpawnCreature(sCreature, lLoc, oDungeon);

                    // set as friendly caster
                    AssignCommand(oCreature, SurrenderToEnemies());
                    ChangeToStandardFaction(oCreature, STANDARD_FACTION_COMMONER);
                    SetLocalString(oCreature, "sConversation", "id1_caster");
                    SetName(oCreature, "Spell-Caster");

                    // turn to face the center
                    TurnToFaceObject(oWaypoint, oCreature);

                    if (GetTag(oCreature) == "id1_penguin")
                    {
                        nCR = GetLocalInt(oDungeon, "n" + sCreature + "CR");

                        SetLocalInt(oCreature, "nCreatureType", 3);
                        SetLocalInt(oCreature, "nCR", nCR);
                        SetLocalInt(oCreature, "nBaseHD", 1);
                        SetLocalInt(oCreature, "nClassStartHD", 1);
                        SetLocalInt(oCreature, "nClass", -1);
                        SetName(oCreature, "Penguin CR " + IntToString(nCR));
                    } else
                    {
                        // set creature type (1 = enemy, 2 = ally)
                        SetLocalInt(oCreature, "nCreatureType", 2);
                    }

                    // can be lawful/neutral/chaotic
                    nAlignment = Random(100) + 1 - GetAlignmentLawChaos(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_LAWFUL, nAlignment);

                    // can be neutral
                    nAlignment = 50 - GetAlignmentGoodEvil(oCreature);
                    AdjustAlignment(oCreature, ALIGNMENT_GOOD, nAlignment);

                    // give permanent true seeing to prevent casting from failing
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectTrueSeeing()), oCreature);
                }

                break;
            }

            case CAMP_NODE_DECOR:
            {
                DebugMessage("Spawn decor node.");

                // spawn placeables
                SpawnPerimiterCampNode(lLoc, nSubType);

                break;
            }

            default:
            {
                DebugMessage("Unrecognized camp node type.");

                break;
            }
        }
    }
}

object SpawnCreature(string sCreature, location lLocation, object oDungeon = OBJECT_INVALID)
{
    if (oDungeon == OBJECT_INVALID)
    {
        oDungeon = GetCurrentDungeon();
    }

    string sResRef;

    // get creature type
    int nCreatureType = GetLocalInt(oDungeon, "n" + sCreature);

    // if a valid creature
    if (nCreatureType > 0)
    {
        sResRef = GetLocalString(oDungeon, "sListCreature" + IntToString(nCreatureType) + "ResRef");
    } else // spawn a penguin
    {
        sResRef = "id1_penguin";
    }

    // spawn creature
    DebugMessage("Spawning creature with resref " + sResRef);
    object oCreature = CreateObject(OBJECT_TYPE_CREATURE, sResRef, lLocation);
    SetLocalString(oCreature, "sVariable", sCreature);

    return oCreature;
}

//::////////////////////////////////////////////////////////////////////////////
//:: SpawnCenterCampNode
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 02, 2005
//::////////////////////////////////////////////////////////////////////////////
void SpawnCenterCampNode(location lLocation, int nSubType)
{
    string sResRef;

    // Make a campfire in the center OR leave it open.
    if (nSubType < (N_SUBTYPES/4))
    {
        sResRef = CAMPFIRE_1;
    }
    else if (nSubType < (N_SUBTYPES/2))
    {
        sResRef = CAMPFIRE_2;
    }
    else if (nSubType < ((3*N_SUBTYPES)/4))
    {
        sResRef = CAMPFIRE_3;
    }
    else
    {
        sResRef = "";
    }

    // If a campfire is selected create it.
    if (sResRef != "")
    {
        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLocation);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: SpawnStoreNode
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: sep 06, 2005
//::////////////////////////////////////////////////////////////////////////////
void SpawnStoreNode(location lLocation, int nSubType)
{
    float fX, fY, fZ, fFcng;
    vector vPos;
    location lLoc;
    string sResRef;
    object oArea;

    oArea = GetAreaFromLocation(lLocation);
    vPos = GetPositionFromLocation(lLocation);

    fX = vPos.x;
    fY = vPos.y;
    fZ = vPos.z;

    // Based on subtype determine the wagon.
    if (nSubType < (N_SUBTYPES/5))
    {
        sResRef = WAGON_1;
    }
    else if (nSubType < ((2*N_SUBTYPES)/5))
    {
        sResRef = WAGON_2;
    }
    else if (nSubType < ((3*N_SUBTYPES)/5))
    {
        sResRef = WAGON_3;
    }
    else if (nSubType < ((4*N_SUBTYPES)/5))
    {
        sResRef = WAGON_4;
    }
    else
    {
        sResRef = "";
    }

    // Create the wagon if one should exist.
    if (sResRef != "")
    {
        fFcng = 90.0 + IntToFloat(Random(230));
        vPos = Vector(fX - 2.08, fY, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
    }

    // Determine a merchandise based on subtype.
    if (nSubType < (N_SUBTYPES/4))
    {
        sResRef = WEAPON_RACK;
    }
    else if (nSubType < (N_SUBTYPES/2))
    {
        sResRef = BOLTS_OF_CLOTH;
    }
    else if (nSubType < ((3*N_SUBTYPES)/4))
    {
        sResRef = CUSHIONS;
    }
    else
    {
        sResRef = "";
    }

    // Create some merchandise.
    if (sResRef != "")
    {
        fFcng = 90.0;
        vPos = Vector(fX, fY, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
    }

    // Create a Crate based on subtype.
    if (nSubType < (N_SUBTYPES/5))
    {
        sResRef = BARREL;
    }
    else if (nSubType < ((2*N_SUBTYPES)/5))
    {
        sResRef = CRATE_1;
    }
    else if (nSubType < ((3*N_SUBTYPES)/5))
    {
        sResRef = CRATE_2;
    }
    else if (nSubType < ((4*N_SUBTYPES)/5))
    {
        sResRef = CRATE_3;
    }
    else
    {
        sResRef = "";
    }

    // If a crate was determined create it.
    if (sResRef != "")
    {
        fFcng = 47.0;
        vPos = Vector(fX + 1.19, fY + 0.38, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
    }

    // Create another crate or a chest, based on subtype.
    if (nSubType < (N_SUBTYPES/2))
    {
        sResRef = CRATE_2;
    }
    else
    {
        sResRef = CHEST;
    }

    if (sResRef != "")
    {
        fFcng = 315.0;
        vPos = Vector (fX + 1.45, fY - 0.72, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: SpawnForgeNode
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 06, 2005
//::////////////////////////////////////////////////////////////////////////////
void SpawnForgeNode(location lLocation, int nSubType, int nCharges, string sNode)
{
    float fX, fY, fZ, fFcng;
    vector vPos;
    location lLoc;
    string sResRef;
    object oArea;

    oArea = GetAreaFromLocation(lLocation);
    vPos = GetPositionFromLocation(lLocation);

    fX = vPos.x;
    fY = vPos.y;
    fZ = vPos.z;

    fFcng = 180.0;
    vPos = Vector(fX - 1.5, fY, fZ);
    lLoc = Location(oArea, vPos, fFcng);

    // create the mystic forge
    object oForge = DB_CreateObject(OBJECT_TYPE_PLACEABLE, "id1_mysticforge", lLoc);
    SetLocalString(oForge, "sVariable", sNode);

    // create sparks around it
    int nCount;
    location lLoc2;
    vector vPos2;
    for (nCount = 1; nCount <= nCharges; nCount++)
    {
        vPos2 = Vector(fX - 1.5 + ((Random(21) - 10) / 100.0), fY + ((Random(21) - 10) / 100.0), fZ);
        lLoc2 = Location(oArea, vPos2, fFcng);
        DB_CreateObject(OBJECT_TYPE_PLACEABLE, "plc_magicwhite", lLoc2);
    }

    // Chance of creating a crate.
    if (nSubType < (N_SUBTYPES/5))
    {
        sResRef = CRATE_1;
    }
    else if (nSubType < ((2*N_SUBTYPES)/5))
    {
        sResRef = CRATE_2;
    }
    else if (nSubType < ((3*N_SUBTYPES)/5))
    {
        sResRef = CRATE_3;
    }
    else if (nSubType < ((4*N_SUBTYPES)/5))
    {
        sResRef = CRATE_4;
    }
    else
    {
        sResRef = "";
    }

    if (sResRef != "") // If a crate was randomly determined.
    {
        fFcng = IntToFloat(Random(360)); // Possible for inconsistency.
        vPos = Vector(fX + 0.01, fY - 1.0, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
    }
}

//::////////////////////////////////////////////////////////////////////////////
//:: SpawnRestNode
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: spt 07, 2005
//::////////////////////////////////////////////////////////////////////////////
void SpawnRestNode(location lLocation, int nSubType, object oWaypoint)
{
    float fX, fY, fZ, fFcng;
    vector vPos;
    location lLoc;
    string sResRef;
    object oArea;

    oArea = GetAreaFromLocation(lLocation);
    vPos = GetPositionFromLocation(lLocation);

    fX = vPos.x;
    fY = vPos.y;
    fZ = vPos.z;

    // Nov 10, 2005: The rest system no longer uses bedroll proximity so instead
    // spawn in some tents that the player will be able to use to rest.
    if (nSubType < (N_SUBTYPES/2))
    {
        sResRef = REST_TENT_1;
    }
    else
    {
        sResRef = REST_TENT_2;
    }

    // EDIT: to prevent crashes from divide by 0
    if (nSubType == 0)
    {
        nSubType = 1;
    }

    fFcng = 360.0 / IntToFloat(nSubType);

    lLoc = Location(oArea, vPos, fFcng);

    object oTent = DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
    TurnToFaceObject(oWaypoint, oTent);

    /*
    if (nSubType < (N_SUBTYPES/2))
    {
        fFcng = 45.0;
        vPos = Vector(fX - 1.0, fY + 0.5, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);

        fFcng = 90.0;
        vPos = Vector(fX, fY - 1.0, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);

        fFcng = 180.0;
        vPos = Vector(fX + 1.5, fY - 1.0, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
    }
    else
    {
        fFcng = 180.0;
        vPos = Vector(fX - 1.7, fY + 0.3, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);

        fFcng = 276.0;
        vPos = Vector(fX + 0.3, fY - 1.6, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);

        fFcng = 10.0;
        vPos = Vector(fX + 1.7, fY + 0.4, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);

        fFcng = 180.0;
        vPos = Vector(fX, fY + 2.0, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);

        // Place a campfire.
        sResRef = CAMPFIRE_1;
        fFcng = 0.0;
        vPos = Vector(fX, fY, fZ);
        lLoc = Location(oArea, vPos, fFcng);

        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc);
    }
    */
}

//::////////////////////////////////////////////////////////////////////////////
//:: SpawnPerimiterCampNode
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: Sep 02, 2005
//::////////////////////////////////////////////////////////////////////////////
void SpawnPerimiterCampNode(location lLocation,  int nSubType)
{
    // Determine a random placeable type.
    string sResRef;

    // This switch is not robust enough to survive a change in total number of
    // possible subtypes (indicated by the N_SUBTYPES constant). It should be
    // replaced with fractional math.
    switch (nSubType)
    {
        case 0:
        {
            sResRef = BARREL;
            break;
        }
        case 1:
        {
            sResRef = BOLTS_OF_CLOTH;
            break;
        }
        case 2:
        {
            sResRef = CAMPFIRE_1;
            break;
        }
        case 3:
        {
            sResRef = CAMPFIRE_2;
            break;
        }
        case 4:
        {
            sResRef = CAMPFIRE_3;
            break;
        }
        case 5:
        {
            sResRef = CRATE_1;
            break;
        }
        case 6:
        {
            sResRef = CRATE_2;
            break;
        }
        case 7:
        {
            sResRef = CRATE_3;
            break;
        }
        case 8:
        {
            sResRef = CRATE_4;
            break;
        }
        case 9:
        {
            sResRef = GARBAGE;
            break;
        }
        case 10:
        {
            sResRef = HAY_BALE;
            break;
        }
        case 11:
        {
            sResRef = KEG;
            break;
        }
        case 12:
        {
            sResRef = SACK_OF_FLOUR;
            break;
        }
        case 13:
        case 14:
        {
            sResRef = TENT_1;
            break;
        }
        case 15:
        case 16:
        {
            sResRef = TENT_2;
            break;
        }
        case 17:
        case 18:
        {
            sResRef = WAGON_1;
            break;
        }
        case 19:
        case 20:
        {
            sResRef = WAGON_2;
            break;
        }
        case 21:
        case 22:
        {
            sResRef = WAGON_3;
            break;
        }
        case 23:
        {
            sResRef = WOODPILE;
            break;
        }
        default:
        {
            sResRef = "";
            break;
        }
    } // end switch

    // If the ResRef is empty create nothing.
    if (sResRef != "")
    {
        DB_CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLocation);
    }
}

//void main(){}

int GetCasterSpellsAtLevel(int nLevel)
{
    if (nLevel == 1)
    {
        return 8;
    } else if (nLevel == 2)
    {
        return 17;
    } else if (nLevel == 3)
    {
        return 18;
    } else if (nLevel == 4)
    {
        return 18;
    } else if (nLevel == 5)
    {
        return 17;
    } else if (nLevel == 6)
    {
        return 16;
    } else if (nLevel == 7)
    {
        return 14;
    } else if (nLevel == 8)
    {
        return 14;
    } else if (nLevel == 9)
    {
        return 14;
    }

    return -1;
}

int GetCasterSpellNumberAtLevel(int nLevel, int nSpell)
{
    if (nLevel == 1)
    {
        if (nSpell == 1)
        {
            return SPELL_SHIELD_OF_FAITH;
        } else if (nSpell == 2)
        {
            return SPELL_PROTECTION_FROM_GOOD;
        } else if (nSpell == 3)
        {
            return SPELL_PROTECTION_FROM_EVIL;
        } else if (nSpell == 4)
        {
            return SPELL_AMPLIFY;
        } else if (nSpell == 5)
        {
            return SPELL_MAGIC_WEAPON;
        } else if (nSpell == 6)
        {
            return SPELL_MAGE_ARMOR;
        } else if (nSpell == 7)
        {
            return SPELL_SANCTUARY;
        } else if (nSpell == 8)
        {
            return SPELL_IRONGUTS;
        }
    } else if (nLevel == 2)
    {
        if (nSpell == 1)
        {
            return SPELL_SHIELD_OF_FAITH;
        } else if (nSpell == 2)
        {
            return SPELL_PROTECTION_FROM_GOOD;
        } else if (nSpell == 3)
        {
            return SPELL_PROTECTION_FROM_EVIL;
        } else if (nSpell == 4)
        {
            return SPELL_AMPLIFY;
        } else if (nSpell == 5)
        {
            return SPELL_MAGIC_WEAPON;
        } else if (nSpell == 6)
        {
            return SPELL_MAGE_ARMOR;
        } else if (nSpell == 7)
        {
            return SPELL_SANCTUARY;
        } else if (nSpell == 8)
        {
            return SPELL_BARKSKIN;
        } else if (nSpell == 9)
        {
            return SPELL_EAGLE_SPLEDOR;
        } else if (nSpell == 10)
        {
            return SPELL_FOXS_CUNNING;
        } else if (nSpell == 11)
        {
            return SPELL_BULLS_STRENGTH;
        } else if (nSpell == 12)
        {
            return SPELL_ENDURANCE;
        } else if (nSpell == 13)
        {
            return SPELL_DARKVISION;
        } else if (nSpell == 14)
        {
            return SPELL_SEE_INVISIBILITY;
        } else if (nSpell == 15)
        {
            return SPELL_OWLS_WISDOM;
        } else if (nSpell == 16)
        {
            return SPELL_INVISIBILITY;
        } else if (nSpell == 17)
        {
            return SPELL_PROTECTION_FROM_ELEMENTS;
        }
    } else if (nLevel == 3)
    {
        if (nSpell == 1)
        {
            return SPELL_SHIELD_OF_FAITH;
        } else if (nSpell == 2)
        {
            return SPELL_BARKSKIN;
        } else if (nSpell == 3)
        {
            return SPELL_EAGLE_SPLEDOR;
        } else if (nSpell == 4)
        {
            return SPELL_FOXS_CUNNING;
        } else if (nSpell == 5)
        {
            return SPELL_BULLS_STRENGTH;
        } else if (nSpell == 6)
        {
            return SPELL_ENDURANCE;
        } else if (nSpell == 7)
        {
            return SPELL_DARKVISION;
        } else if (nSpell == 8)
        {
            return SPELL_SEE_INVISIBILITY;
        } else if (nSpell == 9)
        {
            return SPELL_OWLS_WISDOM;
        } else if (nSpell == 10)
        {
            return SPELL_INVISIBILITY;
        } else if (nSpell == 11)
        {
            return SPELL_PROTECTION_FROM_ELEMENTS;
        } else if (nSpell == 12)
        {
            return SPELL_GREATER_MAGIC_WEAPON;
        } else if (nSpell == 13)
        {
            return SPELL_NEGATIVE_ENERGY_PROTECTION;
        } else if (nSpell == 14)
        {
            return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
        } else if (nSpell == 15)
        {
            return SPELL_HASTE;
        } else if (nSpell == 16)
        {
            return SPELL_MAGIC_CIRCLE_AGAINST_GOOD;
        } else if (nSpell == 17)
        {
            return SPELL_MAGIC_CIRCLE_AGAINST_EVIL;
        } else if (nSpell == 18)
        {
            return SPELL_DISPLACEMENT;
        }
    } else if (nLevel == 4)
    {
        if (nSpell == 1)
        {
            return SPELL_SHIELD_OF_FAITH;
        } else if (nSpell == 2)
        {
            return SPELL_BARKSKIN;
        } else if (nSpell == 3)
        {
            return SPELL_EAGLE_SPLEDOR;
        } else if (nSpell == 4)
        {
            return SPELL_FOXS_CUNNING;
        } else if (nSpell == 5)
        {
            return SPELL_BULLS_STRENGTH;
        } else if (nSpell == 6)
        {
            return SPELL_ENDURANCE;
        } else if (nSpell == 7)
        {
            return SPELL_DARKVISION;
        } else if (nSpell == 8)
        {
            return SPELL_SEE_INVISIBILITY;
        } else if (nSpell == 9)
        {
            return SPELL_OWLS_WISDOM;
        } else if (nSpell == 10)
        {
            return SPELL_GREATER_MAGIC_WEAPON;
        } else if (nSpell == 11)
        {
            return SPELL_NEGATIVE_ENERGY_PROTECTION;
        } else if (nSpell == 12)
        {
            return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
        } else if (nSpell == 13)
        {
            return SPELL_HASTE;
        } else if (nSpell == 14)
        {
            return SPELL_MAGIC_CIRCLE_AGAINST_GOOD;
        } else if (nSpell == 15)
        {
            return SPELL_MAGIC_CIRCLE_AGAINST_EVIL;
        } else if (nSpell == 16)
        {
            return SPELL_STONESKIN;
        } else if (nSpell == 17)
        {
            return SPELL_IMPROVED_INVISIBILITY;
        } else if (nSpell == 18)
        {
            return SPELL_DEATH_WARD;
        }
    } else if (nLevel == 5)
    {
        if (nSpell == 1)
        {
            return SPELL_SHIELD_OF_FAITH;
        } else if (nSpell == 2)
        {
            return SPELL_BARKSKIN;
        } else if (nSpell == 3)
        {
            return SPELL_EAGLE_SPLEDOR;
        } else if (nSpell == 4)
        {
            return SPELL_FOXS_CUNNING;
        } else if (nSpell == 5)
        {
            return SPELL_BULLS_STRENGTH;
        } else if (nSpell == 6)
        {
            return SPELL_ENDURANCE;
        } else if (nSpell == 7)
        {
            return SPELL_GREATER_MAGIC_WEAPON;
        } else if (nSpell == 8)
        {
            return SPELL_NEGATIVE_ENERGY_PROTECTION;
        } else if (nSpell == 9)
        {
            return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
        } else if (nSpell == 10)
        {
            return SPELL_HASTE;
        } else if (nSpell == 11)
        {
            return SPELL_STONESKIN;
        } else if (nSpell == 12)
        {
            return SPELL_IMPROVED_INVISIBILITY;
        } else if (nSpell == 13)
        {
            return SPELL_DEATH_WARD;
        } else if (nSpell == 14)
        {
            return SPELL_OWLS_INSIGHT;
        } else if (nSpell == 15)
        {
            return SPELL_SPELL_RESISTANCE;
        } else if (nSpell == 16)
        {
            return SPELL_TRUE_SEEING;
        } else if (nSpell == 17)
        {
            return SPELL_MONSTROUS_REGENERATION;
        }
    } else if (nLevel == 6)
    {
        if (nSpell == 1)
        {
            return SPELL_SHIELD_OF_FAITH;
        } else if (nSpell == 2)
        {
            return SPELL_BARKSKIN;
        } else if (nSpell == 3)
        {
            return SPELL_EAGLE_SPLEDOR;
        } else if (nSpell == 4)
        {
            return SPELL_FOXS_CUNNING;
        } else if (nSpell == 5)
        {
            return SPELL_BULLS_STRENGTH;
        } else if (nSpell == 6)
        {
            return SPELL_ENDURANCE;
        } else if (nSpell == 7)
        {
            return SPELL_GREATER_MAGIC_WEAPON;
        } else if (nSpell == 8)
        {
            return SPELL_NEGATIVE_ENERGY_PROTECTION;
        } else if (nSpell == 9)
        {
            return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
        } else if (nSpell == 10)
        {
            return SPELL_STONESKIN;
        } else if (nSpell == 11)
        {
            return SPELL_IMPROVED_INVISIBILITY;
        } else if (nSpell == 12)
        {
            return SPELL_DEATH_WARD;
        } else if (nSpell == 13)
        {
            return SPELL_OWLS_INSIGHT;
        } else if (nSpell == 14)
        {
            return SPELL_SPELL_RESISTANCE;
        } else if (nSpell == 15)
        {
            return SPELL_TRUE_SEEING;
        } else if (nSpell == 16)
        {
            return SPELL_MONSTROUS_REGENERATION;
        }
    } else if (nLevel == 7)
    {
        if (nSpell == 1)
        {
            return SPELL_SHIELD_OF_FAITH;
        } else if (nSpell == 2)
        {
            return SPELL_BARKSKIN;
        } else if (nSpell == 3)
        {
            return SPELL_EAGLE_SPLEDOR;
        } else if (nSpell == 4)
        {
            return SPELL_FOXS_CUNNING;
        } else if (nSpell == 5)
        {
            return SPELL_GREATER_MAGIC_WEAPON;
        } else if (nSpell == 6)
        {
            return SPELL_NEGATIVE_ENERGY_PROTECTION;
        } else if (nSpell == 7)
        {
            return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
        } else if (nSpell == 8)
        {
            return SPELL_STONESKIN;
        } else if (nSpell == 9)
        {
            return SPELL_IMPROVED_INVISIBILITY;
        } else if (nSpell == 10)
        {
            return SPELL_DEATH_WARD;
        } else if (nSpell == 11)
        {
            return SPELL_OWLS_INSIGHT;
        } else if (nSpell == 12)
        {
            return SPELL_SPELL_RESISTANCE;
        } else if (nSpell == 13)
        {
            return SPELL_TRUE_SEEING;
        } else if (nSpell == 14)
        {
            return SPELL_REGENERATE;
        }
    } else if (nLevel >= 8)
    {
        if (nSpell == 1)
        {
            return SPELL_SHIELD_OF_FAITH;
        } else if (nSpell == 2)
        {
            return SPELL_BARKSKIN;
        } else if (nSpell == 3)
        {
            return SPELL_EAGLE_SPLEDOR;
        } else if (nSpell == 4)
        {
            return SPELL_FOXS_CUNNING;
        } else if (nSpell == 5)
        {
            return SPELL_GREATER_MAGIC_WEAPON;
        } else if (nSpell == 6)
        {
            return SPELL_NEGATIVE_ENERGY_PROTECTION;
        } else if (nSpell == 7)
        {
            return SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE;
        } else if (nSpell == 8)
        {
            return SPELL_STONESKIN;
        } else if (nSpell == 9)
        {
            return SPELL_IMPROVED_INVISIBILITY;
        } else if (nSpell == 10)
        {
            return SPELL_DEATH_WARD;
        } else if (nSpell == 11)
        {
            return SPELL_OWLS_INSIGHT;
        } else if (nSpell == 12)
        {
            return SPELL_SPELL_RESISTANCE;
        } else if (nSpell == 13)
        {
            return SPELL_TRUE_SEEING;
        } else if (nSpell == 14)
        {
            return SPELL_REGENERATE;
        }
    }

    return -1;
}

string GetSpellName(int nSpell)
{
    if (nSpell == SPELL_BATTLETIDE)
    {
        return "Battletide";
    }
    else if (nSpell == SPELL_BULLS_STRENGTH)
    {
        return "Bull's Strength";
    }
    else if (nSpell == SPELL_DEATH_WARD)
    {
        return "Death Ward";
    }
    else if (nSpell == SPELL_EAGLE_SPLEDOR)
    {
        return "Eagle's Splendor";
    }
    else if (nSpell == SPELL_ENDURANCE)
    {
        return "Endurance";
    }
    else if (nSpell == SPELL_FOXS_CUNNING)
    {
        return "Fox's Cunning";
    }
    else if (nSpell == SPELL_FREEDOM_OF_MOVEMENT)
    {
        return "Freedom of Movement";
    }
    else if (nSpell == SPELL_MAGIC_CIRCLE_AGAINST_CHAOS)
    {
        return "Magic Circle against Chaos";
    }
    else if (nSpell == SPELL_MAGIC_CIRCLE_AGAINST_EVIL)
    {
        return "Magic Circle against Evil";
    }
    else if (nSpell == SPELL_MAGIC_CIRCLE_AGAINST_GOOD)
    {
        return "Magic Circle against Good";
    }
    else if (nSpell == SPELL_MAGIC_CIRCLE_AGAINST_LAW)
    {
        return "Magic Circle against Law";
    }
    else if (nSpell == SPELL_MONSTROUS_REGENERATION)
    {
        return "Monstrous Regeneration";
    }
    else if (nSpell == SPELL_NEGATIVE_ENERGY_PROTECTION)
    {
        return "Negative Energy Protection";
    }
    else if (nSpell == SPELL_OWLS_WISDOM)
    {
        return "Owl's Wisdom";
    }
    else if (nSpell == SPELL_PROTECTION__FROM_CHAOS)
    {
        return "Protection from Chaos";
    }
    else if (nSpell == SPELL_PROTECTION_FROM_EVIL)
    {
        return "Protection from Evil";
    }
    else if (nSpell == SPELL_PROTECTION_FROM_GOOD)
    {
        return "Protection from Good";
    }
    else if (nSpell == SPELL_PROTECTION_FROM_LAW)
    {
        return "Protection from Law";
    }
    else if (nSpell == SPELL_PROTECTION_FROM_ELEMENTS)
    {
        return "Protection from Elements";
    }
    else if (nSpell == SPELL_REGENERATE)
    {
        return "Regenerate";
    }
    else if (nSpell == SPELL_SANCTUARY)
    {
        return "Sanctuary";
    }
    else if (nSpell == SPELL_SHIELD_OF_FAITH)
    {
        return "Shield of Faith";
    }
    else if (nSpell == SPELL_SPELL_RESISTANCE)
    {
        return "Spell Resistance";
    }
    else if (nSpell == SPELL_TRUE_SEEING)
    {
        return "True Seeing";
    }
    else if (nSpell == SPELL_DARKVISION)
    {
        return "Darkvision";
    }
    else if (nSpell == SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE)
    {
        return "Clairaudience and Clairvoyance";
    }
    else if (nSpell == SPELL_DISPLACEMENT)
    {
        return "Displacement";
    }
    else if (nSpell == SPELL_HASTE)
    {
        return "Haste";
    }
    else if (nSpell == SPELL_IMPROVED_INVISIBILITY)
    {
        return "Improved Invisibility";
    }
    else if (nSpell == SPELL_INVISIBILITY)
    {
        return "Invisibility";
    }
    else if (nSpell == SPELL_IRONGUTS)
    {
        return "Ironguts";
    }
    else if (nSpell == SPELL_MAGE_ARMOR)
    {
        return "Mage Armor";
    }
    else if (nSpell == SPELL_MASS_HASTE)
    {
        return "Mass Haste";
    }
    else if (nSpell == SPELL_MIND_BLANK)
    {
        return "Mind Blank";
    }
    else if (nSpell == SPELL_PROTECTION_FROM_SPELLS)
    {
        return "Protection from Spells";
    }
    else if (nSpell == SPELL_SEE_INVISIBILITY)
    {
        return "See Invisibility";
    }
    else if (nSpell == SPELL_STONESKIN)
    {
        return "Stoneskin";
    }
    else if (nSpell == SPELL_AURA_OF_VITALITY)
    {
        return "Aura of Vitality";
    }
    else if (nSpell == SPELL_BARKSKIN)
    {
        return "Barkskin";
    }
    else if (nSpell == SPELL_MASS_CAMOFLAGE)
    {
        return "Mass Camouflage";
    }
    else if (nSpell == SPELL_OWLS_INSIGHT)
    {
        return "Owl's Insight";
    }
    else if (nSpell == SPELL_GREATER_MAGIC_WEAPON)
    {
        return "Greater Magic Weapon";
    }
    else if (nSpell == SPELL_MAGIC_WEAPON)
    {
        return "Magic Weapon";
    }
    else if (nSpell == SPELL_AMPLIFY)
    {
        return "Amplify";
    }

    return "INVALID SPELL";
}

//void main(){}

