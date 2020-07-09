//::///////////////////////////////////////////////
//:: dla_mod_equip
//:: DragonLance Adventures (DLA)
//:://////////////////////////////////////////////
/*
   Default Module OnPlayerEquipItem script when using
   DLA Horses

   Modified to include Tag based code from Bioware default.
*/
//:://////////////////////////////////////////////
//:: Created By: Gale
//:: Created On: Nov 28, 2005
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "dla_inc_ride"

void main()
{
    object oItem = GetPCItemLastEquipped();
    object oPC   = GetPCItemLastEquippedBy();
    ExecuteScript("x2_mod_def_equ", oPC);
    if (DLA_GetIsMounted(oPC))
    {
        DLA_UnequipShield( oPC, oItem );
        DelayCommand(0.3, DLA_UnequipForbiddenWeapon( oPC, oItem));
        AssignCommand(oPC, DLA_RefreshMountedArcheryPenalty());
    }
     // -------------------------------------------------------------------------
     // Generic Item Script Execution Code
     // If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // it will execute a script that has the same name as the item's tag
     // inside this script you can manage scripts for all events by checking against
     // GetUserDefinedItemEventNumber(). See x2_it_example.nss
     // -------------------------------------------------------------------------
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_EQUIP);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
     }
}
