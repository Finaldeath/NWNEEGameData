// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// Huntcrown is blackmailed for 200 gold.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    GiveGoldToCreature(oPC,200);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);


    //Alignment consequences of action
    AligXP("AligXP2Hunt", oPC, "CHAOTIC", 50, 1);        //Shift/reward any alignment
    AligXP("AligXP2Huntb", oPC, "EVIL", 50, 0);        //Shift/reward any alignment

    //XP reward (non-alignment based) - quest, skill, class, ability use
//    GiveXPToCreature (GetPCSpeaker(), 50);
//    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AddJournalQuestEntry("Centaur",15,oPC,TRUE);                      //Update the journal
    }

}


