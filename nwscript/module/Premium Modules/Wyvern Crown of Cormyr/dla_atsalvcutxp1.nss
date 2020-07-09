// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "XP1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {


    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    AllParty(sName,oPC,2);                                    //Just sets variable
//    AddJournalQuestEntry("",1,oPC,TRUE);                      //Update the journal
    }

}


