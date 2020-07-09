// April 2004
// B W-Husey
// NPC rewards template to be used after an action
// Not Offering to help Manthia and not being very nice about it - shift away from good for good characters.
// Evil characters pick up some xp (they can still get the quest)

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AligXP2"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //Alignment consequences of action
    if (GetAlignmentGoodEvil(oPC)==ALIGNMENT_GOOD) AligXP(sName, oPC, "NEUTRAL", 0, 1);
    else  AligXP(sName, oPC, "EVIL", 25, 0);
    AllParty(sName,oPC,1);
    }

}







