// B W-Husey
// September 2005
// XP for ability use
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "XP1"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 100);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());
    AllParty(sName,oPC,2);
    }

}








