//remove all gamedarts on exiting Furniture's Fate
//also resumes henchman follow commands.
#include "dla_i0_feats"
#include "X0_INC_HENAI"
void main()
{
    object oPC = GetFirstPC();
    object oDart = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oDart))
    {
        if(GetTag(oDart)=="dla_gamedart")
        {
            DestroyObject(oDart);
        }
        oDart = GetNextItemInInventory(oPC);
    }
    oDart = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    if(GetTag(oDart)=="dla_gamedart")
    {
        DestroyObject(oDart);
    }
    DLA_TakeFeat(oPC, IP_CONST_FEAT_WEAPON_PROF_SIMPLE);
    object oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,1);
    SetIsFollower(oHench,TRUE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oHench);
    oDart = GetFirstItemInInventory(oHench);
    while(GetIsObjectValid(oDart))
    {
        if(GetTag(oDart)=="dla_gamedart")
        {
            DestroyObject(oDart);
        }
        oDart = GetNextItemInInventory(oHench);
    }
    oDart = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oHench);
    if(GetTag(oDart)=="dla_gamedart")
    {
        DestroyObject(oDart);
    }
    oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,2);
    SetIsFollower(oHench,TRUE);
    SetAssociateState(NW_ASC_MODE_STAND_GROUND,FALSE,oHench);
    oDart = GetFirstItemInInventory(oHench);
    while(GetIsObjectValid(oDart))
    {
        if(GetTag(oDart)=="dla_gamedart")
        {
            DestroyObject(oDart);
        }
        oDart = GetNextItemInInventory(oHench);
    }
    oDart = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oHench);
    if(GetTag(oDart)=="dla_gamedart")
    {
        DestroyObject(oDart);
    }
}
