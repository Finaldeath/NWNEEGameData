//::///////////////////////////////////////////////
//:: FileName ou_ac_treas_clas
//:: Creates level adjusted class item (usually weapon)
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////
#include "nw_o2_coninclude"
void main()
{
if (GetLocalInt(OBJECT_SELF,"fired")==1) return;
object oPC = GetLastUsedBy();
CreateGenericClassItem(OBJECT_SELF,oPC);
SetLocalInt(OBJECT_SELF,"fired",1);
}


