//::///////////////////////////////////////////////
//:: FileName con_ac_pc_druggd
//:: PC is drugged and wakes up in maze
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 12/4/2005 3:25:02 PM
//:://////////////////////////////////////////////

void ahcCreate(string s1, object oPC)
{
CreateItemOnObject(s1, oPC);
}

void ahcStrip(object oPC, object oBag)
{
object oItem = GetFirstItemInInventory(oPC);

while (GetIsObjectValid(oItem))
   {
   AssignCommand(oBag, ActionTakeItem(oItem, oPC));
   oItem = GetNextItemInInventory(oPC);
   }

int nInt;
for (nInt=0; nInt<NUM_INVENTORY_SLOTS; nInt++)
   {
   if (nInt==INVENTORY_SLOT_CARMOUR) continue;
   oItem = GetItemInSlot(nInt, oPC);
   if (GetIsObjectValid(oItem))
         AssignCommand(oBag, ActionTakeItem(oItem, oPC));
   }
DelayCommand(0.2, ahcCreate("ac_itm_petty", oPC));
DelayCommand(0.7, AssignCommand(oPC, ActionEquipItem(GetItemPossessedBy(oPC, "ac_itm_petty"), INVENTORY_SLOT_CHEST)));
}

void main()
{
    object oPC = GetPCSpeaker();
    object oJonas = GetObjectByTag("ac_jonas1");
    object oGravia = GetObjectByTag("ac_gravia");
    object oW = GetWaypointByTag("wp_maze_pc");
    object oWG = GetWaypointByTag("POST_ac_gravia");

    effect eS = EffectVisualEffect(VFX_IMP_SLEEP);

    SetCommandable(TRUE, oPC);
    SetCutsceneMode(oPC,TRUE);
    SetLocked(GetObjectByTag("ac_dr_pcstuff"),FALSE);
    FadeToBlack(oPC, FADE_SPEED_SLOW);

    SetLocalInt(GetObjectByTag("ac_gravia"), "no_banter", 1);
    SetLocalInt(GetModule(), "ac_werewolf", 3);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eS, oPC, 5.0);
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,5.0));
    DelayCommand(4.0,AssignCommand(oPC, ActionJumpToObject(oW)));
    DelayCommand(5.0,ahcStrip(oPC, GetObjectByTag("ac_playerchest")));
    DelayCommand(5.5, AssignCommand(oGravia, ClearAllActions()));
    DelayCommand(6.0, AssignCommand(oGravia, ActionJumpToObject(oWG)));
}
