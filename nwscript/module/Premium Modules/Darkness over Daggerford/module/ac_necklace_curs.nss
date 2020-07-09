//::///////////////////////////////////////////////
//:: FileName ac_itm_necklace
//:: Unique power of cursed necklace - part 2 recurring
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/29/2005 11:59:20 PM
//:://////////////////////////////////////////////void main()
void main()
{
object oPC = GetLocalObject(GetModule(), "ac_cursed");
if (GetTag(GetItemInSlot(INVENTORY_SLOT_NECK,oPC))!= "ac_itm_necklace") return;
if (IsInConversation(oPC))
{
DelayCommand(60.0, ExecuteScript("ac_necklace_curs", oPC));
}
if (GetIsResting(oPC))
{
DelayCommand(60.0, ExecuteScript("ac_necklace_curs", oPC));
}
effect eD = EffectDazed();
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eD, oPC, 60.0);
FloatingTextStringOnCreature("A vision of an elf maiden appears in your mind's eye.", oPC);
DelayCommand(720.0, ExecuteScript("ac_necklace_curs", oPC));
}
