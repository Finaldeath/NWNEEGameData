// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

    //Alignment consequences of action
    if(GetAlignmentLawChaos(oPC)==ALIGNMENT_LAWFUL) AligXP("AligXPllsssp", oPC, "LAWFUL", 20, 1); //Apply to specific alignment
}


