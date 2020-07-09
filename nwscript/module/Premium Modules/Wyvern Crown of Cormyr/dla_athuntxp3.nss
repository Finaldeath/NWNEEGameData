// December 2005
// B W-Husey
// NPC rewards template to be used after an action
// PC resists bluff by Huntcrown

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

//Pick Variable Type and rename

string sName = "XP3"+GetTag(OBJECT_SELF);                     //Unique tag

//Give rewards once only
if (GetLocalInt(oPC,sName)<1) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 75);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());
    }

}


