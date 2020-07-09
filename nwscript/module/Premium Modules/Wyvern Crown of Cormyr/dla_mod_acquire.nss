// Ben W-Husey
// DLA mod acquire script
// Mostly deals with journal entries for the 'Weapon of a True Knight' quest and the Mythallar quest
// Most items have tag based scripts, just a couple of subquest items here.
// EDITS: ongoing
// Last edit 11th April 2006

#include "cu_functions"
#include "dla_i0_feats"
#include "x2_inc_switches"
void main()
{
//                              variable declarations
    object oItem = GetModuleItemAcquired();
    object oPC = GetItemPossessor(oItem);// the PC that acquires the item

    string sTag = GetTag(oItem);

//ReplacesExecuteScript("x2_mod_def_aqu",OBJECT_SELF); to boost performance
    SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ACQUIRE);
    int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
    if (nRet == X2_EXECUTE_SCRIPT_END)
    {
        return;
    }
    // results of acquiring item
    if (GetIsObjectValid(oItem) == TRUE && GetIsDefPC(oPC))
    {
        if (GetStringLeft(sTag,5) == "Shard")
        {//Weapon of a True Knight quest items
         //Journal entries are only added for the second or later pieces if the PC knows about reforging
         // Note the blueprint and tags do not match as I got them the wrong way around.
            string sThis = GetStringRight(sTag,1);
            int nThis = StringToInt(sThis);
            int nLast = GetLocalInt(oPC,"nGotShard");
            if (GetLocalInt(oPC,"nGotShard")==3 && (nThis>nLast))
            {
                if (GetLocalInt(oPC,"XCraft")>0)
                {//only add entries if PC knows about reforging
                    AddJournalQuestEntry("Weapon",13,oPC);
                }
                AllParty("nLastShard",oPC,nThis);
                AllParty("nGotShard",oPC,GetLocalInt(oPC,"nGotShard")+1);
            }
            if (GetLocalInt(oPC,"nGotShard")==2 && (nThis>nLast))
            {
                if (GetLocalInt(oPC,"XCraft")>0)
                {//only add entries if PC knows about reforging
                    AddJournalQuestEntry("Weapon",12,oPC);
                }
                AllParty("nLastShard",oPC,nThis);
                AllParty("nGotShard",oPC,GetLocalInt(oPC,"nGotShard")+1);
            }
            if (GetLocalInt(oPC,"nGotShard")==1 && (nThis>nLast))
            {//Subsequent pieces, update journal if not got any info out of smith yet
                if (GetLocalInt(oPC,"XCraft")>0)
                {//only add entries if PC knows about reforging
                    AddJournalQuestEntry("Weapon",11,oPC);
                }
                AllParty("nLastShard",oPC,nThis);
                AllParty("nGotShard",oPC,GetLocalInt(oPC,"nGotShard")+1);
            }
            if (GetLocalInt(oPC,"nGotShard")<1)  //First piece, add appropriate journal entry
            {
                string sResRef = GetResRef(oItem);
                if (sResRef == "shard1")
                {
                    AddJournalQuestEntry("Weapon",1,oPC);
                }
                else if (sResRef == "shard3")
                {// Note resref 3 is actually the second
                    AddJournalQuestEntry("Weapon",2,oPC);
                }
                else if (sResRef == "shard2")
                {
                    AddJournalQuestEntry("Weapon",3,oPC);
                }
                else if (sResRef == "shard4")
                {
                    AddJournalQuestEntry("Weapon",4,oPC);
                }
                AllParty("nLastShard",oPC,nThis);
                AllParty("nGotShard",oPC,GetLocalInt(oPC,"nGotShard")+1);
            }
            //**********debug line***************
    //        SendMessageToPC(oPC,"Last shard aquired: "+IntToString(GetLocalInt(oPC,"nGotShard"))+" This one: "+sThis);
        }
        // Father's Will
        else if (sTag == "Will")  //Family Grave quest item
        {
            int nOnce = GetLocalInt(oPC,"nWillGot");
            if (nOnce<1)
            {
                AddJournalQuestEntry("Grave",10,oPC);
                AllParty("nGrave",oPC,1);
                AllParty("nWillGot",oPC,1);
            }
        }
        // Treasure Map
        else if (sTag == "TreasureMap")  //Curst Quest
        {
            int nOnce = GetLocalInt(oPC,"nTMap");
            if (nOnce<1)
            {
                AddJournalQuestEntry("Treasure",10,oPC);
                AllParty("nTMap",oPC,1);
            }
        }
        // The Wyvern Crown
        else if (sTag == "wyverncrownhelm")  //The Wyvern Crown
        {
            int nOnce = GetLocalInt(oPC,"nWCrownGot");
            object oWL = GetObjectByTag("BattleWL");
            effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
            //if not done this before, beam in the witch lord at the end of the causeway.
            if (nOnce<1)
            {
                AddJournalQuestEntry("MainPlot",105,oPC);
                AllParty("nWCrownGot",oPC,1);
                SetItemCursedFlag(oItem,TRUE);
                ChangeFaction(oWL, GetObjectByTag("Caladnei"));
                AssignCommand(oWL,JumpToLocation(GetLocation(GetWaypointByTag("WP_WLFinal"))));
                DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oWL));
            }
        }
        // Father's Head
        else if (sTag == "FatherHead")  //Removing head from stake
        {
            DestroyObject(GetObjectByTag("HeadPost"));
        }
        // Imelda's Note
        else if (sTag == "ImeldasNote")  //Pick up note
        {
            int nOnce = GetLocalInt(oPC,"nImGot");
            if (nOnce<1)
            {
                AddJournalQuestEntry("Revenge",10,oPC);
                AllParty("nRevenge",oPC,1);
                AllParty("nImGot",oPC,1);
            }
        }
        // Agent's Note
        else if (sTag == "AgentsNote")
        {//Pick up note
            int nOnce = GetLocalInt(oPC,"nANGot");
            if (nOnce<1)
            {
                AddJournalQuestEntry("Catch",40,oPC);
                AllParty("nSpy",oPC,10);
            }
        }
        // White Stag's Hide
        else if (sTag == "WhiteStagOK")
        {
            int nQuest = GetLocalInt(oPC,"nWStag");
            if (nQuest>0)
            {
                AddJournalQuestEntry("WStag",60,oPC);
                AllParty("nWStag",oPC,2);
            }
        }
        else if (sTag == "WhiteStagBad")
        {
            int nQuest = GetLocalInt(oPC,"nWStag");
            if (nQuest>0)
            {
                AddJournalQuestEntry("WStag",61,oPC);
                AllParty("nWStag",oPC,2);
            }
        }
        // Jonas's Charm
        else if (sTag == "JonasCharm")
        {
            int nOnce = GetLocalInt(oPC,"nJCGot");
            if (nOnce<1)
            {
                AddJournalQuestEntry("QRing",20,oPC);
                AllParty("nQRing",oPC,2);
            }

        }
        else if (GetStringLeft(sTag,8) == "Keystone")  //Mythallar keystone journal entries.
        {
            string sThis = GetStringRight(sTag,1);
            int nThis = StringToInt(sThis);
            int nCurrent = GetLocalInt(oPC,"nKeySTot"); // which stones has the PC got? All 3 are prime
            //numbers, so we can add them without fear. i.e.6 = got them all.

            //*******debug line*
            //SendMessageToPC(oPC,"This is "+sThis+" and I have a total of "+IntToString(nCurrent));
            if (nThis == 1 && GetLocalInt(oPC,"nGotKS1")==0) // I picked up keystone #1
            {
                //Deal with Guardian journal entries, dependant on info gathered (nMyth>0)
                if (GetLocalInt(oPC,"nMyth")>0)
                {
                    AddJournalQuestEntry("Guardian1",20,oPC);
                }
                else
                {
                    AddJournalQuestEntry("Guardian1",15,oPC);
                }
                PartyGotEntry("nGotKS1",oPC,250,"Keystone discovered"); //Only runs the check first time stone is picked up
                switch (nCurrent)
                {
                    case 0:
                        AllParty("nKeySTot",oPC,1); //This is my first
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",20,oPC);
                        break;
                    case 2:
                        AllParty("nKeySTot",oPC,3);// Got also #2
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",25,oPC);
                        break;
                    case 3:
                        AllParty("nKeySTot",oPC,4);// Got also #3
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",25,oPC);
                        break;
                    case 5:
                        AllParty("nKeySTot",oPC,6);// Got all
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",30,oPC);
                        break;
                }
            }
            else if (nThis==2 && GetLocalInt(oPC,"nGotKS2")==0) // I picked up keystone #2
            {
                //Deal with Guardian journal entries, dependant on info gathered.
                if (GetLocalInt(oPC,"nMyth")>0)
                {
                    AddJournalQuestEntry("Guardian2",20,oPC);
                }
                else
                {
                    AddJournalQuestEntry("Guardian2",15,oPC);
                }
                PartyGotEntry("nGotKS2",oPC,250,"Keystone discovered"); //Only runs the check first time stone is picked up
                switch (nCurrent)
                {
                    case 0:
                        AllParty("nKeySTot",oPC,2); //This is my first
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",20,oPC);
                        break;
                    case 1:
                        AllParty("nKeySTot",oPC,3);// Got also #1
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",25,oPC);
                        break;
                    case 3:
                        AllParty("nKeySTot",oPC,5);// Got also #2
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",25,oPC);
                        break;
                    case 4:
                        AllParty("nKeySTot",oPC,6);// Got all
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",30,oPC);
                        break;
                }
            }
            else if (nThis == 3 && GetLocalInt(oPC,"nGotKS3")==0) // I picked up keystone #3
            {
                //Deal with Guardian journal entries, dependant on info gathered.
                if (GetLocalInt(oPC,"nMyth")>0)
                {
                    AddJournalQuestEntry("Guardian3",20,oPC);
                }
                else
                {
                    AddJournalQuestEntry("Guardian3",15,oPC);
                }
                PartyGotEntry("nGotKS3",oPC,250,"Keystone discovered"); //Only runs the check first time stone is picked up
                switch (nCurrent)
                {
                    case 0:
                        AllParty("nKeySTot",oPC,3); //This is my first
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",20,oPC);
                        break;
                    case 1:
                        AllParty("nKeySTot",oPC,4);// Got also #1
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",25,oPC);
                        break;
                    case 2:
                        AllParty("nKeySTot",oPC,5);// Got also #2
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",25,oPC);
                        break;
                    case 3:
                        AllParty("nKeySTot",oPC,6);// Got all
                        if (GetLocalInt(oPC,"nMyth")>0)
                            AddJournalQuestEntry("Mythallar",30,oPC);
                        break;
                }
            }
        }
        else if (sTag == "DLA_JOUST_ARMOR")
        {// Set heavy armor feat so that the player can use this.
         // Needs to be taken away if the player leaves the jousting ground
         // or gives the armor back to Derry
            DLA_GiveFeat(oPC, IP_CONST_FEAT_ARMOR_PROF_HEAVY);
            itemproperty ipStrength = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,12);
            AddItemProperty(DURATION_TYPE_PERMANENT,ipStrength,oItem);
        }
        else if (sTag == "DLA_JOUST_SHIELD")
        {// Set shield feat so that the player can use this.
         // Needs to be taken away if the player leaves the jousting ground
         // or gives the shield back to Derry
            DLA_GiveFeat(oPC, IP_CONST_FEAT_SHIELD_PROFICIENCY);
        }

    }
}
