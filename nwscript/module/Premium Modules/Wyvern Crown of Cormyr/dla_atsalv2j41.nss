// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// This pone pays the PC based on number of bandits killed, updates journal.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j41"+GetTag(OBJECT_SELF);                     //Unique tag
object oHench1 = ReturnHenchman(oPC,1);
object oHench2 = ReturnHenchman(oPC,2);
int nKills = GetLocalInt(oPC,"nBandits") + GetLocalInt(oHench1,"nBandits") + GetLocalInt(oHench2,"nBandits");


//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    GiveGoldToCreature(oPC,(nKills*2)+5);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);


    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AddJournalQuestEntry("Caravan",41,oPC,TRUE);                      //Update the journal
    }

}


