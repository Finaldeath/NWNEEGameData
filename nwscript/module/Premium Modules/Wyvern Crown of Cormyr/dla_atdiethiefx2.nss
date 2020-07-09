
// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP2"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    if(GetAlignmentGoodEvil(oPC)==ALIGNMENT_EVIL) AligXP("AligXP1dthief", oPC, "EVIL", 50, 0); //Apply to specific alignment
    }

}

