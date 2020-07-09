// January 2006
// B W-Husey
// PC delivers Imelda to Thiodor Hurim
// Alignment consequences: This is a lawful outcome, and favours good over evil.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XPInote2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
//    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AligXP2a", oPC, "CHAOTIC", 0, 2); //Apply to specific alignment
    AligXP("AligXPImRev3", oPC, "LAWFUL", 100, 1);        //Shift/reward any alignment

    //XP reward (non-alignment based) - quest, skill, class, ability use
//    GiveXPToCreature (GetPCSpeaker(), 50);
//    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty("nRevenge",oPC,3);
    PartyGotEntry(sName,oPC,500,"XP Gain - Quest completed");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("Revenge",40,oPC,TRUE);                      //Update the journal
    ScoreAlign(oPC,5,5,5,5,5,4,3,4,3,0);            //Who gets alignment points for this
    GiveKnightReputation(oPC,"the Just");
    }

}


