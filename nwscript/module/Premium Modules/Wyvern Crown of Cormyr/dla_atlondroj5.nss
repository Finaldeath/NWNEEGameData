// October 2005
// B W-Husey
// Set the journal entry to state 34 for The Apprentice Slave. The PC got a written promise of aid to
// Londro from the Matron, and gave it to Londro even though it was clear they had been duped.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();
AddJournalQuestEntry("TheApprenticeSlave",34,oPC,TRUE);
//Pick Variable Type and rename
string sName = "AligXPEnd"+GetTag(OBJECT_SELF);

if (GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL)  AligXP("AligXPSp", oPC, "GOOD", 0, 1);        //Shift/reward any alignment
AligXP("AligXPSp", oPC, "GOOD", 25, 0);        //Shift/reward any alignment

AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0));
DestroyObject(GetObjectByTag("WitnessDoc"));

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    ScoreAlign(oPC,1,1,1,1,1,1,1,0,0,0);
    AllParty(sName,oPC,1);
    }
}

