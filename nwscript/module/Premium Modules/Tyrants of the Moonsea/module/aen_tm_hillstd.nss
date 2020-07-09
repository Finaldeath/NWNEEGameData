//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: aen_tm_hillstd
// DATE: 14 October, 2018
// AUTH: Luke Scull
// NOTE: Autosaves and applies effects to Dreadspire door
//       the first time player enters area.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
void main()
{
    object oPC = GetEnteringObject();
    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") != 1)
    {
        object oDoor = GetObjectByTag("TempleDistrict_To_TheDreadspire");

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR), oDoor);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_DARKNESS), oDoor);
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
        DoSinglePlayerAutoSave();
    }
}
