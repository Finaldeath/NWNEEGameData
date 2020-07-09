//::////////////////////////////////////////////////////////////////////////////
//:: pus_id1_resttent
//:: Copyright (c) 2005 Bioware Corp.
//::////////////////////////////////////////////////////////////////////////////
/*
    On Used event for the resting tent placeables. When used these tents allow
    the player to rest provided the player is not currently in combat.
*/
//::////////////////////////////////////////////////////////////////////////////
//:: Created By: Grant Mackay
//:: Created On: November 10, 2005
//::////////////////////////////////////////////////////////////////////////////
#include "inc_id1_debug"
void main()
{
    object oUser = GetLastUsedBy();

    // Do not allow resting while in the middle of combat.
    if (GetIsInCombat(oUser)) return;

    // Set a variable on the user indicating they should be allowed to rest.
    SetLocalInt(oUser, "bCanRest", TRUE);
    DelayCommand(0.5, SetLocalInt(oUser, "bCanRest", FALSE));

    // Clear the user's action queue and cause them to rest.
    DebugMessage("Clearing actions. Point 39.");
    AssignCommand(oUser, ClearAllActions());
    AssignCommand(oUser, ActionRest(TRUE));

    // rest henchmen
    int nCount = 1;
    object oHenchman = GetHenchman(oUser, nCount);
    while (oHenchman != OBJECT_INVALID)
    {
        SetLocalInt(oHenchman, "bCanRest", TRUE);
        DelayCommand(0.5, SetLocalInt(oHenchman, "bCanRest", FALSE));
        DebugMessage("Clearing actions. Point H39.");
        AssignCommand(oHenchman, ClearAllActions());
        AssignCommand(oHenchman, ActionRest(TRUE));

        nCount++;
        oHenchman = GetHenchman(oUser, nCount);
    }
}
