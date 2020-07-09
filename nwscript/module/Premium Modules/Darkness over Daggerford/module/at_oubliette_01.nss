// player tosses a rope down to feynemonee and she crawls out of the oubliette

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetWaypointByTag("WP_AR0901_FEYNEMONEE");
    object oFey = CreateObject(OBJECT_TYPE_CREATURE, "ks_feynemonee", GetLocation(oWP));
    SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPC);
    SetLocalString(oFey, "HF_EXIT_NAME", "WP_AR0901_FEYNEMONEE_EXIT");
    SetLocalInt(oFey, "HF_EXIT_RUN", 1);
    int nDmg = GetCurrentHitPoints(oFey)/2;
    AssignCommand(oFey, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nDmg), oFey));
    PlotLevelSet("ks_oubliette_pl", 3);
    DelayCommand(1.0, AssignCommand(oFey, ActionStartConversation(oPC)));
}
