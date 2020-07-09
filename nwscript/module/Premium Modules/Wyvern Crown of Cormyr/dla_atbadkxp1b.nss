// March 2006
// B W-Husey
// NPC rewards template to be used after an action
// Bad knight pays 100 gold to cover cost of grave. Update with correct journal entry

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    GiveGoldToCreature(oPC,100);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    //Add the correct journal entry depending on what has been done already
    if (GetLocalInt(oPC,"nGrave")==5)    AddJournalQuestEntry("Grave",60,oPC,TRUE);                      //Update the journal
    else if (GetLocalInt(oPC,"nGrave")==6)    AddJournalQuestEntry("Grave",70,oPC,TRUE);                      //Update the journal
    }

}


