//Area OnEnter for Voonlar Catacombs

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        //Apply Red Glow effect to door Shrazgul's Lair
        object oDoor = GetObjectByTag("OldCatacombs_To_ShrazgulsLair");
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_GLOW_RED), oDoor);
        SetLocalInt(OBJECT_SELF, "nEntered", 1);
    }
}
