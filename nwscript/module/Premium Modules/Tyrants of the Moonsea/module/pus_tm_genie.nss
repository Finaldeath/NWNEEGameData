// secret: spawn the genie from the bottle and talk to player

void main()
{
    object oPC = GetPCSpeaker();
    object oWP = GetWaypointByTag("WP_ME_SECRET_GENIE");
    object oGenie = CreateObject(OBJECT_TYPE_CREATURE, "nobledjinni", GetLocation(oWP));
    effect eVfx = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVfx, GetLocation(oGenie));
    AssignCommand(oGenie, ActionStartConversation(oPC));
    DestroyObject(OBJECT_SELF);
}
