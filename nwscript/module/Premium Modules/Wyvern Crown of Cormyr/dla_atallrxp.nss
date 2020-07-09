// B W-Husey
// October 2005
// XP for skill use - this one is for any rumour gathering skill use.
#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();

string sName = "XPr"+GetTag(OBJECT_SELF);
//string sName = "Var1"+GetStringLeft(GetTag(OBJECT_SELF),6);
//string sName = "Stan1"+GetTag(OBJECT_SELF);

//Give rewards once only
if (GetLocalInt(oPC,sName)<2) //once only
    {
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), 50);
    FloatingTextStringOnCreature("XP Gained - use of skill",GetPCSpeaker());
    AllParty(sName,oPC,2);
    }

}








