// player has aborted stegil's convo;
// .. this makes him mad if a deal hasn't been arranged

#include "hf_in_plot"
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
    // go hostile towards the player
    DePlotFaction(oMaster);
    AdjustReputation(oPC, oMaster, -100);

    // all nearby buddies attack player
    object o = GetFirstFactionMember(oMaster, FALSE);
    while (GetIsObjectValid(o))
    {
        if (GetArea(o) == GetArea(oPC))
        {
            if (GetObjectSeen(oPC, o))
            {
                AssignCommand(o, ClearAllActions());
                AssignCommand(o, DetermineCombatRound(oPC));
            } else {
                AssignCommand(o, ClearAllActions());
                AssignCommand(o, ActionAttack(oPC));
            }
        }
        o = GetNextFactionMember(oMaster, FALSE);
    }
}

void main()
{
    if (PlotLevelGet("ks_stegil") == 0)
    {
        object oPC = GetPCSpeaker();
        object oSelf = OBJECT_SELF;
        SpeakString("No one walks away from me! Die!");
        DelayCommand(2.0, Attack(oSelf, oPC));
    }
}
