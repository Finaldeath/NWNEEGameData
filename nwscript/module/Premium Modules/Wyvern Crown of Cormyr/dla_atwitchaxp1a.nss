// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC attacks the Witch Lord without any additional bargaining. Work of a good character.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "XPA1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
//    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AligXP2a", oPC, "CHAOTIC", 0, 2); //Apply to specific alignment
      AligXP("AligXP1WL1", oPC, "GOOD", 100, 1);        //Shift/reward any alignment
      AligXP("AligXP1bWL1", oPC, "LAWFUL", 25, 0);        //Shift/reward any alignment

      AllParty(sName,oPC,2);                                    //Just sets variable
//    AddJournalQuestEntry("",1,oPC,TRUE);                      //Update the journal
      ScoreAlign(oPC,2,2,2,2,2,2,1,1,0,0);            //Who gets alignment points for this
    }

}


