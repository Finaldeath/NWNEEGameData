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

    FindOwner(GetLocalString(OBJECT_SELF, "sOwner"), oPC);
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

    ChangeToStandardFaction(oOwner, STANDARD_FACTION_HOSTILE);

    object oMethim = GetNearestObjectByTag("bw_methim", oOwner);
    ChangeToStandardFaction(oMethim, STANDARD_FACTION_HOSTILE);

    AssignCommand(oOwner,  DetermineCombatRound(oPC));
    AssignCommand(oMethim,  DetermineCombatRound(oPC));
}
