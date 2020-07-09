// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC gives Imelda's Note to Lord Hawklin. Journal, variable and xp rewards.
// Found in hawklin2 dialogue

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XPInote"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    object oItem = GetItemPossessedBy(oPC,"ImeldasNote");
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
    ActionPlayAnimation(ANIMATION_FIREFORGET_READ,1.0);

    // Remove from the player
    SetPlotFlag(oItem,FALSE);
    SetItemCursedFlag(oItem,FALSE);
    DestroyObject(oItem);

    //Set variable for PC or partywide
    AllParty("nRevenge",oPC,2);                                    //Just sets variable
    PartyGotEntry(sName,oPC,100,"XP Gain - quest furthered");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Revenge",20,oPC,TRUE);                      //Update the journal
    }

}


