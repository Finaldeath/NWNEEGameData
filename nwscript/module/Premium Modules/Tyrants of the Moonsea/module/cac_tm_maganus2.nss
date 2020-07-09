//Maganus attacks the player in Kur-Tharsu

#include "nw_i0_generic"

#include "inc_ktgate"

//Create a summoned Balor
void CreateMaganusBalor()
{
    location lBalor = GetLocation(GetWaypointByTag("WP_THKTUF_BALOR_SPAWN"));

    CreateObject(OBJECT_TYPE_CREATURE, "nw_balorboss", lBalor, FALSE, "MaganusBalor");
}

void main()
{
    object oMaganus = OBJECT_SELF;
    object oPC = GetPCSpeaker();

    location lBalor = GetLocation(GetWaypointByTag("WP_THKTUF_BALOR_SPAWN"));

    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lBalor);

    SetPlotFlag(oMaganus, FALSE);
    ChangeToStandardFaction(oMaganus, STANDARD_FACTION_HOSTILE);
    TalentAdvancedBuff(40.0);
    MusicBattleChange(GetArea(OBJECT_SELF), 116);
    DelayCommand(1.0, AssignCommand(oMaganus, DetermineCombatRound(oPC)));
    DelayCommand(1.5, CreateMaganusBalor());

    //Signal to any Shadovar Assassins that cutscene has ended and they can attack
    SignalAssassinEvent(4701);
}
