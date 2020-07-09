//::///////////////////////////////////////////////
//:: FileName con_ac_vladport4
//:: Set quest completion for retrieving portrait
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/15/2005 3:22:44 PM
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();
    SetLocalInt(oPC, "ac_vlad_paint_quest", 4);
    SetLocalInt(oPC, "ac_davey_quest", 5);
    ActionTakeItem(GetItemPossessedBy(oPC,"ac_portrait_grts"), oPC);
}
