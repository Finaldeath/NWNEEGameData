//::///////////////////////////////////////////////
//:: Name nds_potsc_common
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default OnDisturbed script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: March 2005
//:://////////////////////////////////////////////
#include "inc_debtsystem"

void main()
{
    object oDisturber = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    object oSelf = OBJECT_SELF;
    object oModule = GetModule();
    int iDebounce = GetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE");

    if (GetIsPC(oDisturber) == TRUE)
    {
        ClearPersonalReputation(oDisturber, oSelf);
        SurrenderToEnemies();

        if (iDebounce == FALSE)
        {
            SetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE", TRUE);
            AssignCommand(oModule, AddToDebtList(oDisturber, oSelf));

            DelayCommand(10.0f, AssignCommand(oModule,
                SetLocalInt(oSelf, "POTSC_DEFAULT_DEBOUNCE", FALSE)));
        }
    }

    return;
}
