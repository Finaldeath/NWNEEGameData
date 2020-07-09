// mephit death script
// .. sends event to generator to spawn another one

void DeleteInventory(object o)
{
    object oItem = GetFirstItemInInventory(o);
    while (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(o);
    }
    TakeGoldFromCreature(GetGold(OBJECT_SELF), OBJECT_SELF, TRUE);
}

void main()
{
    DeleteInventory(OBJECT_SELF);
    if (GetTag(OBJECT_SELF) == "ks_mephit_ice")
    {
        // ice mephit
        object oGenerator = GetNearestObjectByTag("ks_pl_devgenerator", OBJECT_SELF);
        SignalEvent(oGenerator, EventUserDefined(1));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FROST_L), OBJECT_SELF);
    }
    else
    {
        // fire mephit
        object oGenerator = GetNearestObjectByTag("ks_pl_devflame", OBJECT_SELF);
        SignalEvent(oGenerator, EventUserDefined(1));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_FLAME_M), OBJECT_SELF);
    }
}
