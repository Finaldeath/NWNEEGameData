//::///////////////////////////////////////////////
//:: FileName ac_itm_necklace
//:: Unique power of cursed necklace - part 1
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/29/2005 11:59:20 PM
//:://////////////////////////////////////////////
void main()
{
object oPC = GetPCItemLastEquippedBy();
SetLocalObject(GetModule(), "ac_cursed", oPC);
DelayCommand(240.0, ExecuteScript("ac_necklace_curs", oPC));
}
