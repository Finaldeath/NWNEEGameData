////////////////////////////////////////////////////////////////////////////////
// dla_jt_tilt_res
//
// DLA Wyvern Crown of Cormyr
////////////////////////////////////////////////////////////////////////////////
/*
   Reset the player and opponent for another tilt (round) of the joust
*/
////////////////////////////////////////////////////////////////////////////////
// Created By: Dave Musser (Syrsnein)
// Created On: 12 July 2006
////////////////////////////////////////////////////////////////////////////////
/*
 Change History
 Date
 year/mm/dd | Author     | Change
 -----------+------------+------------------------------------------------------
 2006/07/23   Syrsnein     Removed helmet checks/re-equiping due to limitations,
                            of the graphics engine, concerning appearance changes.

 */

#include "dla_i0_joust"


/* Syrsnein: 23 July 2006 - Removed as we no longer remove helmets on helmet hits.
void privateJoustCheckHelm(object oCreature)
{
    object oBox  = GetObjectByTag(DLA_TAG_JOUST_HELMET_BOX);
    object oHead = GetItemInSlot(INVENTORY_SLOT_HEAD, oCreature);
    if (!GetIsObjectValid(oHead))
    {// Re-equip the helmet
        object oHelm = GetLocalObject(oCreature, DLA_VAR_JOUST_HELMET);
        if (GetItemPossessor(oHelm)!=oCreature)
            AssignCommand(oBox, ActionGiveItem(oHelm, oCreature));
        AssignCommand(oCreature, ActionEquipItem(oHelm, INVENTORY_SLOT_HEAD));
    }// Re-equip the opponents helmet
}
 */

//Syrsnein, 17 May 2006: Moved code to this function to reset for the next joust once
//   the opponents have exchanged words.
void main()
{
    object oPC = OBJECT_SELF;
    object oOP = GetLocalObject(oPC, DLA_VAR_JOUST_OPPONENT);
    float fCueTime = 0.0;

    if (!GetCutsceneMode(oPC))
        SetCutsceneMode(oPC);

    // Clear opponent joust variables
    DLA_DeleteAimPos(oOP);
    DLA_DeleteDefPos(oOP);
    DeleteLocalInt(oOP, DLA_OUTCOME_MASTER_VAR);

    // Clear player joust variables
    DLA_DeleteAimPos(oPC);
    DLA_DeleteDefPos(oPC);
    DeleteLocalInt(oPC, DLA_OUTCOME_MASTER_VAR);

    AssignCommand(oOP, ClearAllActions(TRUE));
    AssignCommand(oPC, ClearAllActions(TRUE));

//    DelayCommand(fCueTime+=0.1, privateJoustCheckHelm(oOP));
//    DelayCommand(fCueTime+=0.1, privateJoustCheckHelm(oPC));
/*
    if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oOP)))
    {// Re-equip the opponents helmet
        object oHelm = GetLocalObject(oOP, DLA_VAR_JOUST_HELMET);
        DelayCommand(fCueTime+=0.01, AssignCommand(oOP, DLA_ForceEquip(oOP,oHelm, INVENTORY_SLOT_HEAD)));
    }// Re-equip the opponents helmet

    // Have the PC requip their helmet
    if (!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC)))
    {// Re-equip the players helmet
        object oHelm = GetLocalObject(oPC, DLA_VAR_JOUST_HELMET);
        DelayCommand(fCueTime+=0.01, AssignCommand(oPC, DLA_ForceEquip(oPC, oHelm, INVENTORY_SLOT_HEAD)));
    }// re-equpi the players helmet
 */
    // Reset the lances
    DLA_ResetLance(GetLocalObject(oPC, DLA_VAR_JOUST_LANCE));
    DLA_ResetLance(GetLocalObject(oOP, DLA_VAR_JOUST_LANCE));

    // Set up the opponent for the next tilt
    DLA_SetupOpponent(oPC);

    //jump the participants to joust starting points
    location lOPWP = GetLocation(GetWaypointByTag("DLA_JOUST_OP_WPT1"));
    location lPCWP = GetLocation(GetWaypointByTag("DLA_JOUST_PC_WPT1"));
    AssignCommand(oOP, ActionJumpToLocation(lOPWP));
    AssignCommand(oPC, ActionJumpToLocation(lPCWP));
}

