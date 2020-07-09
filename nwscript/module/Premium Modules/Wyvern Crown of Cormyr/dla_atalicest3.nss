// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC gives Huntcrown the horn for cash - this is on Huntcrown not Alice Broadhand
// Alignmentwise, PC cut Alice out of the loop, so not very good option

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "GHorn"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    GiveGoldToCreature(oPC,800);
    object oItem = GetItemPossessedBy(oPC,"UnicornHorn");
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);

    // Remove from the player
    SetPlotFlag(oItem, FALSE);
    DestroyObject(oItem);

    AligXP("AXPGHunt", oPC, "EVIL", 50, 1);        //Shift/reward any alignment
    AligXP("AXPG2Hunt", oPC, "CHAOTIC", 50, 0);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty("nToOrder",oPC,3);   //Update Theft to Order variable
    PartyGotEntry(sName,oPC,300,"XP Gain - Horn returned");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Order",40,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,3,0,1,2,0,2,3,2,3,3);            //Who gets alignment points for this
    }
}


