//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: cac_tm_grazkahn9
// DATE: November 20, 2005
// AUTH: Luke Scull
// NOTE: Make Grazkahn cast a few fake spells with
//       accompanying visual effects before destroying
//       the slaad.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// RB - Set to Busy and Plot while leaving to prevent dialog or attack
// AG - Remove Red and Blue Slaadi as well


const string NPC_TAG_SLAAD_BLUE = "tm_cr_art_slaadb";
const string NPC_TAG_SLAAD_RED  = "tm_cr_art_slaadr";


void SlaadTeleport(string sTag, object oNearest)
{
    int nNth = 1;
    object oSlaad = GetNearestObjectByTag(sTag, oNearest, nNth);
    while (GetIsObjectValid(oSlaad))
    {
        SetPlotFlag(oSlaad, FALSE);
        SetImmortal(oSlaad, FALSE);

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oSlaad));
        DestroyObject(oSlaad, 2.0);

        nNth++;
        oSlaad = GetNearestObjectByTag(sTag, oNearest, nNth);
    }
}


void main()
{
    object oPC = GetPCSpeaker();
    object oGrazkahn = OBJECT_SELF;

    SetLocalInt(oGrazkahn, "nBusy", 1);
    SetLocalInt(oGrazkahn, "HF_EXIT_STARTED", 1);
    SetPlotFlag(oGrazkahn, TRUE);

    ActionCastFakeSpellAtObject(SPELL_GATE, oGrazkahn);

    DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION), oGrazkahn));
    DelayCommand(3.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetFirstPC(), 13.0));

    ActionCastFakeSpellAtObject(SPELL_GATE, oGrazkahn);

    DelayCommand(9.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION), oGrazkahn));

    ActionCastFakeSpellAtObject(SPELL_GATE, oGrazkahn);

    DelayCommand(11.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oGrazkahn)));
    DestroyObject(oGrazkahn, 13.0);

    // Make the other Slaadi disappear too
    DelayCommand(12.0, SlaadTeleport(NPC_TAG_SLAAD_BLUE, oPC));
    DelayCommand(12.0, SlaadTeleport(NPC_TAG_SLAAD_RED, oPC));
}
