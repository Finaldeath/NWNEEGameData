// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// Imelda persuaded for balckmail. Set nIOffer to amount.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "io2000p"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 75);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty(sName,oPC,2);                                    //Just sets variable
    AllParty("nIOffer",oPC,3000);
    ExecuteScript("dla_atimeldatoke",oPC);
    }

}


