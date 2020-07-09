//::///////////////////////////////////////////////
//:: FileName ou_ac_plc_yentai
//:: Creates note on player and destroys self
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/18/2005 3:25:02 PM
//:://////////////////////////////////////////////
#include "nw_o2_coninclude"
void main()
{
if (GetLocalInt(OBJECT_SELF, "fired") == 1) return;
SetLocalInt(OBJECT_SELF, "fired", 1);
object oPC = GetLastUsedBy();
CreateItemOnObject("ac_yentai_note", oPC, 1);
FloatingTextStringOnCreature("You took the note.", oPC);
DestroyObject(OBJECT_SELF, 0.5);
}


