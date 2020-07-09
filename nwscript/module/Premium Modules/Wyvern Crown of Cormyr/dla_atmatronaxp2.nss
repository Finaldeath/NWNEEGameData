// April 2004
// B W-Husey
// NPC rewards template to be used after an action

// This was the gentle outcome, full of fairness and listening. No one suffers on this option, but there is an xp
// benefit for lawful and good characters (though only 1 bonus is possible for LG characters).

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AXP2"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD) AligXP(sName, oPC, "GOOD", 25, 1); //Apply to specific alignment
    AligXP(sName, oPC, "LAWFUL", 25, 0); //Apply to specific alignment
    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,120, "XP gain - payment promised");  //Reward whole party TrapXPGain/2 for trap removal, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
    ScoreAlign(oPC,1);
    }

}







