// B W-Husey
// December 2005
// XP for skill use
// Convinced Alice that the PC never had the horn

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "XP5"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {
    GiveXPToCreature (GetPCSpeaker(), 75);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());
    }
}

