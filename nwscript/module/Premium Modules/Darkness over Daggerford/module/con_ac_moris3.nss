//::///////////////////////////////////////////////
//:: FileName con_ac_moris3
//:: Elveronne takes the necklace from player and the variable is set
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: 11/13/2005 11:59:20 PM
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
#include "nw_i0_tool"

void main()
{
    object oPC = GetPCSpeaker();

    // update the plot
    SetLocalInt(oPC, "moris_quest", 3);
    SetLocalInt(oPC, "elveronne_quest", 7);
    SetLocalInt(OBJECT_SELF, "no_banter", 1);

    // destroy the necklace
    object oItemToTake = GetItemPossessedBy(oPC, "ac_itm_necklace");
    if(GetIsObjectValid(oItemToTake) != 0)
    DestroyObject(oItemToTake);

    // close his coffin back in the graveyard
    object oC = GetObjectByTag("ac_sarcophagus2");
    AssignCommand(oC, PlayAnimation(ANIMATION_PLACEABLE_CLOSE));

    // open the basement door
    object oD = GetObjectByTag("C1AR0701C_C1AR0700_EXIT");
    SetLocked(oD, FALSE);
    ActionOpenDoor(oD);

    // flee
    SetLocalString(OBJECT_SELF, "HF_EXIT_NAME", "WP_AR0701C_ELVERONNE_EXIT");
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
