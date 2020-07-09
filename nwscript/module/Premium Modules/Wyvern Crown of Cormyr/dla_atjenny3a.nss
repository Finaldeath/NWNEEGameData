// AJanuary 2006
// B W-Husey
// NPC rewards template to be used after an action
// Jenny takes the good Stag hide

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP3"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);


    // Remove from the player
//    TakeGoldFromCreature(5, GetPCSpeaker(), FALSE);
    DestroyObject(GetObjectByTag("WhiteStagOK"));

    //Alignment consequences of action
    AligXP("AligXP3Jen", oPC, "GOOD", 150, 2);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AllParty("nWStag",oPC,3);                                    //Just sets variable
    PartyGotEntry(sName,oPC,100,"XP Gain - Oath extracted");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("WStag",70,oPC,TRUE);                      //Update the journal
    }

}


