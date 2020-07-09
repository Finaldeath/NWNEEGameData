// August 2006
// B W-Husey
// NPC rewards template to be used after an action
// Major hit for paladins that try to sell their mounts

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AXPPal"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //Alignment consequences of action
    AligXP(sName, oPC, "EVIL", 0, 5);        //Shift/reward any alignment
    AligXP("WPalAXP", oPC, "CHAOTIC", 0, 5);        //Shift/reward any alignment
    }

}


