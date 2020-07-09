#include "nw_i0_generic"

void main()
{
    object oPC = GetPCSpeaker();

    DelayCommand(1.0, SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK));

    AdjustReputation(oPC, OBJECT_SELF, -100);
    DetermineCombatRound(oPC);

    int nNth = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nNth, CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, CREATURE_TYPE_IS_ALIVE, TRUE);
    while (GetIsObjectValid(oCreature))
    {
        if (GetObjectSeen(oPC, oCreature))
        {
            AssignCommand(oCreature,  DetermineCombatRound(oPC));
        }
        nNth += 1;
        oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND, OBJECT_SELF, nNth, CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, CREATURE_TYPE_IS_ALIVE, TRUE);
    }
}
