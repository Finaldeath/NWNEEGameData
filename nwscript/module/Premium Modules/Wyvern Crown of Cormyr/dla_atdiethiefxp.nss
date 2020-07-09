// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
location lLoc = GetLocation(GetWaypointByTag("WP_PFTDEntry"));
string sName = "XP1"+GetTag(OBJECT_SELF);                     //Unique tag
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);   //Generic tag used in conversations
//string sName = "Stan1"+GetTag(OBJECT_SELF);                   //Generic tag used in conversations

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {


    //Alignment consequences of action
//    if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL) AligXP("AligXP1dthief", oPC, "EVIL", 50, 0); //Apply to specific alignment
    DLA_ReturnOwnedHorsesOnAreaToPCParty(oPC);
    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
//    PartyGotEntry(sName,oPC,100,"XP Gain - Oath extracted");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Careless",30,oPC,TRUE,FALSE,TRUE);                      //Update the journal
    AssignCommand(oPC,JumpToLocation(lLoc));
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    DelayCommand(30.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(10),OBJECT_SELF));
    }

}





