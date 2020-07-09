// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC bargains with the Witch Lord. Alignment onsequences favour evil.

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
      if(GetAlignmentGoodEvil(oPC)!=ALIGNMENT_NEUTRAL) AligXP("AligXP1WL1", oPC, "EVIL", 100, 1);        //Shift/reward any alignment
      if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD) AligXP("AligXP1bWL1", oPC, "CHAOTIC", 0, 2);        //Shift/reward any alignment

      AllParty(sName,oPC,2);                                    //Just sets variable
//    AddJournalQuestEntry("",1,oPC,TRUE);                      //Update the journal
      ScoreAlign(oPC,2,0,1,1,0,2,2,2,2,2);            //Who gets alignment points for this
    }
}


