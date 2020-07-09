// March 2006
// B W-Husey
// NPC rewards template to be used after an action
// Bad knight is made to do a penance. Update with correct journal entry and give relevant XP and reputation

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use

    if (GetLevelByClass(CLASS_TYPE_CLERIC,oPC)>0 || GetLevelByClass(CLASS_TYPE_DRUID,oPC)>0 || GetLevelByClass(CLASS_TYPE_PALADIN,oPC)>0 || GetLevelByClass(CLASS_TYPE_MONK,oPC)>0)
    {
        GiveXPToCreature (GetPCSpeaker(), 200);
        FloatingTextStringOnCreature("XP Gained - class roleplaying",GetPCSpeaker());
    }
    else
    {
            AligXP("AligXP1BK", oPC, "GOOD", 50, 1);
    }

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    //Add the correct journal entry depending on what has been done already
    if (GetLocalInt(oPC,"nGrave")==5)    AddJournalQuestEntry("Grave",62,oPC,TRUE);                      //Update the journal
    else if (GetLocalInt(oPC,"nGrave")==6)    AddJournalQuestEntry("Grave",72,oPC,TRUE);                      //Update the journal
    GiveKnightReputation(oPC,"the Devout");
    }

}


