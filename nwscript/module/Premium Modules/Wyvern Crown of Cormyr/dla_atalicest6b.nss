// December 2005
// B W-Husey
// PC has given the horn to Alice Broadhand
// Alignment consequences - no one suffers on this one as any alignment has the motive to
// complete this.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "st6"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
    GiveGoldToCreature(oPC,800);
    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);


    // Remove from the player
    DestroyObject(GetObjectByTag("UnicornHorn"));

    //Alignment consequences of action
//    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AligXP2a", oPC, "CHAOTIC", 0, 2); //Apply to specific alignment
//    AligXP("AligXP2", oPC, "EVIL", 25, 1);        //Shift/reward any alignment

    //Set variable for PC or partywide
    AllParty("nToOrder",oPC,6);
    PartyGotEntry(sName,oPC,300,"XP Gained - quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Order",30,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,3,3,3,3,3,3,3,3,3,3);            //Who gets alignment points for this
    }

}


