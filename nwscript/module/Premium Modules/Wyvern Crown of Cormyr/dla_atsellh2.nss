////////////////////////////////////////////////////////////////////////////////
// dla_atsellh2 - Blinking highlight on horse
// Scripted By: Deva B. Winblood.  08/03/2006
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oWangle=OBJECT_SELF;
    object oHorse=GetLocalObject(oWangle,"oInterested");
    effect eBlink=EffectVisualEffect(VFX_DUR_AURA_PULSE_RED_WHITE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBlink,oHorse,3.0);
}
