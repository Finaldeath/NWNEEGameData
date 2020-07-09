//::///////////////////////////////////////////////
//:: mld_iop_modload
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    on module load find a valid safe location and
    set the max hench men to 2.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
#include "inc_bootysystem"
#include "inc_genbooks"
#include "inc_genscrolls"
#include "inc_safepoint"

void main()
{
    object oSelf = OBJECT_SELF;
    object oDocks = GetObjectByTag("Map_M1Q4A");
    object oStart = GetObjectByTag("A0_MDNGHTRSE_SAFESTART");
    int iDoOnce = GetLocalInt(oSelf, "mld_iop_modload");

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oSelf, "mld_iop_modload", TRUE);

        // Generate Items, Books, and Scrolls from a 2da
        GenerateBootyList();
        GenerateBookList();
        GenerateScrollList();

        SetMaxHenchmen(5);

        UpdateSafePoint(oDocks);
    }
}
