//::///////////////////////////////////////////////
//:: Example XP2 OnActivate Script Script
//:: x2_mod_def_act
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnItemActivate Event

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "inc_id1_debug"

void main()
{
     object oItem = GetItemActivated();
     object oPC = GetItemActivator();
     if (GetIsPC(oPC) == TRUE)
     {
         // * Generic Item Script Execution Code
         // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
         // * it will execute a script that has the same name as the item's tag
         // * inside this script you can manage scripts for all events by checking against
         // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
         if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
         {
            SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACTIVATE);

            string sTag = GetTag(oItem);
            DebugMessage("Activating " + sTag);

            // the map object
            if (sTag == "itm_id1_map")
            {
                ExecuteScript("pus_id1_map", oItem);
            }

            // the journal object
            if (sTag == "itm_id1_journal")
            {
                ExecuteScript("pus_id1_journal", oItem);
            }

            // the boss plot items
            if (sTag == "itm_id1_anttot_dormant") // baccha
            {
                ExecuteScript("pus_id1_bossitem", oItem);
            }
            if (sTag == "itm_id1_widhair_dormant") // hagatha
            {
                ExecuteScript("pus_id1_bossitem", oItem);
            }
            if (sTag == "itm_id1_maggegg_dormant") // maggris
            {
                ExecuteScript("pus_id1_bossitem", oItem);
            }
            if (sTag == "itm_id1_harattg_dormant") // harat
            {
                ExecuteScript("pus_id1_bossitem", oItem);
            }
            if (sTag == "itm_id1_gzrbeye_dormant") // gzhorb
            {
                ExecuteScript("pus_id1_bossitem", oItem);
            }
            if (sTag == "itm_id1_masbone_dormant") // masterius
            {
                ExecuteScript("pus_id1_bossitem", oItem);
            }

            // the boss reward items
            if (sTag == "itm_id1_anttot_active") // antoine
            {
                ExecuteScript("itm_id1_anttot", oItem);
            }
            if (sTag == "itm_id1_widhair_active") // hagatha
            {
                ExecuteScript("itm_id1_widhair", oItem);
            }
            if (sTag == "itm_id1_maggegg_active") // maggris
            {
                DebugMessage("Recognized script.");
                ExecuteScript("itm_id1_maggegg", oItem);
            }
            if (sTag == "itm_id1_harattg_active") // harat
            {
                ExecuteScript("itm_id1_harattg", oItem);
            }
            if (sTag == "itm_id1_gzrbeye_active") // gzhorb
            {
                ExecuteScript("itm_id1_gzrbeye", oItem);
            }
            if (sTag == "itm_id1_masbone_active") // masterius
            {
                ExecuteScript("itm_id1_masbone", oItem);
            }

            // portable camp
            if (sTag == "id1_portcamp")
            {
                ExecuteScript("pus_id1_portcamp", oItem);
            }

            // the abyssal census
            if (sTag == "id1_bossplot_har1")
            {
                object oPC = GetItemPossessor(oItem);
                DestroyObject(oItem);
                AssignCommand(oPC, SpeakString("It seems Harat wasn't quite what he represented himself to be..."));
                CreateItemOnObject("id1_bossplot_ha2", oPC);
                SetLocalInt(GetModule(), "bHaratOpened", TRUE);
                AddJournalQuestEntry("id1_harat", 25, oPC, FALSE, FALSE);
            }

            // recipes
            string sSubTag = GetSubString(sTag, 0, 11);

            if (sSubTag == "id1_recipe_")
            {
                ExecuteScript("pus_id1_recipe", oItem);
            }

            int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
            if (nRet == X2_EXECUTE_SCRIPT_END)
            {
               return;
            }

         }
     }
}
