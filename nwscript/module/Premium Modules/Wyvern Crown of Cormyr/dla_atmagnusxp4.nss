// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC appraises horn value

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP4"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 100);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());
    SetLocalInt(GetPCSpeaker(), "nHornGold", 500);
    AddJournalQuestEntry("Order",21,oPC);
    }

}

