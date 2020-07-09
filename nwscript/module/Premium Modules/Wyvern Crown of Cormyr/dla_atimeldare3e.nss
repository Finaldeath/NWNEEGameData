// January 2006
// B W-Husey
// PC reports Hawklin. Thiodor promises to investigate.
// Alignment consequences: This is an evil outcome.

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

    // Remove from the player


    //Alignment consequences of action
    AligXP("AligXPImRev3", oPC, "EVIL", 100, 1);        //Shift/reward any alignment

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 120);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty("nRevenge",oPC,3);
    PartyGotEntry(sName,oPC,500,"XP Gain - Quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Revenge",50,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,1,0,0,4,3,2,5,5,5);            //Who gets alignment points for this
    }

}


