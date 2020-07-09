// April 2004
// B W-Husey
// NPC rewards template to be used after an action
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename
string sName = "AXP1"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {

    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());

    //Set variable for PC or partywide
    PartyGotEntry(sName,oPC,100, "XP gain - payment promised");  //Reward whole party TrapXPGain/2 for trap removal, tell all party members what XP is for, and set the variable so the XP cannot be gained again.
    }

}







