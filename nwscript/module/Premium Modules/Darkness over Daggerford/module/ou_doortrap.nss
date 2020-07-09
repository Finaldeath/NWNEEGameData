void main()
{
    object oPC=GetClickingObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "iTriggered") == 0)
    {
        object oSource=GetObjectByTag("electric_zapper");
        object oTarget=GetObjectByTag("zap_receiver");
        effect eZap=EffectBeam(VFX_BEAM_LIGHTNING,oSource,BODY_NODE_CHEST);
        effect eHarm=EffectDamage(d20(1),DAMAGE_TYPE_ELECTRICAL);

        SetLocalInt(OBJECT_SELF, "iTriggered", 1);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eZap,oTarget,1.5f);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eHarm,oPC);
        CreateObject(OBJECT_TYPE_CREATURE, "nw_spiddire",
                     GetLocation(GetWaypointByTag("WP_CLIFFS_SPIDER")));
        SetLocked(OBJECT_SELF, FALSE);
    }
}
