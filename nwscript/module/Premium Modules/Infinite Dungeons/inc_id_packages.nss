//::///////////////////////////////////////////////
//:: Name: Packages Include File
//:: FileName: inc_id_packages
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This include file helps to access the packages listed in the id_encounter.2da
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: July 11, 2005
//:://////////////////////////////////////////////
#include "inc_id_misctools"

// Returns a PACKAGE_<CLASS>_*
// The * may be either a ENEMY or GUARDIAN package.
// oCreature is only used to determine special packages for clerics and fighters.
int GetGuardianEnemyPackage(int nClass, object oCreature = OBJECT_INVALID);

// Since the NWN default level up system only works on creatures that start
// at level 1 we must create new blueprints of  all the creatures we will be using in ID.
// This function is meant to bring the creatures levels back up to "canon" levels.
// Levels up the creature to it's proper base level.
void LevelUpCreatureToBase(object oCreature,int nLevel);

// Returns TRUE if oCreature has a PC class
// Returns -1 if "HAS_LEVEL_UP_CLASS" has been set to TRUE on oCreature.
// Returns -2 If neither of the above is true.
int GetHasPCLevelUpClass(object oCreature = OBJECT_SELF);

// Returns the CLASS_* variable set on the creature, this variable must
// be stores as an int value on the creature as "LEVEL_UP_CLASS".
int GetClassFromCreature(object oCreature = OBJECT_SELF);

// If HAS_LEVEL_UP_CLASS_2 has been set to TRUE this function returns the value
// of LEVEL_UP_CLASS_2.
// Returns -1 if HAS_LEVEL_UP_CLASS_2 is FALSE.
int GetIsMultiClassCreature(object oCreature = OBJECT_SELF);











// Returns a <CLASS>_NONE Package to be used by LevelUpHenchman.
int GetBaseLevelUpPackage(int nClass);














int GetGuardianEnemyPackage(int nClass, object oCreature)
    {
    int nPackage,nRace;
    string sTag;
    // Get the proper base level up package.
    switch (nClass)
        {
        case CLASS_TYPE_ABERRATION:     {nPackage = PACKAGE_ABERATION_GUARDIAN;break;}
        case CLASS_TYPE_ANIMAL:         {nPackage = PACKAGE_ANIMAL_GUARDIAN;break;}
        case CLASS_TYPE_BARBARIAN:      {nPackage = PACKAGE_BARBARIAN_ENEMY;break;}
        case CLASS_TYPE_BARD:           {nPackage = PACKAGE_BARD_ENEMY;break;}
        case CLASS_TYPE_BEAST:          {nPackage = PACKAGE_BEAST_GUARDIAN;break;}
        case CLASS_TYPE_COMMONER:       {nPackage = PACKAGE_COMMONER_GUARDIAN;break;}
        case CLASS_TYPE_CONSTRUCT:      {nPackage = PACKAGE_CONSTRUCT_GUARDIAN;break;}
        case CLASS_TYPE_DRAGON:         {nPackage = PACKAGE_DRAGON_GUARDIAN;break;}
        case CLASS_TYPE_DRUID:          {nPackage = PACKAGE_DRUID_ENEMY;break;}
        case CLASS_TYPE_ELEMENTAL:      {nPackage = PACKAGE_ELEMENTAL_GUARDIAN;break;}
        case CLASS_TYPE_FEY:            {nPackage = PACKAGE_FEY_GUARDIAN;break;}
        case CLASS_TYPE_GIANT:          {nPackage = PACKAGE_GIANT_GUARDIAN;break;}
        case CLASS_TYPE_HUMANOID:       {nPackage = PACKAGE_HUMANOID_GUARDIAN;break;}
        case CLASS_TYPE_MAGICAL_BEAST:  {nPackage = PACKAGE_MAGICBEAST_GUARDIAN;break;}
        case CLASS_TYPE_MONK:           {nPackage = PACKAGE_MONK_ENEMY;break;}
        case CLASS_TYPE_MONSTROUS:      {nPackage = PACKAGE_MONTROUS_GUARDIAN;break;}
        case CLASS_TYPE_OUTSIDER:       {nPackage = PACKAGE_OUTSIDER_GUARDIAN;break;}
        case CLASS_TYPE_PALADIN:        {nPackage = PACKAGE_PALADIN_ENEMY;break;}
        case CLASS_TYPE_RANGER:         {nPackage = PACKAGE_RANGER_ENEMY;break;}
        case CLASS_TYPE_ROGUE:          {nPackage = PACKAGE_ROGUE_ENEMY;break;}
        case CLASS_TYPE_SHAPECHANGER:   {nPackage = PACKAGE_SHAPECHANGER_GUARDIAN;break;}
        case CLASS_TYPE_SORCERER:       {nPackage = PACKAGE_SORCERER_ENEMY;break;}
        case CLASS_TYPE_UNDEAD:         {nPackage = PACKAGE_UNDEAD_GUARDIAN;break;}
        case CLASS_TYPE_VERMIN:         {nPackage = PACKAGE_VERMIN_GUARDIAN;break;}
        case CLASS_TYPE_WIZARD:         {nPackage = PACKAGE_WIZARD_ENEMY;break;}
        case CLASS_TYPE_OOZE:           {nPackage = PACKAGE_OOZE_GUARDIAN;break;}
        case CLASS_TYPE_CLERIC:
            {
                nPackage = PACKAGE_CLERIC_LLOTH;
                if (GetIsObjectValid(oCreature))
                {
                    // Consider Racial check instead of tags.
                    sTag = GetTag(oCreature);
                    // Add Special Cleric packages here!

                    nPackage = PACKAGE_CLERIC_LLOTH; //Defaulted.
                }
                break;
            }
        case CLASS_TYPE_FIGHTER:
            {
                nPackage = PACKAGE_FIGHTER_ENEMY;
                if (GetIsObjectValid(oCreature))
                {
                    if (GetAbilityModifier(ABILITY_DEXTERITY,oCreature) >   GetAbilityModifier(ABILITY_STRENGTH,oCreature))
                    {
                     nPackage = PACKAGE_FIGHTER_DEX_ENEMY;
                    }
                }
                break;
            }
        };

    return nPackage;
    }



void LevelUpCreatureToBase(object oCreature,int nLevel)
    {
    int nHD = GetHitDice(oCreature);
    if (GetIsPC(oCreature)
     || GetIsObjectValid(GetMaster(oCreature))
     || nHD != 1)
    {
        if (nLevel == -1) // Special rule for Formian Queen
        {
            LevelUpCreatureToBase(oCreature,20);
            int n;
            for (n = 1; n <= 17; n++)
            {
                if (n == 17)
                {
                    LevelUpHenchman(oCreature,CLASS_TYPE_SORCERER,TRUE,PACKAGE_SORCERER_NONE);
                }
                else
                {
                    LevelUpHenchman(oCreature,CLASS_TYPE_SORCERER,FALSE,PACKAGE_SORCERER_NONE);
                }
            }
        }
    else // Non-Special Rule.
        {
            // Don't try this on PC's or Associates.
            // This will also fail if the creature has a higher level than 1 before starting.
            return;
        }
    }
    // Since creatures should always be level 1 only check the first class.
    int nClass = GetClassByPosition(1,oCreature);
    // Get the <CLASS>_NONE package to be used.
    int nPackage = GetBaseLevelUpPackage(nClass);
    // Level up the NPC to its base level.
    int nLevelUp;
    //
    while (nHD < nLevel)
    {
        if (nHD == nLevel - 1)
        {// If this is the last level up prep the spells.
            nLevelUp = LevelUpHenchman(oCreature,nClass,TRUE,nPackage);
        }
        else
        {
            nLevelUp = LevelUpHenchman(oCreature,nClass,FALSE,nPackage);
        }
        if(nHD == nLevelUp)
        {
            WriteTimestampedLogEntry("Error in LevelUpCreatureToBase, inc_id_packages.");
            break; //ERROR THIS SHOULD NEVER HAPPEN!
        }
    nHD = nLevelUp;
    }
}

int GetHasPCLevelUpClass(object oCreature)
{
    if (GetLocalInt(oCreature, HAS_LEVEL_UP_CLASS))
    {
        return -1;
    }
    int nClass,nHasClass;
    for (nClass = 0; nClass <= 38; nClass++)
    {
        switch (nClass)
        {
            case CLASS_TYPE_ARCANE_ARCHER:
            case CLASS_TYPE_ASSASSIN:
            case CLASS_TYPE_BARBARIAN:
            case CLASS_TYPE_BARD:
            case CLASS_TYPE_BLACKGUARD:
            case CLASS_TYPE_CLERIC:
            case CLASS_TYPE_DIVINE_CHAMPION:
            case CLASS_TYPE_DRAGON_DISCIPLE:
            case CLASS_TYPE_DRUID:
            case CLASS_TYPE_DWARVEN_DEFENDER:
            case CLASS_TYPE_FIGHTER:
            case CLASS_TYPE_HARPER:
            case CLASS_TYPE_MONK:
            case CLASS_TYPE_PALADIN:
            case CLASS_TYPE_PALE_MASTER:
            case CLASS_TYPE_RANGER:
            case CLASS_TYPE_ROGUE:
            case CLASS_TYPE_SHADOWDANCER:
            case CLASS_TYPE_SHIFTER:
            case CLASS_TYPE_SORCERER:
            case CLASS_TYPE_WEAPON_MASTER:
            case CLASS_TYPE_WIZARD:
            {
                nHasClass = GetLevelByClass(nClass, oCreature);
                if (nHasClass)
                {
                    return nClass;
                }
            }
        };
    }
return -2;
}

int GetClassFromCreature(object oCreature)
{
    return GetLocalInt(oCreature,LEVEL_UP_CLASS);
}

int GetIsMultiClassCreature(object oCreature)
{
    if (GetLocalInt(oCreature,HAS_LEVEL_UP_CLASS_2))
    {
    return GetLocalInt(oCreature,LEVEL_UP_CLASS_2);
    }
return -1;
}






int GetBaseLevelUpPackage(int nClass)
{
    switch (nClass)
    {
        case CLASS_TYPE_ABERRATION:
            return PACKAGE_ABERATION_NONE;

            break;
        case CLASS_TYPE_ANIMAL:
            return PACKAGE_ANIMAL_NONE;

            break;
        case CLASS_TYPE_BARBARIAN:
            return PACKAGE_BARBARIAN_NONE;

            break;
        case CLASS_TYPE_BARD:
            return PACKAGE_BARD_NONE;

            break;
        case CLASS_TYPE_BEAST:
            return PACKAGE_BEAST_NONE;

            break;
        case CLASS_TYPE_CLERIC:
            return PACKAGE_CLERIC_NONE;

            break;
        case CLASS_TYPE_COMMONER:
            return PACKAGE_COMMONER_NONE;

            break;
        case CLASS_TYPE_CONSTRUCT:
            return PACKAGE_CONSTRUCT_NONE;

            break;
        case CLASS_TYPE_DRAGON:
            return PACKAGE_DRAGON_NONE;

            break;
        case CLASS_TYPE_DRUID:
            return PACKAGE_DRUID_NONE;

            break;
        case CLASS_TYPE_ELEMENTAL:
            return PACKAGE_ELEMENTAL_NONE;

            break;
        case CLASS_TYPE_FEY:
            return PACKAGE_FEY_NONE;

            break;
        case CLASS_TYPE_FIGHTER:
            return PACKAGE_FIGHTER_NONE;

            break;
        case CLASS_TYPE_GIANT:
            return PACKAGE_GIANT_NONE;

            break;
        case CLASS_TYPE_HUMANOID:
            return PACKAGE_HUMANOID_NONE;

            break;
        case CLASS_TYPE_MAGICAL_BEAST:
            return PACKAGE_MAGICBEAST_NONE;

            break;
        case CLASS_TYPE_MONK:
            return PACKAGE_MONK_NONE;

            break;
        case CLASS_TYPE_MONSTROUS:
            return PACKAGE_MONTROUS_NONE;

            break;
        case CLASS_TYPE_OUTSIDER:
            return PACKAGE_OUTSIDER_NONE;

            break;
        case CLASS_TYPE_PALADIN:
            return PACKAGE_PALADIN_NONE;

            break;
        case CLASS_TYPE_RANGER:
            return PACKAGE_RANGER_NONE;

            break;
        case CLASS_TYPE_ROGUE:
            return PACKAGE_ROGUE_NONE;

            break;
        case CLASS_TYPE_SHAPECHANGER:
            return PACKAGE_SHAPECHANGER_NONE;

            break;
        case CLASS_TYPE_SORCERER:
            return PACKAGE_SORCERER_NONE;

            break;
        case CLASS_TYPE_UNDEAD:
            return PACKAGE_UNDEAD_NONE;

            break;
        case CLASS_TYPE_VERMIN:
            return PACKAGE_VERMIN_NONE;

            break;
        case CLASS_TYPE_WIZARD:
            return PACKAGE_WIZARD_NONE;

            break;
        case CLASS_TYPE_OOZE:
            return PACKAGE_OOZE_NONE;

            break;
    }

    return 0;
}




//void main(){}

