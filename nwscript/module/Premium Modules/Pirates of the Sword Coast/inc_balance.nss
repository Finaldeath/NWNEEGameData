//::///////////////////////////////////////////////
//:: inc_balance
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This include file is used to autobalance NPCs
    and encounters based on the Party playing the
    adventure.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August, 2004
//:://////////////////////////////////////////////

// Called on PCs Exiting and entering the world to rebalance
// future creatures based on the party
void ReCalcGlobalDif();

// Warning: NPC must start at level 1 for this to work;
void LevelUpNPC(object oNPC);

void ReCalcGlobalDif()
{
    int iHitDice, iLevel, iPlayers;
    object oPC = GetFirstPC();

    while (GetIsObjectValid(oPC) == TRUE)
    {
        // Minimum of level 5 characters
        iHitDice = GetHitDice(oPC);
        if (iHitDice < 5)
        {
            iHitDice = 5;
        }

        iLevel += iHitDice;
        iPlayers++;
        oPC = GetNextPC();
    }

    SetLocalInt(GetModule(), "GLOBAL_LEVEL", (iLevel/iPlayers));
    //SendMessageToPC(GetFirstPC(), "**GLOBAL_LEVEL = " + IntToString(iLevel/iPlayers));
}

void EquipUpNPC(object oNPC)
{
    object oCArmor, oCWeaponR, oCWeaponL;
    object oArmor, oWeaponR, oWeaponL;

    int iLevel = GetHitDice(oNPC);
    int iBoss = GetLocalInt(oNPC, "BOSS");
    int iGameDiff = GetGameDifficulty();

    int iEnhancementMax = ((iLevel - 1) / 3) + 1;
    int iFactor = 0;
    int iEnhancement = 0;

    itemproperty ipWeapEnhance;
    itemproperty ipArmrEnhance;

// testing a different method of scaling,
// all NPCs will be equiped to their level.

/*    // Set a base factor in relation to the Game diffculty.
    switch (iGameDiff)
    {
        case GAME_DIFFICULTY_CORE_RULES:
        case GAME_DIFFICULTY_DIFFICULT:
            iFactor = 1;
        break;

        case GAME_DIFFICULTY_NORMAL:
        default:
            iFactor = 2;
        break;

        case GAME_DIFFICULTY_VERY_EASY :
        case GAME_DIFFICULTY_EASY :
            iFactor = 3;
        break;
    }

    if (iBoss == TRUE)
    {
        iFactor -= 1;
    }
*/

    // Calctulate the max enchancement
    iEnhancement = iEnhancementMax - iFactor;

    //SendMessageToPC(GetFirstPC(), "**OBJECT = " + GetTag(oNPC)
    //    + ", suggested enhancement level =" + IntToString(iEnhancement));

    if (iEnhancement > 0)
    {
        ipWeapEnhance = ItemPropertyEnhancementBonus(iEnhancement);
        ipArmrEnhance = ItemPropertyACBonus(iEnhancement);

        oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oNPC);
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
            AddItemProperty(DURATION_TYPE_PERMANENT, ipArmrEnhance, oArmor);
        }

        // Check the weapon and creature weapon and upgrade them
        if(GetIsObjectValid(oWeaponR) == FALSE)
        {
            oCWeaponR = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, oNPC);
            if(GetIsObjectValid(oCWeaponR) == TRUE)
            {
                AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance, oCWeaponR);
            }
        }
        else
        {
            AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance, oWeaponR);
        }

        // Check the other weapon and creature weapon and upgrade them
        if(GetIsObjectValid(oWeaponL) == FALSE)
        {
            oCWeaponL = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, oNPC);
            if(GetIsObjectValid(oCWeaponL) == TRUE)
            {
                AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance, oCWeaponL);
            }
        }
        else
        {
            AddItemProperty(DURATION_TYPE_PERMANENT, ipWeapEnhance, oWeaponL);
        }
    }
}

void LevelUpNPC(object oNPC)
{
    int iGlobalLevel = GetLocalInt(GetModule(), "GLOBAL_LEVEL");
    int iBoss = GetLocalInt(oNPC, "BOSS");
    int iGameDiff = GetGameDifficulty();
    int iLevel = 0;
    float fFactor = 0.0f;

    // Set a base factor in relation to the Game diffculty.
    switch (iGameDiff)
    {
        case GAME_DIFFICULTY_CORE_RULES:
        case GAME_DIFFICULTY_DIFFICULT:
            fFactor = 0.80f;
        break;

        case GAME_DIFFICULTY_NORMAL:
        default:
            fFactor = 0.60f;
        break;

        case GAME_DIFFICULTY_VERY_EASY :
        case GAME_DIFFICULTY_EASY :
            fFactor = 0.40f;
        break;
    }

    // Bosses should be tougher then average creatures.
    if (iBoss == TRUE)
    {
        fFactor += 0.40f;
    }

    iLevel = FloatToInt(iGlobalLevel * fFactor);
    //SendMessageToPC(GetFirstPC(), "**OBJECT = " + GetTag(oNPC)
    //    + ", Set to level =" + IntToString(iLevel));

    // Scale up the level according to the factor
    while (GetHitDice(oNPC) < iLevel)
    {
        if (LevelUpHenchman(oNPC, CLASS_TYPE_INVALID, TRUE) == 0)
        {
            // If Levelup Fails for whatever
            // reason break out of the loop
            break;
        }
    }

    ForceRest(oNPC);
    EquipUpNPC(oNPC);
}

