// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Found on Huntcrown, this sets the Ride like a centaur variable to 3 or 4 (got oath and can/cannot complete)
// Updates Ride journal, rewards xp. Only differnce from A is that this gives more xp.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "HOath"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
//    object oItem = GetItemPossessedBy(OBJECT_SELF,"huntcrownsoath");
    CreateItemOnObject("huntcrownsoath",oPC);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);


    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,250,"XP Gain - Oath extracted");  //This comes with XP & message + sets the variable
    if (GetLocalInt(oPC,"nMainPlot")<4)
        {
        AllParty("nManthia1Side",oPC,3); //Update ride Like a centaur quest - completable
        AddJournalQuestEntry("Centaur",30,oPC,TRUE);                      //Update the journal
        }
    else
        {
        AllParty("nManthia1Side",oPC,4); //Update ride Like a centaur quest - uncompletable
        AddJournalQuestEntry("Centaur",50,oPC,TRUE);                      //Update the journal
        }
    }

}


