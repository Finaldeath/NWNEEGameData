#include "NW_I0_GENERIC"

void main()
{
    if(GetAppearanceType(OBJECT_SELF) != APPEARANCE_TYPE_SLAAD_GRAY)
    {
        object oPC = GetFirstPC();
        effect eP = EffectVisualEffect(VFX_IMP_POLYMORPH);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eP, OBJECT_SELF);
        ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
        DelayCommand(1.0, SetCreatureAppearanceType(OBJECT_SELF, APPEARANCE_TYPE_SLAAD_GRAY));
        DelayCommand(1.1, SetPortraitId(OBJECT_SELF, 720));
        DelayCommand(1.2, DetermineCombatRound(oPC));
        return;
    }

    //--------------------------------------------------------------------------
    // GZ: 2003-10-16
    // Make Plot Creatures Ignore Attacks
    //--------------------------------------------------------------------------
    if (GetPlotFlag(OBJECT_SELF))
    {
        return;
    }

    //--------------------------------------------------------------------------
    // Execute old NWN default AI code
    //--------------------------------------------------------------------------

    ExecuteScript("nw_c2_default5", OBJECT_SELF);
}
