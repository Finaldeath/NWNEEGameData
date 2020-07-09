//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////

#include "x2_inc_compon"
#include "x0_i0_spawncond"

void main()
{

    string q = GetLocalString(GetModule(), "QUOTE");
    object oKiller = GetLastKiller();
    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    SignalEvent(GetObjectByTag("munroe_helper"), EventUserDefined(5400));
    craft_drop_items(oKiller);
    //replaced by a GetIsObjectValid check as Wilsey's SC due to on death not being reliable
    //SetLocalInt(GetModule(),"render",2);
    //AddJournalQuestEntry("j7",4,oKiller);
    //object oNPC;
    //the rest of the gang flee
    /*oNPC = GetNearestObjectByTag("db_fang", oKiller);
    AssignCommand(oNPC,ClearAllActions(TRUE));
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_sossimunroe", oKiller);
    AssignCommand(oNPC,ClearAllActions(TRUE));
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_methromunroe", oKiller);
    AssignCommand(oNPC,ClearAllActions(TRUE));
    AssignCommand(oNPC, SpeakString(q+"Jeth...nooo! Run!"+q));
    ExecuteScript("hf_cs_exit", oNPC);
    oNPC = GetNearestObjectByTag("db_yagemunroe", oKiller);
    AssignCommand(oNPC,ClearAllActions(TRUE));
    ExecuteScript("hf_cs_exit", oNPC);*/
}
