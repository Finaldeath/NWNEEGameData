#include "nw_i0_generic"

int FindOwner(string sTag, object oPlayer);

void RaiseAlarm(object oOwner, object oPC);

void main()
{
    object oPC = GetLastDisturbed();
    if (!GetIsObjectValid(oPC)) oPC = GetLastKiller();
    if (!GetIsObjectValid(oPC)) oPC = GetLastDamager();
    if (!GetIsObjectValid(oPC)) oPC = GetLastAttacker();
    if (!GetIsObjectValid(oPC)) oPC = GetLastSpellCaster();
    if (!GetIsObjectValid(oPC)) return;

    int nSuccess = FindOwner(GetLocalString(OBJECT_SELF, "sOwner"), oPC);
    if (nSuccess == 0)
    {
        nSuccess = FindOwner(GetLocalString(OBJECT_SELF, "sOwner2"), oPC);
    }
    if (nSuccess == 0)
    {
        nSuccess = FindOwner(GetLocalString(OBJECT_SELF, "sOwner3"), oPC);
    }
}

int FindOwner(string sTag, object oPlayer)
{
    int nNth = 0;
    object oOwner = GetNearestObjectByTag(sTag, OBJECT_SELF, nNth);

    while (GetIsObjectValid(oOwner) && (nNth < 3))
    {
        if ((!GetIsDead(oOwner)) && (GetObjectSeen(oPlayer, oOwner)))
        {
            RaiseAlarm(oOwner, oPlayer);
            return 1;
        }

        nNth += 1;
        oOwner = GetNearestObjectByTag(sTag, OBJECT_SELF, nNth);
    }

    return 0;
}

void RaiseAlarm(object oOwner, object oPC)
{
    string sShout = GetLocalString(OBJECT_SELF, "sShout");
    if (sShout != "")
    {
        AssignCommand(oOwner,  SpeakString(sShout));
    }

    SpeakString("HF_SHOUT_LOOT", TALKVOLUME_SILENT_SHOUT);
    DelayCommand(1.0, AssignCommand(oOwner, SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK)));

    AdjustReputation(oPC, oOwner, -100);
    AssignCommand(oOwner,  DetermineCombatRound(oPC));

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
