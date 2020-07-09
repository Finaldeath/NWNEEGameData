// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Offering to help Manthia without any incentive - good shift and xp for good.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AligXP1"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    AligXP(sName, oPC, "GOOD", 50, 1);
    AllParty(sName,oPC,1);
    }

}







