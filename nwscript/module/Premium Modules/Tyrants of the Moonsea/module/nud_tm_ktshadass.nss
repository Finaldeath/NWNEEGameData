//User-defined script for Shadovar Assassins in Kur-Tharsu

#include "nw_i0_generic"
#include "nw_i0_spells"

#include "hf_in_plot"
#include "hf_in_cutscene"

void main()
{
    string sWP = "";

    effect eInvis;

    switch(GetUserDefinedEventNumber())
    {
        //Initial Maganus cutscene starts
        case 4700 :
            sWP = GetLocalString(OBJECT_SELF, "sHome");

            ClearAllActions(TRUE);
            PlotLevelSet(GetTag(OBJECT_SELF), 2);
            //Jump near to entrance to Maganus chamber
            JumpToLocation(GetLocation(GetWaypointByTag(sWP)));
        break;
         //Initial Maganus cutscene ends, assassins stealth and set to attack
        case 4701 :
            ClearAllActions(TRUE);
            SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
            SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
            eInvis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis,
                                OBJECT_SELF, RoundsToSeconds(2));
            PlotLevelSet(GetTag(OBJECT_SELF), 3);
        break;
        //Maganus reduced to 1 hit point, make visible and move to home position
        case 4702 :
            sWP = GetLocalString(OBJECT_SELF, "sHome");

            ClearAllActions(TRUE);
            PlotLevelSet(GetTag(OBJECT_SELF), 4);

            //Remove any lingering spell visual effects
            CutsceneRemoveNegativeEffects(OBJECT_SELF);
            RemoveSpecificEffect(EFFECT_TYPE_VISUALEFFECT, OBJECT_SELF);
            SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 50, GetFirstPC());

            SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
            JumpToLocation(GetLocation(GetWaypointByTag(sWP)));
            SetFacing(GetFacingFromLocation(GetLocation(GetWaypointByTag(sWP))));
        break;
        //Signal assassins to attack PC following dialog about fake Dominion
        case 4703 :
            ClearAllActions(TRUE);
            PlotLevelSet(GetTag(OBJECT_SELF), 7);
            ChangeToStandardFaction(OBJECT_SELF, STANDARD_FACTION_HOSTILE);
            DetermineCombatRound(GetFirstPC());
        break;
        //Go to 'home' location if PC leaves area
        case 4710 :
            sWP = GetLocalString(OBJECT_SELF, "sHome");

            ClearAllActions(TRUE);
            JumpToLocation(GetLocation(GetWaypointByTag(sWP)));
        break;
    }
}
