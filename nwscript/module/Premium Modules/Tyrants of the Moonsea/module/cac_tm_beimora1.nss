// player told henchman beirmoura to turn into a sword item

#include "hf_in_henchman"

const string sBeirmouraResRef = "thebrightsword";

// finds the sword item in the given character's inventory
object getSwordItem(object oOwner)
{
    object oSword = OBJECT_INVALID;
    int nSlot;
    for (nSlot = 0; nSlot < NUM_INVENTORY_SLOTS; ++nSlot)
    {
        object oItem = GetItemInSlot(nSlot, oOwner);
        if (GetIsObjectValid(oItem))
        {
            if (GetResRef(oItem) == sBeirmouraResRef)
            {
                oSword = oItem;
                break;
            }
        }
    }

    if (!GetIsObjectValid(oSword))
    {
        object oItem = GetFirstItemInInventory(oOwner);
        while (oItem != OBJECT_INVALID)
        {
            if (GetResRef(oItem) == sBeirmouraResRef)
            {
                oSword = oItem;
                break;
            }
            oItem = GetNextItemInInventory(oOwner);
        }
    }

    return oSword;
}


void main()
{
    object oPC = GetPCSpeaker();
    object oSword = getSwordItem(OBJECT_SELF);
    if (GetIsObjectValid(oSword))
    {
        SetIdentified(oSword, TRUE);
        object oItem = CopyItem(oSword, oPC, TRUE);
        AssignCommand(oPC, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
        ActionUnequipItem(oSword);

        HenchmanFire(OBJECT_SELF, oPC);
        DestroyObject(OBJECT_SELF, 0.1f);

        effect eSummon = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSummon, GetLocation(OBJECT_SELF));
        PlaySound("sco_lgrinmind01");
    }
}
