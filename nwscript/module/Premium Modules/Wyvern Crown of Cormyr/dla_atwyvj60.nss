// January 2006
// B W-Husey
// PC swaps the Ball for an item.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "j60"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    object oItem = GetItemPossessedBy(OBJECT_SELF,"WyvernNecklace");
    ActionGiveItem(oItem,oPC);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);


    // Remove from the player
       object oBall = GetObjectByTag("CrystalBall");
       SetPlotFlag(oBall,FALSE);
       DestroyObject(oBall);

    //Alignment consequences of action
    AligXP("AligXP1wj59", oPC, "CHAOTIC", 0, 1);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty("nMyth",oPC,3);                                    //Mythallar variable set to ball returned
    PartyGotEntry(sName,oPC,120,"XP Gain - Ball returned");
    AddJournalQuestEntry("Mythallar",60,oPC,TRUE);             //Update the journal
    //Bonus just for this action
    ScoreAlign(oPC,1,1,1,1,1,1,1,0,0,0);            //Who gets alignment points for this
    }

}





