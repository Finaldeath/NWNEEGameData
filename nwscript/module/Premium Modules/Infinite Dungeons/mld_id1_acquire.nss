//::///////////////////////////////////////////////
//:: Example XP2 OnItemAcquireScript
//:: x2_mod_def_aqu
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemAcquire Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "inc_id1_debug"
void main()
{
     object oItem = GetModuleItemAcquired();
     object oPC = GetModuleItemAcquiredBy();
     if (GetIsPC(oPC) == TRUE)
     {
         // * Generic Item Script Execution Code
         // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
         // * it will execute a script that has the same name as the item's tag
         // * inside this script you can manage scripts for all events by checking against
         // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
         if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
         {
            SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACQUIRE);

            string sItemTag = GetTag(oItem);
            DebugMessage("Acquired item tag is " + sItemTag);

    /*        // Special case for Antoine's totem in ID.
            if (sItemTag == "itm_id1_anttot_active")
            {
                ExecuteScript("itm_id1_anttot", OBJECT_SELF);
                return;
            }*/

            DebugMessage("Item possessor is a PC.");
            object oMarker = OBJECT_INVALID;
            if (sItemTag == "id1_bossplot_ant")
            {
                oMarker = GetNearestObjectByTag("ant_marker", oPC);
            }
            if (sItemTag == "id1_bossplot_hag")
            {
                oMarker = GetNearestObjectByTag("hag_marker", oPC);
            }
            if (sItemTag == "id1_bossplot_mag")
            {
                oMarker = GetNearestObjectByTag("mag_marker", oPC);
            }
            if (sItemTag == "id1_bossplot_har1")
            {
                oMarker = GetNearestObjectByTag("har_marker", oPC);
            }
            if (sItemTag == "id1_bossplot_gzb")
            {
                oMarker = GetNearestObjectByTag("gzb_marker", oPC);
            }
            if (sItemTag == "id1_bossplot_mas")
            {
                oMarker = GetNearestObjectByTag("mas_marker", oPC);
            }
            if (oMarker != OBJECT_INVALID)
            {
                DestroyObject(oMarker);
                return;
            }

            int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
            if (nRet == X2_EXECUTE_SCRIPT_END)
            {
               return;
            }

         }
    }
}
