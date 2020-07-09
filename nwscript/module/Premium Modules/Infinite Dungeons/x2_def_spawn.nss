//::///////////////////////////////////////////////
//:: Name x2_def_spawn
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spawn script


    2003-07-28: Georg Zoeller:

    If you set a ninteger on the creature named
    "X2_USERDEFINED_ONSPAWN_EVENTS"
    The creature will fire a pre and a post-spawn
    event on itself, depending on the value of that
    variable
    1 - Fire Userdefined Event 1510 (pre spawn)
    2 - Fire Userdefined Event 1511 (post spawn)
    3 - Fire both events

*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner, Georg Zoeller
//:: Created On: June 11/03
//:://////////////////////////////////////////////

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


#include "inc_id1_utility"
//#include "inc_id_onspawn"
#include "inc_id1_flags"
#include "inc_id1_creature"

#include "x2_inc_switches"
#include "x0_i0_anims"

void LevelUpNPC(object oCreature = OBJECT_SELF);

void main()
{
    // details for log
    DebugMessage("");
    DebugMessage("Spawned creature " + GetTag(OBJECT_SELF));

    // default NWN scripts
    int nNumber = GetLocalInt(OBJECT_SELF,CREATURE_VAR_NUMBER_OF_ATTACKS);
    if (nNumber > 0 )
    {
        SetBaseAttackBonus(nNumber);
    }
    SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_STEALTH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_STEALTH);
    }
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_SEARCH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_SEARCH);
    }
//    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE) == TRUE)
//    {
//        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
//    }
//    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT) == TRUE)
//    {
//        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
//    }
    SetListeningPatterns();
//    WalkWayPoints();

    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) == TRUE)
    {
        effect eConceal = EffectConcealment(50, MISS_CHANCE_TYPE_NORMAL);
        eConceal = ExtraordinaryEffect(eConceal);
        effect eGhost = EffectCutsceneGhost();
        eGhost = ExtraordinaryEffect(eGhost);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);

    }

    // if a creature
    int nCreatureType = GetLocalInt(OBJECT_SELF, "nCreatureType");
    DebugMessage("  Creature type is " + IntToString(nCreatureType));
    if (nCreatureType > 0)
    {
        DebugMessage("  Creature is a leveled creature");

        // clean all objects off the creature
        CleanItems(OBJECT_SELF);

        // go to levelup microprocess
        object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU124");
        SetLocalInt(oMicroCPU, "nLevel", 1);
        SetLocalObject(oMicroCPU, "oCreature", OBJECT_SELF);
        DelayCommand(0.01, ExecuteScript("exe_id1_spawn1", oMicroCPU));
    }

    if (GetModuleFlag(ID1_FLAG_ENCOUNTER_CORPSE) == ID1_ENCOUNTER_CORPSE_PERMANENT)
    {
        SetIsDestroyable(FALSE, FALSE, TRUE);
    }
}

/*        // up creature to proper HD
        LevelUpNPC(OBJECT_SELF);

        int bEquipWeapon = FALSE;
        int bEquipArmor = FALSE;
        int nAttributes = -1;
        if (nCreatureType == 3)
        {
            bEquipWeapon = GetLocalInt(OBJECT_SELF, "bEquipWeapon");
            bEquipArmor = GetLocalInt(OBJECT_SELF, "bEquipArmor");
        } else
        {
            // get creature number
            object oDungeon = GetCurrentDungeon();
            string sCreature = GetLocalString(OBJECT_SELF, "sVariable");
            int nCreature = GetLocalInt(oDungeon, "n" + sCreature);
            nAttributes = GetLocalInt(oDungeon, "nListCreature" + IntToString(nCreature) + "Attributes");
            bEquipWeapon = GetIsEquipWeapon(nAttributes);
            bEquipArmor = GetIsEquipArmor(nAttributes);
        }
        DebugMessage("  nAttributes is " + IntToString(nAttributes) + ", bEquipWeapon is " + IntToString(bEquipWeapon) + ", bEquipArmor is " + IntToString(bEquipArmor));

        if ((bEquipWeapon == TRUE) || (bEquipArmor == TRUE))
        {
            // get equipment bonus
            int nBonus = GetHitDice(OBJECT_SELF) / 5;
            DebugMessage("  nBonus is " + IntToString(nBonus));

            // equip with proper equipment
            object oMicroCPU = CreateObject(OBJECT_TYPE_PLACEABLE, "cpu", GetLocation(GetWaypointByTag("CPU")), FALSE, "MicroCPU124");
            SetLocalInt(oMicroCPU, "nProcess", 0);
            SetLocalInt(oMicroCPU, "nBonus", nBonus);
            SetLocalInt(oMicroCPU, "bWeapon", bEquipWeapon);
            SetLocalInt(oMicroCPU, "bArmor", bEquipArmor);
            SetLocalObject(oMicroCPU, "oCreature", OBJECT_SELF);
            DelayCommand(0.01, ExecuteScript("exe_id1_micequip", oMicroCPU));
        }

        // EDIT: fast buff
//        FastBuff();
    }
}*/

void LevelUpNPC(object oCreature = OBJECT_SELF)
{
    // The level up system will TMI if the creature has more than 1 HD
    // before we start leveling it up. Prevent that here.
    // Once the encounter.2da is up to date this should become extranious.
    if (GetHitDice(oCreature) == 1)
    {
        DebugMessage("");
        DebugMessage("Leveling up creature OnSpawn.");

        int nCreatureType = GetLocalInt(oCreature, "nCreatureType");
        DebugMessage("  Creature type is " + IntToString(nCreatureType));

        object oDungeon = GetCurrentDungeon();
        string sCreature = GetLocalString(oCreature, "sVariable");
        string sTag = GetTag(oCreature);
        int nCreature = -1;
        int nCR;
        int nCreatureClass;
        int nClassStartHD;
        int nClass = -1;

        if (nCreatureType == 3)
        {
            DebugMessage("  Retrieving data off creature.");

            nCR = GetLocalInt(oCreature, "nCR"); // desired CR
            nClassStartHD = GetLocalInt(oCreature, "nClassStartHD"); // HD at which specified class starts
            nClass = GetLocalInt(oCreature, "nClass"); // specified class to level the creature up in
        } else
        {
            DebugMessage("  Retrieving data off dungeon.");

            nCreature = GetLocalInt(oDungeon, "n" + sCreature);

            // get the CR the creature is to be levelled to
            nCR = GetLocalInt(oDungeon, "n" + sCreature + "CR");

            // get the class start HD
            nClassStartHD = GetLocalInt(oDungeon, "nListCreature" + IntToString(nCreature) + "ClassStartHD");

            // determine the level up class for this creature, of the subtype if necessary
            nClass = GetLocalInt(oDungeon, "nListCreature" + IntToString(nCreature) + "Class");
        }

        // get the basic creature class
        nCreatureClass = GetClassByPosition(1, oCreature);

        DebugMessage("  Variable returned was " + sCreature);
        DebugMessage("  Creature tag is " + sTag);
        DebugMessage("  Creature list number " + IntToString(nCreature));
        DebugMessage("  Desired CR is " + IntToString(nCR));
        DebugMessage("  Creature class is " + IntToString(nCreatureClass));

        // if an invalid class was returned
        if (nClass == -1)
        {
            DebugMessage("    Invalid class. Checking for alternative classes.");
            nClass = GetClassByPosition(3, oCreature);
            if (nClass == CLASS_TYPE_INVALID)
            {
                DebugMessage("    Third class is invalid. Checking second.");
                nClass = GetClassByPosition(2, oCreature);
                if (nClass == CLASS_TYPE_INVALID)
                {
                    DebugMessage("    Second class is invalid. Setting class to creature class.");
                    nClass = nCreatureClass;
                } else
                {
                    DebugMessage("    Second class is valid.");
                }
            } else
            {
                DebugMessage("    Third class is valid.");
            }
        }
        DebugMessage("  Normal class is " + IntToString(nClass));

        DebugMessage("  ClassStartHD is " + IntToString(nClassStartHD));

        // get the basic creature level up package
        int nCreaturePackage = GetBaseLevelUpPackage(nCreatureClass);
        DebugMessage("  Creature package is " + IntToString(nCreaturePackage));

        // get the class level up package
        int nPackage = GetGuardianEnemyPackage(nClass);
        DebugMessage("  Guardian/Enemy package is " + IntToString(nPackage));

        // level up to the minimum number of HD
        int nCurrentHD = 1;
        int nPreviousHD = 0;
        float fCR = GetChallengeRating(oCreature);
        while ((fCR <= IntToFloat(nCR - 1)) && (nPreviousHD != nCurrentHD))
        {
            // if the base creature type
            nPreviousHD = nCurrentHD;
            if ((nClassStartHD == -1) || ((nClassStartHD != -1) && (nCurrentHD < nClassStartHD)))
            {
                DebugMessage("      Leveling up creature class.");
                nCurrentHD = LevelUpHenchman(oCreature, nCreatureClass, TRUE, nCreaturePackage);
            } else
            {
                DebugMessage("      Leveling up normal class.");
                nCurrentHD = LevelUpHenchman(oCreature, nClass, TRUE, nPackage);
            }
            DebugMessage("    Leveled to " + IntToString(nCurrentHD));

            // determine challenge rating
            fCR = GetChallengeRating(oCreature);
            DebugMessage("    Challenge rating is " + FloatToString(fCR));
        }
    }
}

