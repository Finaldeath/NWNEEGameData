// January 2006
// B W-Husey
// NPC rewards template to be used after an action
// Imelda is persuaded to pay more. Updates the token with the amount in it.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "iO200"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {


    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (oPC, 50);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    AllParty("nIOffer",oPC,200); // Offer value
    ExecuteScript("dla_atimeldatoke",oPC);
    }

}

