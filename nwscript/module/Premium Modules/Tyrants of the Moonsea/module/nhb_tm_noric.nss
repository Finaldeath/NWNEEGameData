//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: nhb_tm_noric
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: Specific checks for Noric turning hostile
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
#include "x0_i0_walkway"

void main()
{
    if(GetWalkCondition(NW_WALK_FLAG_CONSTANT))
    {
        WalkWayPoints();
    }

    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC,
                                    OBJECT_SELF, 1,
                                    CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
    object oTarget = OBJECT_SELF;

    if(!GetIsPC(oPC)) return;

    if (IsInConversation(OBJECT_SELF) || GetIsInCombat()) return;

    if ((GetTag(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC)) == "DeputyHelm") &&
        (GetTag(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC)) == "DeputyChainmail"))
       return;

    if (GetIsEnemy(oPC, OBJECT_SELF))
       return;

    if(GetLocalInt(oPC, "dominatednoric") == 1 ||
       GetLocalInt(oPC, "charmednoric") == 1 ||
       GetLocalInt(oPC, "beguilednoric") == 1 ||
       GetLocalInt(oPC, "bribednoric") == 1)
    {
        return;
    }

    ClearAllActions();
    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);
    AdjustReputation(oPC, oTarget, -100);

    FloatingTextStringOnCreature("The deputy notices immediately that you aren't Grimswold and calls for help. The tower alarm begins to sound.", oPC);

    AddJournalQuestEntry("LocktowerRescue", 80, oPC);

    SetIsTemporaryEnemy(oPC, oTarget);
    DelayCommand(1.0, SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_SHOUT));

    ActionAttack(oPC);
    DetermineCombatRound(oPC);
}
