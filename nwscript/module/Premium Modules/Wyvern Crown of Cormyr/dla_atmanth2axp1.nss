// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "AXP1"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL) AligXP("AligXPManth21a", oPC, "EVIL", 50, 1); //Apply to specific alignment
    AligXP("AligXPManth21b", oPC, "CHAOTIC", 25, 1);        //Shift/reward any alignment
    }
}


