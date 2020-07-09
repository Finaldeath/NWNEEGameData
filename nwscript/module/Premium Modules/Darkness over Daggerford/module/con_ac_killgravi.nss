#include "NW_I0_GENERIC"

void main()
{
    object oGravia = OBJECT_SELF;
    object oPC = GetPCSpeaker();

    effect eP = EffectVisualEffect(VFX_IMP_POLYMORPH);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eP, oGravia);
    DelayCommand(1.0, SetCreatureAppearanceType(oGravia, APPEARANCE_TYPE_WEREWOLF));
    DelayCommand(1.0, ChangeToStandardFaction(oGravia, STANDARD_FACTION_HOSTILE));
    DelayCommand(1.5, AssignCommand(oGravia, DetermineCombatRound(oPC)));
}
