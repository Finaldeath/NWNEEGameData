#include "NW_I0_GENERIC"

void DePlotFaction(object oMaster)
{
    object o = GetFirstFactionMember(oMaster, FALSE);
    while (GetIsObjectValid(o))
    {
        SetPlotFlag(o, FALSE);
        SetImmortal(o, FALSE);
        o = GetNextFactionMember(oMaster, FALSE);
    }
}

void Attack(object oMaster, object oPC)
{
    object o = GetFirstFactionMember(oMaster, FALSE);
    while (GetIsObjectValid(o))
    {
        if (GetArea(o) == GetArea(oPC))
        {
            if (GetObjectSeen(oPC, o))
            {
                AssignCommand(o, ClearAllActions());
                AssignCommand(o, ActionAttack(oPC));
                AssignCommand(o, DetermineCombatRound(oPC));
            } else {
                AssignCommand(o, ClearAllActions());
                AssignCommand(o, ActionAttack(oPC));
            }
        }
        o = GetNextFactionMember(oMaster, FALSE);
    }
}

// note that the shout will only work if you enable the spawn in condition
void main()
{
    object oPC = GetPCSpeaker();
    DePlotFaction(OBJECT_SELF);
    AdjustReputation(oPC, OBJECT_SELF, -100);
    Attack(OBJECT_SELF, oPC);
    DetermineCombatRound(oPC);
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
}
