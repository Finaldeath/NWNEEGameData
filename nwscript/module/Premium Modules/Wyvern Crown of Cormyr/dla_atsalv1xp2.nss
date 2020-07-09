// October 2005
// B W-Husey
// NPC rewards template to be used after an action
// XP reward for skill use, gain 5 gold. Record it in the journal (pay for guard duty)

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
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AddJournalQuestEntry("Caravan",16,oPC,TRUE);
    }

}


