#include "rb_include"
//::///////////////////////////////////////////////
//:: FileName con_ac_bothdrink
//:: Taffy and player both drink
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 10/24/2005 12:35:30 AM
//:://////////////////////////////////////////////
void main()
{
    //Variables
    object oPC = GetPCSpeaker();

    //Actions
    DelayCommand(1.0,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK));
    DelayCommand(1.0,AssignCommand(oPC,ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK)));
    //ActionTakeItem(GetItemPossessedBy (oPC, "ac_harborbottom"), oPC);
    TakeSingleItem(oPC, "ac_harborbottom");
}
