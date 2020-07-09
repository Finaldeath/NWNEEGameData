// the player dispels the armoire illusion in AR1108
// .. reveal the secret door.

void main()
{
    object oPC = GetPCSpeaker();

    // player casts dispel magic
    ActionPauseConversation();
    AssignCommand(oPC, ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, OBJECT_SELF));
    ActionResumeConversation();

    // create the secret door
    location lLoc = GetLocation(OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DISPEL), lLoc);
    object oWP = GetNearestObjectByTag("WP_AR1108_SECRET_DOOR", oPC);
    CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_devsecdr1", GetLocation(oWP), FALSE, "pl_devsecdr1");

    // give some XP
    FloatingTextStringOnCreature("... XP gain ...", oPC);
    GiveXPToCreature(oPC, 50);

    // destroy the armoire
    DestroyObject(OBJECT_SELF);

}
