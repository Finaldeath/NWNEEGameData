// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Evil xp for not even pretending to help Jenny iin return for her help.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();
    //Alignment consequences of action
    AligXP("JennyNoAXP1", oPC, "EVIL", 50, 0);        //Shift/reward any alignment
}


