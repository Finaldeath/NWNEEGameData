#include "x0_i0_position"

void main()
{
    object oPC = GetPCSpeaker();

    if (!GetLocalInt(GetModule(), "falias_in_the_bush"))
    {
        // spawn falias
        SetLocalInt(GetModule(), "falias_in_the_bush", 1);
        location lFalias = GetStepLeftLocation(oPC);
        object oFalias = CreateObject(OBJECT_TYPE_CREATURE, "db_falias3", lFalias);
        AssignCommand(oFalias, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oFalias, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));

        // heal some guards
        int i = 1;
        object oGuard = GetNearestObjectByTag("_hurtguard", oPC, i);
        while (GetIsObjectValid(oGuard))
        {
            AssignCommand(oGuard, SetCommandable(TRUE));
            DelayCommand(0.5, AssignCommand(oGuard, ClearAllActions()));
            DelayCommand(0.6, AssignCommand(oGuard, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 12.0)));
            DelayCommand(0.7, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oGuard, 12.0));
            ChangeToStandardFaction(oGuard, STANDARD_FACTION_DEFENDER);
            SetPlotFlag(oGuard, FALSE);
            oGuard = GetNearestObjectByTag("_hurtguard", oPC, ++i);
        }
    }
}
