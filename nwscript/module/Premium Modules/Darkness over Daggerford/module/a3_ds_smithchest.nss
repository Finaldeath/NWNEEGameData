//::///////////////////////////////////////////////
//::
//:: a3_ds_bw_sarcoph
//::
//:: Copyright (c) 2005 Bioware Corp.
//::
//:://////////////////////////////////////////////
//::
//:: On Death script for placeable.
//:: Smith chest, check if item was been modified.
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Brian Watson
//:: Created On: 11/8/2005
//::
//:://////////////////////////////////////////////

void main()
{
    int nType = GetInventoryDisturbType();

    if (nType == INVENTORY_DISTURB_TYPE_REMOVED)
    {
        object oItem = GetInventoryDisturbItem();

        if (GetLocalInt(oItem, "nIH_SmithWorked") == 1)
        {
            object oDisturber = GetLastDisturbed();
            if (GetIsPC(oDisturber))
            {
                SetLocalInt(oDisturber, "nIH_SmithWorked", 1);
            }
        }
        SetPickpocketableFlag(oItem, TRUE);
    }
}
