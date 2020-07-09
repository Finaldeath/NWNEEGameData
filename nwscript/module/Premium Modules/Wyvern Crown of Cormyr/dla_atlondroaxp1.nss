// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Giving cash to Londro would score as a good deed, even if it is a bit naive! Since there are no
// alternative consequences, only non-good characters can actually suffer scorewise, and only by doing this.

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
    ScoreAlign(oPC,1,1,1,1,0,0,0,0,0,0);
    AllParty(sName,oPC,1);
    }

}







