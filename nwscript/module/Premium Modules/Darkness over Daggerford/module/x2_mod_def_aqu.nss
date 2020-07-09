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

//additions by luspr throughout development phase

#include "x2_inc_switches"
#include "hf_in_plot"

void main()
{
     object oItem = GetModuleItemAcquired();
     object oPC = GetModuleItemAcquiredBy();
     object oDrop;
     object oStockade;

     if (GetTag(oItem) == "db_farmlandsevidence" && GetIsPC(oPC))
          {
          SetLocalInt(GetModule(),"fieldsquest",1);
          if(GetLocalInt(GetModule(),"good_evil")==2)
             {
             AddJournalQuestEntry("j11",5,oPC);
             }
          else
             {
             AddJournalQuestEntry("j11",7,oPC);
             }
          }
     if (GetTag(oItem) == "db_kitchensevidence" && GetIsPC(oPC))
          {
          SetLocalInt(GetModule(),"kitchenquest",1);
          if(!GetLocalInt(GetModule(),"hevesar_met") ==1)
            {
            //add the have not met hevesar entry
            AddJournalQuestEntry("j13", 8, oPC);
            }
          else
            {
            AddJournalQuestEntry("j13", 9, oPC);
            }
          }
     if (GetTag(oItem) == "db_dropoffevidence" && GetIsPC(oPC))
          {
          //commenting out the next line as the int is now set from the faremers convo
          //SetLocalInt(GetModule(),"dropoffquest",1);
          //object oDrop = GetItemPossessedBy(oPC, GetItemByTag("db_dropoffevidence"));
          //only add the journal update if the player has the stockade key
          object oStockade =GetItemPossessedBy(oPC, "db_stockade_key");
          if(GetIsObjectValid(oStockade) && GetLocalInt(GetModule(), "do_evidence_control") !=1)
             {
             AddJournalQuestEntry("j12",7,oPC);
             SetLocalInt(GetModule(), "do_evidence_control", 1);
             }
          }
     if (GetTag(oItem) == "db_stockade_key" && GetIsPC(oPC))
          {
          //only add the journal update if the player has the drop off evidence
          object oDrop =GetItemPossessedBy(oPC, "db_dropoffevidence");
          if(GetIsObjectValid(oDrop) && GetLocalInt(GetModule(), "do_evidence_control") !=1)
             {
             AddJournalQuestEntry("j12",7,oPC);
             SetLocalInt(GetModule(), "do_evidence_control", 1);
             }
          }
     if (GetTag(oItem) == "db_harperpin" && GetIsPC(oPC))
          {
          //harpers killed and their pin found
          AddJournalQuestEntry("j10",3,oPC);
          SetLocalInt(GetModule(), "iKnowsKilledHarpers", 1);
          }
     if (GetTag(oItem) == "db_buddyinaglobe" && GetIsPC(oPC))
          {
          //player has found talarenne's gem
          SetDroppableFlag(oItem, FALSE);
          SetItemCursedFlag(oItem, TRUE);
          AddJournalQuestEntry("j200", 7, oPC);
          }
     if (GetTag(oItem) == "db_itnote2" && GetIsPC(oPC))
          {
          //player has the coded communique
          AddJournalQuestEntry("j9", 2, oPC);
          }
     if (GetTag(oItem) == "rb_assaultnote" && GetIsPC(oPC))
     {
         if(GetLocalInt(GetModule(), "iFoundAssaultNote") == 0)
         {
             SetLocalInt(GetModule(), "iFoundAssaultNote", 1);
             PlotLevelSet("pm_Maerovyna", 1);
         }
     }

     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACQUIRE);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }

     }

}
