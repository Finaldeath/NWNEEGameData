//::///////////////////////////////////////////////
//:: dla_inv_adj
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
    Shows the inventory of a creature, to player management.
    uses a placeable to store the inventory
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: 5 Feb 2006
//:://////////////////////////////////////////////

#include "dla_x0_inventory"
#include "x0_i0_position"

void main()
{
    object oTarg = GetPCSpeaker();
    float fDir = GetFacing(oTarg);
    location locInv = GenerateNewLocation(oTarg,
                               0.1,
                               fDir,
                               fDir);

    object oInv = CreateObject(OBJECT_TYPE_PLACEABLE, "dla_inventory", locInv);
    SetPortraitId(oInv, GetPortraitId());
    SetName(oInv, "Inventory: "+GetName(OBJECT_SELF));
    SetLocalObject(oInv, "DLA_MILITIA", OBJECT_SELF);

    CopyEquipped(oInv, OBJECT_SELF);
    CopyUnequipped(oInv, OBJECT_SELF);

    DelayCommand(0.1,AssignCommand(oTarg,DoPlaceableObjectAction(oInv, PLACEABLE_ACTION_USE)));
    effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eInvis, oInv);

}
