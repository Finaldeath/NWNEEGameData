// January 2006
// B W-Husey
// PC reports Imelda, gives note to Hurim.
// Alignment consequences: This is a lawful outcome, with strongest benefits for neutral players.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XPInote2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    // reward goldor items
//    object oItem = GetItemPossessedBy(oPC,"imledasnote");
//  AssignCommand(oPC,ActionGiveItem(oItem,OBJECT_SELF));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.0));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);

    // Remove from the player
    DestroyObject(GetObjectByTag("ImeldasNote"));

    //Alignment consequences of action
    if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_NEUTRAL) AligXP("AligXPImRev3b", oPC, "NEUTRAL", 150, 1); //Apply to specific alignment
    AligXP("AligXPImRev3", oPC, "LAWFUL", 100, 1);        //Shift/reward any alignment

    //XP reward (non-alignment based) - quest, skill, class, ability use
//    GiveXPToCreature (GetPCSpeaker(), 50);
//    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty("nRevenge",oPC,3);
    PartyGotEntry(sName,oPC,500,"XP Gain - Quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Revenge",18,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,4,4,3,5,5,4,4,2,0);            //Who gets alignment points for this
    }

}


