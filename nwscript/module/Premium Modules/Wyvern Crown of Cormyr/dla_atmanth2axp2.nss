// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "AXP2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    AligXP("AligXPManth22a", oPC, "GOOD", 50, 1); //Apply to specific alignment
    AligXP("AligXPManth22b", oPC, "LAWFUL", 50, 0);        //Shift/reward any alignment
    }
}


