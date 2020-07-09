// B W-Husey
// September 2005
// XP for ability use
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "XP2"+GetTag(OBJECT_SELF);
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);
//string sName = "Stan1"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 80);
    FloatingTextStringOnCreature("XP Gained - skill resisted",GetPCSpeaker());
    AllParty(sName,oPC,2);
    }

}








