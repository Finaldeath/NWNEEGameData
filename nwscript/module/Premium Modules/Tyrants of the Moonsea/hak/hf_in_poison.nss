/**
*   Create your poison item blueprint with local variable:
*       HF_POISON_ID = <poison constant>
*       Constant values:   http://www.nwnlexicon.com/index.php?title=Poison
*       AD&D poisons: https://nwn.fandom.com/wiki/Poison
*/

#include "x2_inc_itemprop"
#include "X2_inc_switches"
#include "nw_i0_spells"


const string MSG_PO_INVALID         = "Invalid Target.  Must be a piercing or slashing weapon, or ammunition.";
const string MSG_PO_INVALID_COATED  = "Weapon is already coated with poison.";
const string MSG_PO_SUCCESS         = "Poison applied successfully.";
const string MSG_PO_FAIL            = "Failed. You poisoned yourself!";

const string POISON_2DA             = "poison";
const string HF_POISON_ID           = "HF_ITEM_ONHIT_POISON";


// private functions
int _getPoisonId(object oWeapon);
int _getIsWeaponPoisoned(object oWeapon);
int _reduceItem(object oItem, int nCount = 1);
int _getItemHasIPOnHitPropertySubType(object oTarget, int nSubType);

// a player applies a poison item to a weapon
void PoisonApply(object oPC, object oItem, object oWeapon)
{
    // check for valid target
    if (oWeapon == OBJECT_INVALID || GetObjectType(oWeapon) != OBJECT_TYPE_ITEM) {
       FloatingTextStringOnCreature(MSG_PO_INVALID, oPC, FALSE);
       return;
    }

    // check for valid weapon
    int nType = GetBaseItemType(oWeapon);
    if (!IPGetIsMeleeWeapon(oWeapon) &&
      !IPGetIsProjectile(oWeapon)   &&
       nType != BASE_ITEM_SHURIKEN &&
       nType != BASE_ITEM_DART &&
       nType != BASE_ITEM_THROWINGAXE)
    {
       FloatingTextStringOnCreature(MSG_PO_INVALID, oPC, FALSE);
       return;
    }

    // can't apply poison to blunt weapons
    if ( IPGetIsBludgeoningWeapon(oWeapon) )
    {
       FloatingTextStringOnCreature(MSG_PO_INVALID, oPC, FALSE);
       return;
    }

    // can only apply one poison at a time
    if ( _getIsWeaponPoisoned(oWeapon) )
    {
        FloatingTextStringOnCreature(MSG_PO_INVALID_COATED, oPC, FALSE);
        return;
    }

    // apply the poison; bad things happen if you don't have "use poison" feat
    int nPoisonId = GetLocalInt(oItem, HF_POISON_ID);
    int bHasFeat = GetHasFeat(960, oPC);
    if (!bHasFeat)
    {
        // force an attack of opportunity
        AssignCommand(oPC, ClearAllActions(TRUE));

        int nDex     = GetAbilityModifier(ABILITY_DEXTERITY, oPC);
        int nCheck   = d10(1) + 10 + nDex;
        int nApplyDC = StringToInt( Get2DAString(POISON_2DA, "Handle_DC", nPoisonId));

        // failed, so apply poison to the user
        if (nCheck < nApplyDC) {
            FloatingTextStringOnCreature(MSG_PO_FAIL, oPC, FALSE);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(nPoisonId), oPC);
            _reduceItem(oItem);
            return;
        }
    }

    // success message
    FloatingTextStringOnCreature(MSG_PO_SUCCESS, oPC, FALSE);
    _reduceItem(oItem);

    // store the poison id on the weapon
    SetLocalInt(oWeapon, HF_POISON_ID, nPoisonId);

    // apply the actual poison as a Unique OnHit property to the weapon
    int nLevel      = GetHitDice(oPC);
    int nHitType    = IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER;
    float fDuration = RoundsToSeconds(3);
    itemproperty ip = ItemPropertyOnHitCastSpell(nHitType, nLevel);
    IPSafeAddItemProperty(oWeapon, ip, fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, TRUE, TRUE);

    // add a visual effect to the poisoned weapon
    if ( _getIsWeaponPoisoned(oWeapon) ) {
        IPSafeAddItemProperty(oWeapon, ItemPropertyVisualEffect(ITEM_VISUAL_ACID), fDuration, X2_IP_ADDPROP_POLICY_KEEP_EXISTING, TRUE, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_NATURE), GetItemPossessor(oWeapon));
    }
}

// call this when a poisoned weapon hits a target
void PoisonOnHit(object oPC, object oItem, object oTarget)
{
    int nPoisonId = _getPoisonId(oItem);

    if(!GetIsImmune(oTarget, IMMUNITY_TYPE_POISON))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectPoison(nPoisonId), oTarget);
    }
}

// returns the weapon's poison type, or zero if none
int _getPoisonId(object oWeapon)
{
    return GetLocalInt(oWeapon, HF_POISON_ID);
}

// returns true if the given weapon is poisoned
int _getIsWeaponPoisoned(object oWeapon)
{
    if ( IPGetItemHasItemOnHitPropertySubType(oWeapon, 19) ||
         _getItemHasIPOnHitPropertySubType(oWeapon, IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER)){
        return TRUE;
    }

    return FALSE;
}

// destroys a number of the given items, considering stacking
int _reduceItem(object oItem, int nCount = 1)
{
    int nStack = GetItemStackSize(oItem);
    if (nCount >= nStack)
    {
        AssignCommand(oItem, SetIsDestroyable(TRUE));
        DestroyObject(oItem);
        return nCount - nStack;
    }

    SetItemStackSize(oItem, nStack - nCount);
    return 0;
}

// returns true if the given item has the given subtype
int _getItemHasIPOnHitPropertySubType(object oItem, int nSubType)
{
    if (GetItemHasItemProperty(oItem, ITEM_PROPERTY_ONHITCASTSPELL))
    {
        itemproperty ipTest = GetFirstItemProperty(oItem);
        while (GetIsItemPropertyValid(ipTest))
        {
            if (GetItemPropertySubType(ipTest) == nSubType)
            {
                return TRUE;
            }

            ipTest = GetNextItemProperty(oItem);
        }
    }

    return FALSE;
}
