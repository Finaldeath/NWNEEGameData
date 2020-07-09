// julap vanishes in a puff of smoke, never to return.
// .. Minedi the dog must also leave.
// .. The portal exit must open.

void SpawnPortal(location lLoc, string sDir, string sDest)
{
    object oPortal = CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devportal", lLoc);
    SetLocalString(oPortal, sDir, sDest);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_AURA_PULSE_BLUE_WHITE), oPortal);
    object oSnd = GetNearestObjectByTag("MagicCrystalSourcestone", OBJECT_SELF);
    SoundObjectPlay(oSnd);
    PlaySound("sim_shwngodd1");
}

void main()
{
    object oPC = GetPCSpeaker();

    // update the player's journal
    AddJournalQuestEntry("j83", 6, oPC);
    if(GetLocalInt(GetModule(), "iRiddleXPGiven") == 0)
    {
        SetLocalInt(GetModule(),"iRiddleXPGiven", 1);
        GiveXPToCreature(oPC, 1000);
    }

    // portal exit opens
    object oWP = GetWaypointByTag("WP_AR1107_PORTAL2");
    SpawnPortal(GetLocation(oWP), "DESTINATION_UP", "WP_AR1108_PORTAL_EXIT");

    // julap and minedi vanish
    effect eVfx = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(OBJECT_SELF));
    DestroyObject(OBJECT_SELF);
    object oMinedi = GetNearestObjectByTag("ks_minedi", oPC);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oMinedi));
    DestroyObject(oMinedi);
}
