// September 2005
// B W-Husey
// Forcing a door. Note variables are on the jammed door - this may not be the same as
// the conversing door.

#include "cu_functions"
void main()
{
object oPC = GetPCSpeaker();
string sName = "iUnforced";
//    object oStuck = GetNearestObjectByTag("JammedDoor");
    object oStuck = GetNearestObjectByTag("PFEastTowerSouth");

//Give rewards once only
if (GetLocalInt(oStuck,sName)<1) //once only
    {
    int xp = GetLocalInt(oStuck,"DOOR_OPEN"); //This is set on the door variables.
    //XP reward (non-alignment based) - quest, skill, class, ability use
    GiveXPToCreature (GetPCSpeaker(), xp);
    FloatingTextStringOnCreature("XP Gained - use of attribute",GetPCSpeaker());
    SetLocalInt(oStuck, sName,1);
    }

}







