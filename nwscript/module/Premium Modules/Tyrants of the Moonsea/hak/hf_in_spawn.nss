// the "PJ" spawn system scales to the party's current configuration

#include "x0_i0_position"
#include "x0_i0_spawncond"
#include "hf_in_util"

// --------------------------------------------------------------------------
// Time Functions
// --------------------------------------------------------------------------

// return a unique integer timestamp for the current time in minutes
int SpawnGetCurrentTimeStamp()
{
    return ( GetCalendarYear()  * 483840 )
         + ( GetCalendarMonth() * 40320 )
         + ( GetCalendarDay()   * 1440 )
         + ( GetTimeHour()      * 60 )
         + ( GetTimeMinute());
}

// --------------------------------------------------------------------------
// Leveup Functions
// --------------------------------------------------------------------------

// boost creature equipment for its level (only non-droppable items)
void SpawnLevelupEquipment(object oNPC)
{
    object oCArmor, oCWeaponR, oCWeaponL;
    object oArmor, oWeaponR, oWeaponL;

    int iLevel = GetHitDice(oNPC);
    int iEnhancement = ((iLevel - 1) / 3) + 1;

    itemproperty ipWeapEnhance1, ipWeapEnhance2;
    itemproperty ipArmrEnhance;

    if (iEnhancement > 0)
    {
        ipWeapEnhance1 = ItemPropertyEnhancementBonus(iEnhancement);
        ipWeapEnhance2 = ItemPropertyAttackBonus(iEnhancement);
        ipArmrEnhance  = ItemPropertyACBonus(iEnhancement);

        oArmor   = GetItemInSlot(INVENTORY_SLOT_CHEST, oNPC);
        oWeaponR = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oNPC);
        oWeaponL = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oNPC);

        // Check the armor and creature skin and upgrade them
        if(GetIsObjectValid(oArmor) == FALSE)
        {
            oCArmor = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oNPC);
            if(GetIsObjectValid(oCArmor) == TRUE)
            {
                AddItemProperty(DURATION_TYPE_PERMANENT, ipArmrEnhance, oCArmor);
            }
        }
        else
        {
            if (!GetDroppableFlag(oArmor))
            {
                AddItemProperty(DURATION_TYPE_PERMANENT, ipArmrEnhance, oArmor);
            }
        }

        // Check the weapon and creature weapon and upgrade them
        if(GetIsObjectValid(oWeaponR) == FALSE)
        {
            oCWeaponR = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oNPC);
            if(GetIsObjectValid(oCWeaponR) == TRUE)
            {
                AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance1, oCWeaponR);
            }
        }
        else
        {
            if (!GetDroppableFlag(oWeaponR))
            {
                if (!GetWeaponRanged(oCWeaponR))
                    AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance1, oCWeaponR);
                else
                    AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance2, oCWeaponR);
            }
        }

        // Check the other weapon and creature weapon and upgrade them
        if(GetIsObjectValid(oWeaponL) == FALSE)
        {
            oCWeaponL = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oNPC);
            if(GetIsObjectValid(oCWeaponL) == TRUE)
            {
                AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance1, oCWeaponL);
            }
        }
        else
        {
            if (!GetDroppableFlag(oWeaponL))
            {
                if (!GetWeaponRanged(oCWeaponL))
                    AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance1, oWeaponL);
                else
                    AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance2, oWeaponL);
            }
        }

        // Check the other creature weapon
        object oCWeaponB = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, oNPC);
        if (GetIsObjectValid(oCWeaponB) == TRUE)
        {
            AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance1, oCWeaponB);
        }
    }
}

// make sure that a creature has at least nLevels
int SpawnLevelupCreature(object o, int nLevels)
{
    int j;
    int nLevelDelta = nLevels - GetHitDice(o);
    for (j = 1; j<= nLevelDelta; j++)
    {
        int n = LevelUpHenchman(o);
        if (n == 0)
            break;
    }
    ForceRest(o);
    SpawnLevelupEquipment(o);
    return(GetHitDice(o) == nLevels);
}

// --------------------------------------------------------------------------
// Calculate CR Functions
// --------------------------------------------------------------------------

// determine the level of an item
// could probably read these: Get2DAString("itemvalue", "MAXSINGLEITEMVALUE", nHD)
int SpawnGetItemLevel(object oItem)
{
    int nCost = GetGoldPieceValue(oItem);
    if (nCost == 0)         return 0;
    if (nCost <= 1000)      return 1;
    if (nCost <= 1500)      return 2;
    if (nCost <= 2500)      return 3;
    if (nCost <= 3500)      return 4;
    if (nCost <= 5000)      return 5;
    if (nCost <= 6500)      return 6;
    if (nCost <= 9000)      return 7;
    if (nCost <= 12000)     return 8;
    if (nCost <= 15000)     return 9;
    if (nCost <= 19500)     return 10;
    if (nCost <= 25000)     return 11;
    if (nCost <= 30000)     return 12;
    if (nCost <= 35000)     return 13;
    if (nCost <= 40000)     return 14;
    if (nCost <= 50000)     return 15;
    if (nCost <= 65000)     return 16;
    if (nCost <= 75000)     return 17;
    if (nCost <= 90000)     return 18;
    if (nCost <= 110000)    return 19;
    if (nCost <= 130000)    return 20;
    if (nCost <= 250000)    return 21;
    if (nCost <= 500000)    return 22;
    if (nCost <= 750000)    return 23;
    if (nCost <= 1000000)   return 24;
    if (nCost <= 1200000)   return 25;
    if (nCost <= 1400000)   return 26;
    if (nCost <= 1600000)   return 27;
    if (nCost <= 1800000)   return 28;
    if (nCost <= 2000000)   return 29;
    if (nCost <= 2200000)   return 30;
    if (nCost <= 2400000)   return 31;
    if (nCost <= 2600000)   return 32;
    if (nCost <= 2800000)   return 33;
    if (nCost <= 3000000)   return 34;
    if (nCost <= 3200000)   return 35;
    if (nCost <= 3400000)   return 36;
    if (nCost <= 3600000)   return 37;
    if (nCost <= 3800000)   return 38;
    if (nCost <= 4000000)   return 39;
    if (nCost <= 4200000)   return 40;
    if (nCost <= 4400000)   return 41;
    if (nCost <= 4600000)   return 42;
    if (nCost <= 4800000)   return 43;
    if (nCost <= 5000000)   return 44;
    if (nCost <= 5200000)   return 45;
    if (nCost <= 5400000)   return 46;
    if (nCost <= 5600000)   return 47;
    if (nCost <= 5800000)   return 48;
    if (nCost <= 6000000)   return 49;
    if (nCost <= 6200000)   return 50;
    if (nCost <= 6400000)   return 51;
    if (nCost <= 6600000)   return 52;
    if (nCost <= 6800000)   return 53;
    if (nCost <= 7000000)   return 54;
    if (nCost <= 7200000)   return 55;
    if (nCost <= 7400000)   return 56;
    if (nCost <= 7600000)   return 57;
    if (nCost <= 7800000)   return 58;
    if (nCost <= 8000000)   return 59;
    if (nCost <= 8200000)   return 60;
    return 61;
}

// determine the CR for a player/henchman/summons/etc.
// the CR is the max of their hit dice or the level of their weapons
int SpawnGetPlayerCR(object oPC)
{
    int nCR;
    object oItem;

    // assume that players are more powerful
    if (GetIsPC(oPC))
    {
        // a player character
        nCR = GetHitDice(oPC);
    }
    else
    {
        if (GetIsPlayableRacialType(oPC))
        {
            // probably a henchie
            nCR = 1 + GetHitDice(oPC)/8;
        }
        else
        {
            // summons, familiar, dominated, companion, etc.
            nCR = 1 + GetHitDice(oPC)/16;
        }
    }

    // what's in their primary weapon hand
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(oItem))
    {
        int n = SpawnGetItemLevel(oItem);
        if (n > nCR)
            nCR = n;
    }

    // what's in their secondary weapon hand
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    if (GetIsObjectValid(oItem))
    {
        int n = SpawnGetItemLevel(oItem);
        if (n > nCR)
            nCR = n;
    }

    // monks use gloves, so check that too
    if (GetLevelByClass(CLASS_TYPE_MONK, oPC) > 0)
    {
        oItem = GetItemInSlot(INVENTORY_SLOT_ARMS);
        if (GetIsObjectValid(oItem))
        {
            int n = SpawnGetItemLevel(oItem);
            if (n > nCR)
                nCR = n;
        }
    }

    return(nCR);
}

// adjust an encounter's CR for DC and game settings
int SpawnGetAdjustedCR(int nCR, int nDC)
{
    float fDiff = 1.0;
    switch (GetGameDifficulty())
    {
        case GAME_DIFFICULTY_CORE_RULES:
        case GAME_DIFFICULTY_DIFFICULT:
            fDiff = 1.0; // reduced from 2.0 after initial game feedback
        break;

        case GAME_DIFFICULTY_NORMAL:
        default:
            fDiff = 1.0;
        break;

        case GAME_DIFFICULTY_VERY_EASY :
        case GAME_DIFFICULTY_EASY :
            fDiff = 0.5;
        break;
    }

    return FloatToInt(fDiff * nCR * nDC / 50);
}

// determine the adjusted CR of the party (high DC = inflated CR)
int SpawnGetPartyCR(object oPC, int nDC)
{
    int nCR = 0;

    // sum the hit dice of all nearby faction members
    object o = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(o))
    {
        if (GetDistanceBetween(o, oPC) <= 30.0)
        {
            nCR += SpawnGetPlayerCR(o);
        }
        o = GetNextFactionMember(oPC, FALSE);
    }

    // adjust the CR for the DC
    return (SpawnGetAdjustedCR(nCR, nDC));
}

// --------------------------------------------------------------------------
// Placeable Functions
// --------------------------------------------------------------------------

// remove all "expired" placeables associated with this encounter
void SpawnRemovePlaceables(object oEnc, object oPC)
{
    string sTag = GetLocalString(oEnc, "HF_SP_PLACE_NAME");
    int i =  1;
    object oWP = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oWP))
    {
        object o = GetLocalObject(oWP, "HF_SP_PLACE_OBJ");
        if (GetIsObjectValid(o))
        {
            int nDur = GetLocalInt(oWP, "HF_SP_PLACE_DUR");
            if (nDur >= 0)
            {
                int nLast = GetLocalInt(oWP, "HF_SP_LAST_TIME");
                if (SpawnGetCurrentTimeStamp() >= nLast+nDur)
                {
                    DeleteLocalObject(oWP, "HF_SP_PLACE_OBJ");
                    DestroyObject(o);
                }
            }
        }
        oWP = GetObjectInArea(sTag, oPC, ++i);
    }
}

// create a single placeable
void SpawnPlaceable(object oPlc, object oPC)
{
    string sTag = GetLocalString(oPlc, "HF_SP_PLACE_TAG");
    if (sTag == "")
        sTag = GetName(oPlc);
    object o = CreateObject(OBJECT_TYPE_PLACEABLE, sTag, GetLocation(oPlc), FALSE, sTag);
    SetLocalObject(oPlc, "HF_SP_PLACE_OBJ", o);
    SetLocalInt(oPlc, "HF_SP_LAST_TIME", SpawnGetCurrentTimeStamp());
}

// create all placeables associated with this encounter
void SpawnPlaceables(object oEnc, object oPC)
{
    string sTag = GetLocalString(oEnc, "HF_SP_PLACE_NAME");
    int i =  1;
    object oWP = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oWP))
    {
        object o = GetLocalObject(oWP, "HF_SP_PLACE_OBJ");
        if (!GetIsObjectValid(o))
        {
            SpawnPlaceable(oWP, oPC);
        }
        oWP = GetObjectInArea(sTag, oPC, ++i);
    }
}

// --------------------------------------------------------------------------
// Action Functions
// --------------------------------------------------------------------------

// assign a "spawn in condition" (see x0_i0_spawncond) and heartbeat
void SpawnAssignSpawnCondition(object o, int nCondition)
{
    int nSpawnInConditions = GetLocalInt(OBJECT_SELF, sSpawnCondVarname);
    nSpawnInConditions = nSpawnInConditions | NW_FLAG_AMBIENT_ANIMATIONS;
    SetLocalInt(o, sSpawnCondVarname, nSpawnInConditions);
}

// assign programmed actions to a spawned creature
void SpawnAssignActions(object oEnc, object o, object oPC)
{
    if (GetLocalInt(oEnc, "HF_SP_CREATURES_FRIENDLY"))
    {
        ChangeToStandardFaction(o, STANDARD_FACTION_COMMONER);
    }
    if (GetLocalInt(oEnc, "HF_SP_CREATURES_HOSTILE"))
    {
        ChangeToStandardFaction(o, STANDARD_FACTION_HOSTILE);
    }
    if (GetLocalInt(oEnc, "HF_SP_ACTION_RANDOM_WALK"))
    {
        AssignCommand(o, ActionRandomWalk());
    }
    if (GetLocalInt(oEnc, "HF_SP_ACTION_ANIM_MOBILE"))
    {
        SpawnAssignSpawnCondition(o, NW_FLAG_AMBIENT_ANIMATIONS);
    }
    if (GetLocalInt(oEnc, "HF_SP_ACTION_ANIM_IMMOBILE"))
    {
        SpawnAssignSpawnCondition(o, NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    }
    if (GetLocalInt(oEnc, "HF_SP_ACTION_ANIM_AVIAN"))
    {
        SpawnAssignSpawnCondition(o, NW_FLAG_AMBIENT_ANIMATIONS_AVIAN);
    }
    if (GetLocalInt(oEnc, "HF_SP_ACTION_STEALTH"))
    {
         SpawnAssignSpawnCondition(o, NW_FLAG_STEALTH);
    }
}

// --------------------------------------------------------------------------
// Cleanup Functions
// --------------------------------------------------------------------------

// remove all creatures spawned by an encounter
void SpawnRemoveCreatures(object oEnc, object oPC)
{
    int i;
    int nMax = GetLocalInt(oEnc, "HF_SP_OBJ_NUM");
    for (i=1; i<=nMax; i++)
    {
        string sCreature = "HF_SP_OBJ_" + IntToString(i);
        object o = GetLocalObject(oEnc, sCreature);
        DeleteLocalObject(oEnc, sCreature);
        DestroyObject(o);
    }
}

// remove all creatures spawned by all encounters for this trigger
void SpawnRemoveAllCreatures(object oPC)
{
    // find the name of the encounters to cleanup
    string sName = GetLocalString(OBJECT_SELF, "HF_SP_NAME");
    if (sName == "")
        sName = GetName(OBJECT_SELF);
    string sEncName = "ENC_" + sName;

    // cleanup all encounters in this area with the same name
    int i = 1;
    object oEnc = GetObjectInArea(sEncName, oPC, i);
    while (GetIsObjectValid(oEnc))
    {
        SpawnRemoveCreatures(oEnc, oPC);
        oEnc = GetObjectInArea(sEncName, oPC, ++i);
    }
}

// --------------------------------------------------------------------------
// Location Functions
// --------------------------------------------------------------------------

location SpawnGetRandomLocation(location lOriginal, float fDistance, float fAngle)
{
    vector vOriginal = GetPositionFromLocation(lOriginal);
    vector vChanged;
    vChanged.z = vOriginal.z;
    vChanged.x = vOriginal.x + GetChangeInX(fDistance, fAngle);
    if (vChanged.x < 0.0)
        vChanged.x = - vChanged.x;
    vChanged.y = vOriginal.y + GetChangeInY(fDistance, fAngle);
    if (vChanged.y < 0.0)
        vChanged.y = - vChanged.y;
    return Location(GetAreaFromLocation(lOriginal), vChanged, -fAngle);
}

// --------------------------------------------------------------------------
// Encounter Functions
// --------------------------------------------------------------------------

// pick a random spawn point hopefully out of visible range
location SpawnGetBestSpawnLocation(object oEnc, object oPC, float fDist)
{
    // should we just use the override distance?
    if (fDist > 0.0)
    {
        float fDir = GetFacing(oPC);
        float fAngleOpposite = GetOppositeDirection(fDir);
        return GenerateNewLocation(oPC, fDist, fAngleOpposite, fDir);
    }

    string sTag = GetLocalString(oEnc, "HF_SP_WAYPOINT_NAME");
    object oResult = OBJECT_INVALID;

    // identify candidate spawnpoints within range
    float fDistMax = 0.0;
    int n = 0;
    int i = 1;
    object oMax = OBJECT_INVALID;
    object oWP = GetObjectInArea(sTag, oPC, i);
    while (GetIsObjectValid(oWP))
    {
        float fDist = GetDistanceBetween(oWP, oPC);
        if (fDist > fDistMax)
        {
            fDistMax = fDist;
            oMax = oWP;
        }
        if (fDist > 20.0)
        {
            SetLocalObject(oEnc, "HF_SP_WP_"+IntToString(++n), oWP);
        }
        oWP = GetObjectInArea(sTag, oPC, ++i);
    }

    // choose a candidate randomly, or the most distant one if no candidates
    if (n > 0)
    {
        int nChoice = Random(n)+1;
        oResult = GetLocalObject(oEnc, "HF_SP_WP_"+IntToString(nChoice));
    }
    else
    {
        oResult = oMax;
    }

    // default to the location of the encounter if we didn't find anything
    if (!GetIsObjectValid(oResult))
        oResult = oEnc;
    return(GetLocation(oResult));
}

// convert a string list into an array
int SpawnTokenizeList(object oEnc, string sList)
{
    int nSize = GetLocalInt(oEnc, "HF_SP_CREATURES_NUM");
    if (nSize == 0)
    {
        while(TRUE)
        {
            int nPos = FindSubString(sList, ",");
            if (nPos <= 0)
            {
                SetLocalString(oEnc, "HF_SP_C_"+IntToString(++nSize), sList);
                break;
            }
            string s = GetStringLeft(sList, nPos);
            sList = GetStringRight(sList, GetStringLength(sList) - nPos - 1);
            SetLocalString(oEnc, "HF_SP_C_"+IntToString(++nSize), s);
        }
    }
    return(nSize);
}

// pick a random list from the (A,B,C,D) lists at this level
string SpawnChooseCreatureList(object oEnc, int nListNum)
{
    // setup list prefix
    string sListPrefix = "HF_SP_CREATURES_LIST";
    if (nListNum > 0)
        sListPrefix += "_" + IntToString(nListNum);

    // count number of alternate lists available
    int nMax = 0;
    if (GetLocalString(oEnc, sListPrefix+"_A") != "") nMax++;
    if (GetLocalString(oEnc, sListPrefix+"_B") != "") nMax++;
    if (GetLocalString(oEnc, sListPrefix+"_C") != "") nMax++;
    if (GetLocalString(oEnc, sListPrefix+"_D") != "") nMax++;

    // select a list, either random or pre-defined
    string sList;
    string sListUse = GetLocalString(oEnc, "HF_SP_CREATURES_LIST_USE");
    if (sListUse != "")
    {
        sList = sListPrefix + "_" + sListUse;
    }
    else
    {
        int n = Random(nMax)+1;
        if      (n == 1) sList = sListPrefix;
        else if (n == 2) sList = sListPrefix+"_A";
        else if (n == 3) sList = sListPrefix+"_B";
        else if (n == 4) sList = sListPrefix+"_C";
        else if (n == 5) sList = sListPrefix+"_D";
    }
    return(GetLocalString(oEnc, sList));
}

// find the best creature list for this party and requested difficulty
string SpawnGetCreatureList(object oEnc, int nDC, int nCR)
{
    string sList;
    int n = 0;
    int i;
    int nListSize = GetLocalInt(GetModule(), "HF_SP_CREATURES_LIST_CR_NUM");
    for (i=nListSize; i>=1; i--)
    {
        int nListCR = GetLocalInt(GetModule(), "HF_SP_CREATURES_LIST_CR_"+IntToString(i));
        if (nCR >= nListCR)
        {
            string sName = "HF_SP_CREATURES_LIST_" + IntToString(i);
            sList = GetLocalString(oEnc, sName);
            if (sList != "")
            {
                n = i;
                break;
            }
        }
    }
    return(SpawnChooseCreatureList(oEnc, n));
}

// spawn random creatures at a location
void SpawnCreatures(object oEnc, location lLoc, object oPC)
{
    // compute party's adjusted CR
    int nDC = GetLocalInt(oEnc, "HF_SP_DIFFICULTY");
    if (nDC <= 0) nDC = 1;
    if (nDC > 100) nDC = 100;
    int nCR = SpawnGetPartyCR(oPC, nDC);

    // tokenize the best creature list for this party
    string sList = SpawnGetCreatureList(oEnc, nDC, nCR);
    int nListSize = SpawnTokenizeList(oEnc, sList);
    if (nListSize <= 0)
        return;

    // choose a random number of creatures
    int nMinCreatures = GetLocalInt(oEnc, "HF_SP_CREATURES_MIN");
    int nMaxCreatures = GetLocalInt(oEnc, "HF_SP_CREATURES_MAX");
    int nNumCreatures = nMinCreatures + Random(nMaxCreatures-nMinCreatures+1);
    if (nNumCreatures <= 0)
        nNumCreatures = 1;
    if (nNumCreatures > 15)
        nNumCreatures = 15;

    // adjust min and max for all creatures mode
    int nAllCreatures = GetLocalInt(oEnc, "HF_SP_CREATURES_ALL");
    if (nAllCreatures > 0)
    {
        nNumCreatures = nListSize;
    }

    // spawn creatures at given location
    float fRandomizeLocation = GetLocalFloat(oEnc, "HF_SP_LOC_RANDOMIZE");
    string sNewTag = GetLocalString(oEnc, "HF_SP_CREATURES_TAG");
    int nAppearAnim = GetLocalInt(oEnc, "HF_SP_ACTION_APPEAR");
    int nTotalCreatureHitDice = 0;
    int i;
    for (i=1; i<=nNumCreatures; i++)
    {
        int n = Random(nListSize) + 1;
        if (nAllCreatures)
        {
            n = i;
        }
        string sTag = GetLocalString(oEnc, "HF_SP_C_"+IntToString(n));
        if (GetLocalInt(oEnc, "HF_SP_LIMIT_UNIQUE"))
        {
            object oDup = GetObjectInArea(sTag, oEnc);
            if (GetIsObjectValid(oDup))
            {
                continue;
            }
        }
        location lSpawnLoc = lLoc;
        if (fRandomizeLocation > 0.0)
        {
            float fAngle = IntToFloat(Random(140) + 40);
            lSpawnLoc = SpawnGetRandomLocation(lLoc, fRandomizeLocation, fAngle);
        }
        object o = CreateObject(OBJECT_TYPE_CREATURE, sTag, lSpawnLoc, nAppearAnim, sNewTag);
        SetLocalObject(oEnc, "HF_SP_OBJ_" + IntToString(i), o);
        nTotalCreatureHitDice += GetHitDice(o);
        SpawnAssignActions(oEnc, o, oPC);
    }
    SetLocalInt(oEnc, "HF_SP_OBJ_NUM", nNumCreatures);

    // compute the level delta for each creature
    float fScale = 1.0 - 0.1 * (nNumCreatures - 1);
    if (fScale <= 0.1) fScale = 0.1;
    int nLevelDelta = FloatToInt((nCR - nTotalCreatureHitDice) / (nNumCreatures * fScale));
    int nLevelMin = GetLocalInt(oEnc, "HF_SP_LIMIT_LEVELUP_MIN");
    if (nLevelMin >= 0)
    {
        if (nLevelDelta < nLevelMin)
        {
            nLevelDelta = nLevelMin;
        }
    }
    int nLevelMax = GetLocalInt(oEnc, "HF_SP_LIMIT_LEVELUP_MAX");
    if (nLevelMax > 0)
    {
        if (nLevelDelta > nLevelMax)
        {
            nLevelDelta = nLevelMax;
        }
    }

    // level-up creatures to meet target CR
    int nLevelUpChance = GetLocalInt(oEnc, "HF_SP_CHANCE_LEVELUP");
    if (nLevelUpChance > 0)
    {
        for (i = 1; i<=nNumCreatures; i++)
        {
            object o = GetLocalObject(oEnc, "HF_SP_OBJ_"+IntToString(i));
            int nLevels = GetLocalInt(oEnc, "HF_SP_LIMIT_LEVELUP");
            if (nLevels <= 0)
            {
                nLevels = GetHitDice(o) + nLevelDelta;
            }
            SpawnLevelupCreature(o, nLevels);
        }
    }
}

// check if we should spawn this encounter
int SpawnCheckEncounter(object oEnc, object oPC)
{
    // is this encounter already done?
    int nChance = GetLocalInt(oEnc, "HF_SP_CHANCE_OCCUR");
    if (nChance <= 0)
        return(FALSE);

    // roll random chance of not giving this encounter
    if (d100() > nChance)
        return(FALSE);

    // is it the correct time of day?
    if (GetLocalInt(oEnc, "HF_SP_LIMIT_DAY") != 0)
    {
        if (GetIsNight())
            return(FALSE);
    }
    if (GetLocalInt(oEnc, "HF_SP_LIMIT_NIGHT") != 0)
    {
        if (GetIsDay())
            return(FALSE);
    }

    // is it too soon to redo this encounter?
    int nLastTime = GetLocalInt(oEnc, "HF_SP_LAST_TIME");
    if (nLastTime > 0)
    {
        int nNextTime = nLastTime + GetLocalInt(oEnc, "HF_SP_LIMIT_REOCCUR");
        if (nNextTime > SpawnGetCurrentTimeStamp())
        {
            return(FALSE);
        }
    }

    // should we evaluate a condition before triggering?
    string sCondition = GetLocalString(oEnc, "HF_SP_LIMIT_SCRIPT");
    if (sCondition != "")
    {
        DeleteLocalInt(oEnc, "HF_RETVAL");
        ExecuteScript(sCondition, oEnc);
        int nRet = GetLocalInt(oEnc, "HF_RETVAL");
        DeleteLocalInt(oEnc, "HF_RETVAL");
        if (nRet <= 0)
        {
            return(FALSE);
        }
    }

    return(TRUE);
}

// spawn random creatures at a random spawnpoint
int SpawnEncounter(object oEnc, object oPC, int nForce=FALSE)
{
    // remove old placeables
    SpawnRemovePlaceables(oEnc, oPC);

    // is this encounter already done? (forced encounters always occur)
    if (nForce == FALSE)
    {
        int nChance = GetLocalInt(oEnc, "HF_SP_CHANCE_OCCUR");
        if (nChance <= 0)
            return(FALSE);
    }

    // clean previous spawns
    if (GetLocalInt(oEnc, "HF_SP_CREATURES_CLEANUP") != 0)
    {
        SpawnRemoveCreatures(oEnc, oPC);
    }

    // check if we should run the encounter (forced encouters always occur)
    if (nForce == FALSE)
    {
        if (!SpawnCheckEncounter(oEnc, oPC))
        {
            return(FALSE);
        }
    }

    // find the best spawnpoint
    float fDist = GetLocalFloat(oEnc, "HF_SP_LIMIT_DISTANCE_NEAR");
    location lLoc = SpawnGetBestSpawnLocation(oEnc, oPC, fDist);

    // spawn some creatures at the spawnpoint
    SpawnCreatures(oEnc, lLoc, oPC);

    // spawn placeables (if any)
    SpawnPlaceables(oEnc, oPC);

    // note this encounter is done
    if (GetLocalInt(oEnc, "HF_SP_LIMIT_REOCCUR") <= 0)
    {
        SetLocalInt(oEnc, "HF_SP_CHANCE_OCCUR", -100);
    }
    else
    {
        SetLocalInt(oEnc, "HF_SP_LAST_TIME", SpawnGetCurrentTimeStamp());
    }
    return(TRUE);
}

// spawn all encounters associated with this trigger
void SpawnEnter(object oPC, object oTrg=OBJECT_SELF)
{
    // do nothing if we are disabled
    if (GetLocalInt(oTrg, "HF_SP_DISABLE"))
    {
        return;
    }

    // find the name of the encounters to trigger
    string sName = GetLocalString(oTrg, "HF_SP_NAME");
    if (sName == "")
        sName = GetName(oTrg);
    string sEncName = "ENC_" + sName;

    // trigger all encounters in this area with the same name
    int i = 1;
    object oEnc = GetObjectInArea(sEncName, oPC, i);
    while (GetIsObjectValid(oEnc))
    {
        SetLocalString(oEnc, "HF_SP_WAYPOINT_NAME", "SP_"+sName);
        SetLocalString(oEnc, "HF_SP_PLACE_NAME", "PL_"+sName);
        SpawnEncounter(oEnc, oPC);
        oEnc = GetObjectInArea(sEncName, oPC, ++i);
    }

    // log an error if we didn't find any matching encounters
    // .. the player might not have "entered the area fully"
    // .. so we retry a few times before giving up
    if (i <= 1)
    {
        int n = GetLocalInt(oTrg, "HF_SP_INIT_COUNTER");
        if (n <= 40)
        {
            SetLocalInt(oTrg, "HF_SP_INIT_COUNTER", ++n);
            DelayCommand(0.25, SpawnEnter(oPC, oTrg));
        }
        else
        {
            SendMessageToPC(GetFirstPC(), "ERROR: could not find encounter '"+sName+
                                          "' in area '"+GetTag(oTrg)+
                                          "' for player '"+GetName(oPC)+
                                          "' in area '"+GetTag(GetArea(oPC))+"'");
        }
    }
    else
    {
        // reset the counter in case we trigger this encounter again
        SetLocalInt(oTrg, "HF_SP_INIT_COUNTER", 0);
    }
}

/*
INSTRUCTIONS
-----------

1. Name your trigger or area
   - Set variable HF_SP_NAME or just use the standard object name field.
     All encounters with this name are triggered when PC enters the trigger / area.

2. Place one or more encounter waypoints anywhere in the area. Tag must be ENC_name.
   - Edit the variables on the encounter waypoint

3. Optionally place one or more spawn points. Tag must be SP_name.
   One of the spawnpoints which is at least 20m from the PC will be randomly chosen.
   If no spawnpoints are 20m away, the furthest one will be used.
   If there are no valid spawnpoints at all, the location of the Encounter is used.

4. Optionally, place one or more placeable points. Tag must be PL_name.

5. Optionally, encounters can use different creature lists depending on the adjusted
   CR of the party that tripped the encounter. The "adjusted CR" is roughly equal to
   the total hit dice of the party fudged up or down x2 based on the encounter DC.
    - First, decide how many creature lists you want.
    - Next, decide the CR range of each list.
    - Finally, set module variables to map list number to CR range.

NOTES
-----

1. More than one trigger can control the same encounter. This is useful for areas where
   you don't know which trigger the PC will hit first.
2. One trigger can trip more than one encounter. Say you wanted a group of bandits
   hiding in the bushes and a group of orcs hiding in the trees.
3. Each encounter can have more than one spawn point to provide some randomness.
4. Creatures are leveled up to the PC's level, so avoid mixing really high level
   creatures with really low-level creatures in the same encounter.

DATA MODEL
----------

MODULE:
- HF_SP_CREATURES_LIST_CR_NUM
   This is the number of spawn lists per encounter. This is only useful
   if you want to use more than one spawn list per encounter.
- HF_SP_CREATURES_LIST_CR_1 ... N
   This defines the upper CR value for each spawn list.
   This is only useful if you want to use more than one spawn list
   per encounter.

TRIGGER:
- HF_SP_NAME
   This defines the name of the associated encounter waypoint(s) as
   ENC_name, associated spawn waypoints as SP_name, and associated
   placeable waypoints as PL_name. If not set, the actual object
   name is used instead.
- HF_SP_DISABLE
   When set to 1, no encounters will be spawned by this trigger.

ENCOUNTER WAYPOINT:
- HF_SP_LIMIT_DAY
   Set to 1 for day-only spawns
- HF_SP_LIMIT_NIGHT
   Set to 1 for night-only spawns
- HF_SP_LIMIT_REOCCUR
   Mininum number of minutes to wait between respawns. If set to zero
   the encounter will only occur once.
- HF_SP_LIMIT_UNIQUE
   Set to 1 if you want to prevent spawns when another object in this
   area has the same tag as the spawn.
- HF_SP_LIMIT_LEVELUP
   If set, all creatures in the encounter will level-up to this value.
   Otherwise, the system will level them up automatically.
- HF_SP_LIMIT_LEVELUP_MIN
   If set to a non-zero value, this is the minimum level gain for
   each creature in the encounter.
- HF_SP_LIMIT_LEVELUP_MAX
   If set to a non-zero value, this is the maximum level gain for
   each creature in the encounter.
- HF_SP_LIMIT_DISTANCE_NEAR
   If set to a non-zero value, the spawn will always occur near
   the player (this probably only makes sense for rest encounters).
- HF_SP_LIMIT_SCRIPT
   If set to a script name, that script must set variable HF_RETVAL
   on OBJECT_SELF to 1 in order to trigger the encounter
- HF_SP_ACTION_RANDOM_WALK
   If set to a non-zero value, the spawn will randomly walk around.
- HF_SP_ACTION_ANIM_MOBILE
   If set to a non-zero value, the spawn will play mobile anims.
- HF_SP_ACTION_ANIM_IMMOBILE
   If set to a non-zero value, the spawn will play immobile anims.
- HF_SP_ACTION_ANIM_AVIAN
   If set to a non-zero value, the spawn will play avian animations.
- HF_SP_ACTION_APPEAR
   If set to a non-zero value, the spawn will play its appear animation.
- HF_SP_ACTION_STEALTH
   If set to a non-zero value, the spawn will enter stealth mode.
- HF_SP_CHANCE_OCCUR
   Percentage chance (1-100) of this encounter occuring.
- HF_SP_CHANCE_LEVELUP
   Set to 0 if you don't want levelup of creatures.
- HF_SP_DIFFICULTY
   Set between 1 (easy) and 100 (hard). This determines how much
   levelup the spawned creatures are given. If you do not allow
   levelup, the DC isn't meaningful.
- HF_SP_CREATURES_LIST
   Comma-separated list of blueprints to spawn. Selection from this
   list is random.
- HF_SP_CREATURES_LIST_1 ... N
   More lists of blueprints (table by CR)
- HF_SP_CREATURES_LIST_1_A
   Alternative lists (A,B,C,D) at each level. A list is selected
   randomly if defined.
- HF_SP_CREATURES_LIST_USE
   If set to a value (A,B,C,D), this list will always be used.
   Otherwise one of the lists is randomly chosen.
- HF_SP_CREATURES_ALL
   If set to true, all creatures from the list will be spawned at once.
- HF_SP_CREATURES_MIN
   Minimum number of creatures to spawn.
- HF_SP_CREATURES_MAX
   Maximum number of creatures to spawn.
- HF_SP_CREATURES_CLEANUP
   If set to true, creatures previously spawned by this encounter
   will be destroyed before any new creatures are spawned.
- HF_SP_CREATURES_FRIENDLY
   If set to true, all creatures are spawned into the COMMONER
   faction. Hopefully the player is friendly to commoners.
- HF_SP_CREATURES_HOSTILE
   If set to true, all creatures are spawned into the HOSTILE faction.
- HF_SP_CREATURES_TAG
   If set to a string, this will be the tag of all creatures spawned.
- HF_SP_LOC_RANDOMIZE
   If set to a positive distance, the spawn location of each creature
   is randomized by this amount.

PLACEABLE WAYPOINT:
- HF_SP_PLACE_TAG
   Tag of placeable to spawn here.
- HF_SP_PLACE_DUR
   Amount of time placeable should stick around (minutes). Placeables
   are never removed when the PC is nearby of course.

SPAWN WAYPOINT:
- (no need to set any variables here)

*/
