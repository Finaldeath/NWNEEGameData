//::///////////////////////////////////////////////
//:: dla_i0_feats
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Functions related to feats.
    Currently Give / Take a feat of a creature.
*/
//:://////////////////////////////////////////////
//:: Create By: Gale
//:: Created On: Dec 3, 2005
//:://////////////////////////////////////////////

//Give a feat to someone
void DLA_GiveFeat(object oCreature, int nFeatIP);

//Take a feat from someone
void DLA_TakeFeat(object oCreature, int nFeatIP);

object DLA_EnsureHasSkin(object oCreature)
{
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oCreature);
    if (oSkin == OBJECT_INVALID)
    {
        oSkin = CreateItemOnObject("dla_pcproperties", oCreature);
        AssignCommand(oCreature, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR));
    }
    return oSkin;
}

void DLA_GiveFeat(object oCreature, int nFeatIP)
{
    object oSkin = DLA_EnsureHasSkin(oCreature);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(nFeatIP), oSkin);
}

void DLA_TakeFeat(object oCreature, int nFeatIP)
{
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oCreature);
    itemproperty ipX = GetFirstItemProperty(oSkin);
    while (GetIsItemPropertyValid(ipX))
    {
        if (GetItemPropertyType(ipX) == ITEM_PROPERTY_BONUS_FEAT)
            if(GetItemPropertySubType(ipX) == nFeatIP)
            {
                RemoveItemProperty(oSkin, ipX);
                break;
            }
        ipX = GetNextItemProperty(oSkin);
    }
}
