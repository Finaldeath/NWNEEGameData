//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: nhb_tm_deputy
// DATE: October 16, 2005
// AUTH: Luke Scull
// NOTE: If the player has not got deputy chainmail
//       AND helm equipped, Bron's Deputy faction will
//       go hostile.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
#include "nw_i0_generic"
void main()
{
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

    if(GetLocalInt(OBJECT_SELF, "nStunned") == 1) return;

    AdjustReputation(oPC, oTarget, -100);

    FloatingTextStringOnCreature("The deputy notices immediately that you aren't Grimswold and calls for help. The tower alarm begins to sound.", oPC);

    AddJournalQuestEntry("LocktowerRescue", 80, oPC);

    SetIsTemporaryEnemy(oPC, oTarget);
    DelayCommand(1.0, SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_SHOUT));
    ActionAttack(oPC);
    DetermineCombatRound(oPC);
}
