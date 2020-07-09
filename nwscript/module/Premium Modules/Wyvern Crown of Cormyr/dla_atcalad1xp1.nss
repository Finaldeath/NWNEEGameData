// January 2006
// B W-Husey
// PC has bluffed that they do not know Jonas.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    AligXP("AligXP1Cal1", oPC, "EVIL", 75, 0);        //Shift/reward any alignment

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 100);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
//    PartyGotEntry(sName,oPC,100,"XP Gain - Oath extracted");  //This comes with XP & message + sets the variable
    AddJournalQuestEntry("QRing",31,oPC,TRUE);                      //Update the journal
//  ScoreAlign(oPC,Max,LG,NG,CG,LN,TN,CN,LE,NE,CE);            //Who gets alignment points for this
    }

}


