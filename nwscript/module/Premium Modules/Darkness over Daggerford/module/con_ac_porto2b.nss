//::///////////////////////////////////////////////
//:: FileName con_ac_porto2
//:: Set Porto and Millie to banter mode
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/18/2005 2:50:30 PM
//:://////////////////////////////////////////////
void main()
{
object oP = GetObjectByTag("ac_porto");
object oM = GetObjectByTag("ac_millie");
SetLocalInt(oP, "no_banter", 0);
SetLocalInt(oM, "no_banter", 0);
}
