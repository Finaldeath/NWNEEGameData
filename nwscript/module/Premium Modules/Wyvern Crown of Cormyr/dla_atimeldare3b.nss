// January 2006
// B W-Husey
// PC sells Imelda's note.
// Alignment consequences: This is not a lawful outcome, nor a good one, as the PC just crossed Hawklin.

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
     GiveGoldToCreature(oPC,GetLocalInt(oPC,"nIOffer"));
//    object oItem = GetItemPossessedBy(oPC,"imledasnote");
//  AssignCommand(oPC,ActionGiveItem(oItem,OBJECT_SELF));
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,1.0));
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);

    // Remove from the player
//    DestroyObject(GetObjectByTag("ImeldasNote"));

    //Alignment consequences of action
//    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AligXP2a", oPC, "CHAOTIC", 0, 2); //Apply to specific alignment
    AligXP("AligXPImRev3", oPC, "EVIL", 100, 1);        //Shift/reward any alignment
    AligXP("AligXPImRev3", oPC, "CHAOTIC", 0, 1);        //Shift/reward any alignment

    //XP reward (non-alignment based) - quest, skill, class, ability use
//    GiveXPToCreature (GetPCSpeaker(), 50);
//    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty("nRevenge",oPC,3);
    PartyGotEntry(sName,oPC,500,"XP Gain - Quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Revenge",30,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,0,1,2,1,5,5,2,5,5);            //Who gets alignment points for this
    GiveKnightReputation(oPC,"the Black");
    }

}


