//::///////////////////////////////////////////////
//:: Traps Include File
//:: inc_id_traps
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This file contains the functions used to created scaled traps in the Infinate
Dungeons Module.
*/
//:://////////////////////////////////////////////
//:: Created By: Jason Lowry
//:: Created On: Sep 08, 2005
//:://////////////////////////////////////////////
#include "inc_id_misctools"

// ------------------ CONSTANTS TO BE ADDED TO THE CONSTANTS FILE -------------
const int TRAP_DAMAGE_TYPE_RANDOM = -1;

const int TRAP_DAMAGE_CLASS_RANDOM = 0;
const int TRAP_DAMAGE_CLASS_1 = 1;   // d4 per APL
const int TRAP_DAMAGE_CLASS_2 = 2;   // d6 per APL
const int TRAP_DAMAGE_CLASS_3 = 4;   // d8 per APL
const int TRAP_DAMAGE_CLASS_4 = 8;   // d10 per APL
const int TRAP_DAMAGE_CLASS_5 = 16;  // d12 per APL
const int TRAP_DAMAGE_CLASS_6 = 32;  // d20 per APL

const int TRAP_AOE_FALSE        = 0;
const int TRAP_AOE_TRUE         = 1;
const int TRAP_AOE_RANDOM_20    = 2;
const int TRAP_AOE_RANDOM_40    = 4;
const int TRAP_AOE_RANDOM_60    = 8;
const int TRAP_AOE_RANDOM_80    = 16;

const int DAMAGE_TYPE_POISON = 10000;
const int POISON_WYVERN_EPIC = 44; // Left out of Poison Constants in nwscript.
// ------------------------------ END NEW CONSTANTS ----------------------------

// Sets a scaled trap on oObject.
// The damage of this trap will be randomly determined.
// oPC can be any Party member and is used to scale the trap.
// oObjectToTrap is the object to be trapped.
// oObjectToTrap must be a waypoint, placeable, or door.
// If left at it's defaults this function will create a completely random scaled trap.
//
// DetectDC is the detection DC for the trap, 0 will cause the DC to be scaled.
// nDisarmDC is the disarm DC for the trap, 0 will cause the DC to be scaled.
// nAvoidDC is the damage avoidance DC, 0 will cause the DC to be scaled.
// nDamageType can be changed to a DAMAGE_TYPE_*. For this function DAMAGE_TYPE_BASE_WEAPON is not valid.
// nDamageClass must be a valid TRAP_DAMAGE_CLASS_*
// nAOE must be a valid TRAP_AOE_*
void IDSetUpScaledTrap(object oPC, object oObjectToTrap, int nDetectDC = 0, int nDisarmDC = 0, int nAvoidDC = 0, int nDamageType = TRAP_DAMAGE_TYPE_RANDOM,int nDamageClass = TRAP_DAMAGE_CLASS_RANDOM, int nAOE = TRAP_AOE_RANDOM_20);
    // Subfuction of IDSetUpScaledTrap
    // NOT FOR EXTERNAL USE!
    int IDGetTrapDamageType(int nAPL);
    // Subfuction of IDSetUpScaledTrap
    // NOT FOR EXTERNAL USE!
    int IDGetTrapDamageClass(int nAPL);
    // Subfuction of IDSetUpScaledTrap
    // NOT FOR EXTERNAL USE!
    int IDGetIsTrapAOE(int nAOE);


// Places and returns a trapped object.
// Valid objects for this function are doors, placeables, and waypoints.
object IDTrapObject(object oObject);

// Returns a scaled DC for a trap.
// A party member must be supplied to scale the trap too.
int IDGetTrapDC(object oPC);

// Gets the visual effect for a trap.
effect GetVisualEffect(int nAOE, int nDamageType);

// Returns TRUE if the trap VFX should be applied to an object.
// Return FALSE if the trap VFX should be applied to a location.
// This should not be used with AOE traps which are always applied to a location.
int GetApplyTrapVFXToObject(int nDamType);

void IDSetUpScaledTrap(object oPC, object oObject, int nDetectDC, int nDisarmDC, int nAvoidDC, int nDamageType, int nDamageClass, int nAOE)
{
    int nAPL = GetAveragePartyLevel(oPC);
    int nTemp;
    // Set the trap.
    object oTrap = IDTrapObject(oObject);
    if (!GetIsTrapped(oTrap))
    {   // Trap was attempted to be placed on an invalid object. Shut down.
        return;
    }
    // Modify Detect Trap DC.
    if (nDetectDC == 0)
    {
        nDetectDC = IDRandomlyScaledDC(oPC) - 5; // Make the traps easier to detect on average.
    }
    SetTrapDetectDC(oTrap,nDetectDC);

    // Modify Disarm Trap DC.
    if (nDisarmDC == 0)
    {
        nDisarmDC = IDRandomlyScaledDC(oPC);
    }
    SetTrapDisarmDC(oTrap,nDisarmDC);

    // Make it so that only player made traps can be recovered.
    // This prevents traps from becoming loot to be sold.
    SetTrapRecoverable(oTrap,FALSE);

    // Get Trap DC
    if (nAvoidDC == 0)
    {
        nAvoidDC = IDRandomlyScaledDC(oPC);
    }

    // Get Trap Damage Type
    if (nDamageType == TRAP_DAMAGE_TYPE_RANDOM)
    {
        nDamageType = IDGetTrapDamageType(nAPL);
    }

    // Get Trap Damage Class
    if (nDamageClass == TRAP_DAMAGE_CLASS_RANDOM)
    {
        nDamageClass = IDGetTrapDamageClass(nAPL);
    }

    // Get is Trap AOE
    if (nAOE >= TRAP_AOE_RANDOM_20)
    {
        nAOE = IDGetIsTrapAOE(nAOE);
    }

    // Set the Trap Values to be used by "ten_id_trap".
    // May or may not need to be changed by Peter.
    // I don't they they will here.
    SetLocalInt(oTrap,"nAvoidDC",nAvoidDC);
    SetLocalInt(oTrap,"nDamageType",nDamageType);
    SetLocalInt(oTrap,"nDamageClass",nDamageClass);
    SetLocalInt(oTrap,"nDice",nAPL);
    SetLocalInt(oTrap,"nAOE",nAOE);
}

object IDTrapObject(object oObject)
{
    int nObjectType = GetObjectType(oObject);
    int nTrapType = 100;//TRAP_BASE_TYPE_MINOR_SPIKE;
    object oTrap;
    switch(nObjectType)
    {
        case OBJECT_TYPE_DOOR:
        case OBJECT_TYPE_PLACEABLE:
        {
            CreateTrapOnObject(nTrapType,oObject);
            return oObject;
        }
        case OBJECT_TYPE_WAYPOINT:
        {
            oTrap = CreateTrapAtLocation(nTrapType,GetLocation(oObject));
            return oTrap;
        }
    };
    return OBJECT_INVALID;
}

int IDGetTrapDC(object oPC)
{
    int iDC = GetAveragePartyLevel(oPC);
    if (iDC <= 10)
    {
        iDC = (iDC/2);
        if (iDC < 1)
        {
            iDC = 1;
        }
        iDC += Random(11) - 5;
        // Possible Values 16 to 30
    }
    else if (iDC <= 20)
    {
        iDC += Random(11) - 5;
        // Possible Values 26 to 45
    }
    else // EPIC
    {
        iDC += Random(21) - 10;
        // Possible Values 31 to 70
    }
    // Consider changing this value for difficulty scaling.
    iDC += 20; // This should be the "normal" level.
    return iDC;
}

int IDGetTrapDamageType(int nAPL)
{
    int nRoll = d100() + nAPL;
    // Physical Damage
    if (nRoll <= 60)
    {
        nRoll = d100();
        if (nRoll <= 20)
        {
            return DAMAGE_TYPE_BLUDGEONING;
        }
        else if (nRoll <= 60)
        {
            return DAMAGE_TYPE_SLASHING;
        }
        else return DAMAGE_TYPE_PIERCING;
    }
    // Poison
    else if (nRoll <= 70)
    {
        return DAMAGE_TYPE_POISON;
    }
    // Elemental Damage
    else if (nRoll <= 120)
    {
        nRoll = d100();
        if (nRoll <= 20)
        {
            return DAMAGE_TYPE_ACID;
        }
        else if (nRoll <= 40)
        {
            return DAMAGE_TYPE_COLD;
        }
        else if (nRoll <= 60)
        {
            return DAMAGE_TYPE_ELECTRICAL;
        }
        else if (nRoll <= 80)
        {
            return DAMAGE_TYPE_FIRE;
        }
        else return DAMAGE_TYPE_SONIC;
    }
    // Special Damage
    else
    {
        nRoll = d4();
        if (nRoll == 1)
        {
            return DAMAGE_TYPE_DIVINE;
        }
        else    if (nRoll == 2)
        {
            return DAMAGE_TYPE_MAGICAL;
        }
        else if (nRoll == 3)
        {
            return DAMAGE_TYPE_NEGATIVE;
        }
        else return DAMAGE_TYPE_POSITIVE;
    }
return TRAP_DAMAGE_TYPE_RANDOM; // This should never happen. Placed for compile reasons only.
}

int IDGetTrapDamageClass(int nAPL)
{
    int nRoll = d100() + nAPL - 1; // Possible results 1 to 139.
    if (nRoll <= 50)
    {
        return TRAP_DAMAGE_CLASS_1;
    }
    else if (nRoll <= 70)
    {
        return TRAP_DAMAGE_CLASS_2;
    }
    else if (nRoll <= 90)
    {
        return TRAP_DAMAGE_CLASS_3;
    }
    else if (nRoll <= 110)
    {
        return TRAP_DAMAGE_CLASS_4;
    }
    else if (nRoll <= 130)
    {
        return TRAP_DAMAGE_CLASS_5;
    }
    else
    {
        return TRAP_DAMAGE_CLASS_6;
    }
return TRAP_DAMAGE_CLASS_RANDOM; // This should never happen. Placed for compile reasons only.
}

int IDGetIsTrapAOE(int nAOE)
{
    int nTest;
    if (nAOE < TRAP_AOE_RANDOM_20)
    {
        return nAOE; // nAOE was not a TRAP_AOE_RANDOM_*. Assume T/F
    }
    switch (nAOE)
    {
        case TRAP_AOE_RANDOM_20:
        case TRAP_AOE_RANDOM_40:
        {
            nTest = nAOE * 10;
            break;
        }
        case TRAP_AOE_RANDOM_60:
        {
            nTest = 60;
            break;

        }
        case TRAP_AOE_RANDOM_80:
        {
            nTest = 80;
            break;
        }
    };
    if (d100() <= nTest)
    {
        return TRUE;
    }
    return FALSE;
}

int GetTrapDamageAmount(int nDice, int nDieType)
{
    switch(nDieType)
    {
        case TRAP_DAMAGE_CLASS_1:
        {
            return d4(nDice);
        }
        case TRAP_DAMAGE_CLASS_2:
        {
            return d6(nDice);
        }
        case TRAP_DAMAGE_CLASS_3:
        {
            return d8(nDice);
        }
        case TRAP_DAMAGE_CLASS_4:
        {
            return d10(nDice);
        }
        case TRAP_DAMAGE_CLASS_5:
        {
            return d12(nDice);
        }
        case TRAP_DAMAGE_CLASS_6:
        {
            return d20(nDice);
        }
    };
    return -1; // This should never happen. Supplied only for compile reasons.
}

effect GetVisualEffect(int nAOE, int nType)
{
    effect eVis;
    int nObject = FALSE;
    if (nAOE)
    {
        switch(nType)
        {
            case DAMAGE_TYPE_BLUDGEONING:
            {
                eVis = EffectAreaOfEffect(AOE_PER_ENTANGLE," ", " ", " ");
                break;
            }
            case DAMAGE_TYPE_PIERCING:
            {
                eVis = EffectVisualEffect(VFX_DUR_CALTROPS);
                break;
            }
            case DAMAGE_TYPE_SLASHING:
            {
                eVis = EffectVisualEffect(VFX_DUR_CALTROPS);
                break;
            }
            case DAMAGE_TYPE_ACID:
            {
                eVis = EffectAreaOfEffect(AOE_PER_FOGACID," ", " ", " ");
                break;
            }
            case DAMAGE_TYPE_COLD:
            {
                eVis = EffectAreaOfEffect(AOE_PER_FOGMIND," ", " ", " ");
                break;
            }
            case DAMAGE_TYPE_ELECTRICAL:
            {
                eVis = EffectVisualEffect(VFX_BEAM_LIGHTNING);
                break;
            }
            case DAMAGE_TYPE_FIRE:
            {
                eVis = EffectVisualEffect(VFX_FNF_FIREBALL);
                break;
            }
            case DAMAGE_TYPE_SONIC:
            {
                eVis = EffectVisualEffect(VFX_FNF_SOUND_BURST);
                break;
            }
            case DAMAGE_TYPE_MAGICAL:
            {
                eVis = EffectVisualEffect(AOE_PER_FOGKILL);
                break;
            }
            case DAMAGE_TYPE_NEGATIVE:
            {
                eVis = EffectAreaOfEffect(AOE_PER_GREASE," ", " ", " ");
                break;
            }
            case DAMAGE_TYPE_POSITIVE:
            {
                eVis = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
                break;
            }
            case DAMAGE_TYPE_POISON:
            {
                eVis = EffectAreaOfEffect(AOE_PER_FOGSTINK," ", " ", " ");
                break;
            }
        };
    }
    else
    {
        switch(nType)
        {
            case DAMAGE_TYPE_BLUDGEONING:
            {
                eVis = EffectVisualEffect(VFX_COM_CHUNK_STONE_SMALL);
                break;
            }
            case DAMAGE_TYPE_PIERCING:
            {
                eVis = EffectVisualEffect(VFX_IMP_SPIKE_TRAP);
                break;
            }
            case DAMAGE_TYPE_SLASHING:
            {
                eVis = EffectVisualEffect(VFX_FNF_SWINGING_BLADE);
                break;
            }
            case DAMAGE_TYPE_POISON:
            {
                eVis = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
                break;
            }
            case DAMAGE_TYPE_ACID:
            {
                eVis = EffectVisualEffect(VFX_COM_HIT_ACID);
                break;
            }
            case DAMAGE_TYPE_COLD:
            {
                eVis = EffectVisualEffect(VFX_IMP_HEAD_COLD);
                break;
            }
            case DAMAGE_TYPE_ELECTRICAL:
            {
                eVis = EffectVisualEffect(VFX_COM_HIT_ELECTRICAL);
                break;
            }
            case DAMAGE_TYPE_FIRE:
            {
                eVis = EffectVisualEffect(VFX_COM_HIT_FIRE);
                break;
            }
            case DAMAGE_TYPE_SONIC:
            {
                eVis = EffectVisualEffect(VFX_COM_HIT_SONIC);
                break;
            }
            case DAMAGE_TYPE_MAGICAL:
            {
                eVis = EffectVisualEffect(VFX_DUR_SMOKE);
                break;
            }
            case DAMAGE_TYPE_NEGATIVE:
            {
                eVis = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);
                break;
            }
            case DAMAGE_TYPE_POSITIVE:
            {
                eVis = EffectVisualEffect(VFX_COM_HIT_DIVINE);
                break;
            }
        };
    }
    return eVis;
}


int GetApplyTrapVFXToObject(int nType)
{
    switch(nType)
    {
        case DAMAGE_TYPE_ACID:
        case DAMAGE_TYPE_COLD:
        case DAMAGE_TYPE_ELECTRICAL:
        case DAMAGE_TYPE_FIRE:
        case DAMAGE_TYPE_SONIC:
        case DAMAGE_TYPE_NEGATIVE:
        case DAMAGE_TYPE_POSITIVE:
        {
            return TRUE;
        }
    };
return FALSE;
}

int GetPoisonType(int nAPL);
int GetPoisonType(int nAPL)
{
    int nRoll = 100 + nAPL;
    if (nRoll <= 10)
        return POISON_NIGHTSHADE;               //10
    else if (nRoll <= 1)
        return POISON_SMALL_CENTIPEDE_POISON;   //11
    else if (nRoll <= 4)
        return POISON_STRIPED_TOADSTOOL;        //11
    else if (nRoll <= 7)
        return POISON_TINY_SPIDER_VENOM;        //11
    else if (nRoll <= 10)
        return POISON_SMALL_SPIDER_VENOM;       //11
    else if (nRoll <= 13)
        return POISON_BLACK_ADDER_VENOM;        //12
    else if (nRoll <= 16)
        return POISON_BLOODROOT;                //12
    else if (nRoll <= 19)
        return POISON_GREENBLOOD_OIL;           //13
    else if (nRoll <= 22)
        return POISON_NITHARIT;                 //13
    else if (nRoll <= 25)
        return POISON_CARRION_CRAWLER_BRAIN_JUICE; //13
    else if (nRoll <= 28)
        return POISON_ARSENIC;                  //13
    else if (nRoll <= 31)
        return POISON_QUASIT_VENOM;             //13
    else if (nRoll <= 34)
        return POISON_ETTERCAP_VENOM;           //13
    else if (nRoll <= 37)
        return POISON_ARANEA_VENOM;             //13
    else if (nRoll <= 40)
        return POISON_BLUE_WHINNIS;             //14
    else if (nRoll <= 43)
        return POISON_ID_MOSS;                  //14
    else if (nRoll <= 46)
        return POISON_MEDIUM_SPIDER_VENOM;      //14
    else if (nRoll <= 49)
        return POISON_BLADE_BANE;               //15
    else if (nRoll <= 52)
        return POISON_OIL_OF_TAGGIT;            //15
    else if (nRoll <= 55)
        return POISON_UNGOL_DUST;              //15
    else if (nRoll <= 58)
        return POISON_CHAOS_MIST;              //15
    else if (nRoll <= 61)
        return POISON_PHASE_SPIDER_VENOM;       //15
    else if (nRoll <= 64)
        return POISON_MALYSS_ROOT_PASTE;        //16
    else if (nRoll <= 67)
        return POISON_SASSONE_LEAF_RESIDUE;     //16
    else if (nRoll <= 70)
        return POISON_TERINAV_ROOT;             //16
    else if (nRoll <= 73)
        return POISON_SHADOW_ESSENCE;           //17
    else if (nRoll <= 76)
        return POISON_WYVERN_POISON;            //17
    else if (nRoll <= 79)
        return POISON_LICH_DUST;                //17
    else if (nRoll <= 82)
        return POISON_IRON_GOLEM;               //17
    else if (nRoll <= 85)
        return POISON_LARGE_SCORPION_VENOM;     //18
    else if (nRoll <= 88)
        return POISON_GIANT_WASP_POISON;        //18
    else if (nRoll <= 91)
        return POISON_DARK_REAVER_POWDER;       //18
    else if (nRoll <= 94)
        return POISON_BURNT_OTHUR_FUMES;        //18
    else if (nRoll <= 97)
        return POISON_LARGE_SPIDER_VENOM;       //18
    else if (nRoll <= 100)
        return POISON_DEATHBLADE;               //20
    else if (nRoll <= 105)
        return POISON_BLACK_LOTUS_EXTRACT;      //20
    else if (nRoll <= 110)
        return POISON_BEBILITH_VENOM;           //20
    else if (nRoll <= 115)
        return POISON_PIT_FIEND_ICHOR;          //21
    else if (nRoll <= 120)
        return POISON_PURPLE_WORM_POISON;       //24
    else if (nRoll <= 125)
        return POISON_DRAGON_BILE;              //26
    else if (nRoll <= 130)
        return POISON_HUGE_SPIDER_VENOM;        //26
    else if (nRoll <= 134)
        return POISON_WRAITH_SPIDER_VENOM;      //26
    else if (nRoll <= 137)
        return POISON_WYVERN_EPIC;              //26
    else if (nRoll <= 139)
        return POISON_COLOSSAL_SPIDER_VENOM;    //35
    else
        return POISON_GARGANTUAN_SPIDER_VENOM;  //36
}
