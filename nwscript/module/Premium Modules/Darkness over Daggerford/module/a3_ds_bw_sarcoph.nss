//::///////////////////////////////////////////////
//::
//:: a3_ds_bw_sarcoph
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Death script for placeable.
//:: Illefarn tomb has been robbed...
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/7/2005
//::
//:://////////////////////////////////////////////

void main()
{
    int nType = GetInventoryDisturbType();

    if (nType == INVENTORY_DISTURB_TYPE_REMOVED)
    {
        int nShift = GetLocalInt(OBJECT_SELF, "nShift");
        if (nShift == 0)
        {
            object oDisturber = GetLastDisturbed();
            AdjustAlignment(oDisturber, ALIGNMENT_CHAOTIC, 1);
            SetLocalInt(OBJECT_SELF, "nShift", 1);
        }

        SetLocalInt(GetModule(), "nIH_RobbedTomb", 1);
    }
}
