//::///////////////////////////////////////////////
//:: exe_a3_drgnnt
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The Dragon initiates with the PC after the
    Cutscene with the sharks in Fiddlers Green
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////

void main()
{
    object oDragon = GetObjectByTag("a3_dragona");
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
        PLAYER_CHAR_IS_PC, oDragon);

    // Start a coonversation with the PC
    AssignCommand(oDragon, ClearAllActions(TRUE));
    DelayCommand(0.5f, AssignCommand(oDragon, ActionStartConversation(oPC)));
}
