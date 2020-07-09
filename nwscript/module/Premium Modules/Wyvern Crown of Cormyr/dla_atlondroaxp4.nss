// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Wish to report on failing Londro's quest.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AligXP4"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    ScoreAlign(oPC,1,1,0,0,1,0,0,1,0,0);
    }
}






