// April 2004
// B W-Husey
// NPC rewards template to be used after an action

// We bullied Matron, and we didn't listen to her: clearly not a lawful action
// (and not a particular good one either so no points for lawful, or NG alignments)
// This action brings a shift towards chaotic if you are lawful

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AXP4"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    // We are using the same variable here for both, so a true neutral character only gets 1 of the bonuses.
    AligXP(sName, oPC, "NEUTRAL", 25, 0);        //Shift/reward any alignment
    AligXP(sName, oPC, "CHAOTIC", 25, 0);        //Shift/reward any alignment
    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AXP4bMatron", oPC, "CHAOTIC", 0, 1); //Apply to specific alignment
    ScoreAlign(oPC,1,0,0,1,0,1,1,0,1,1);
    }

}







