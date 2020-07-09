//::///////////////////////////////////////////////
//:: pfp_a1trogcell
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This placable Fail to Open script will call
    the Troglodyte guard near this door to come
    over and strike up a conversation with the last
    object to fail opening the door.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Oct, 2004
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oSelf);
    object oGuard = GetObjectByTag("a1_fightguard");

    AssignCommand(oGuard, ActionStartConversation(oPC, "a1_fightguard"));
}
