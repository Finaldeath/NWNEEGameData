// April 2004
// B W-Husey
// NPC rewards template to be used after an action

// We persuaded Matron, though we didn't listen to her (an injustice therefore not suitable for lawful)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AXP3"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    AligXP(sName, oPC, "CHAOTIC", 25, 0);        //Shift/reward any alignment
    AligXP(sName, oPC, "NEUTRAL", 25, 0);        //Shift/reward any alignment
    ScoreAlign(oPC,1,0,1,1,0,1,1,0,1,1);
    }

}







