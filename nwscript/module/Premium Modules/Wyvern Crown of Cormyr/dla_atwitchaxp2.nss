// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC attacks the Witch Lord after intimidation. Very evil or chaotic.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "XPA2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
//    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AligXP2a", oPC, "CHAOTIC", 0, 2); //Apply to specific alignment
      AligXP("AligXP2WL1", oPC, "EVIL", 100, 1);        //Shift/reward any alignment
      AligXP("AligXP2bWL1", oPC, "CHAOTIC", 25, 1);        //Shift/reward any alignment

      AllParty(sName,oPC,2);                                    //Just sets variable
//    AddJournalQuestEntry("",1,oPC,TRUE);                      //Update the journal
    }

}


