void main()
{
    object oPC = OBJECT_SELF;
    object oShaft = GetNearestObjectByTag("pf_lightshaft");
    object oBurn;
    effect eBurn = EffectVisualEffect(498);
    effect eChunk = EffectVisualEffect(VFX_COM_CHUNK_BONE_MEDIUM);
    int i;
    for(i=1;i<=4;i++)
    {
        oBurn = GetObjectByTag("Vampire"+IntToString(i));
        if(GetDistanceBetween(oBurn,oShaft)<8.0)
        {
            SetLocalInt(oBurn,"bNoVampRespawn",TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBurn, oBurn, 3.0);
            DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eChunk, oBurn));
            DelayCommand(3.0, AssignCommand(oPC,ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oBurn)));
        }
    }
}
