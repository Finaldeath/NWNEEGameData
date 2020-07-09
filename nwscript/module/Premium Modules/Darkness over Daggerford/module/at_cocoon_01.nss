// the player used a flask of acid to dissolve the cocoon

void main()
{
    // the player has consumed an acid flask
    object oPC = GetPCSpeaker();
    object oBottle = GetItemPossessedBy(oPC, "X1_WMGRENADE001");
    int n = GetNumStackedItems(oBottle);
    if ( n > 1)
    {
        SetItemStackSize(oBottle, n-1);
    }
    else
    {
        DestroyObject(oBottle);
    }

    // spawn the "bloated corpse" that was hidden inside the web
    location lLoc = GetLocation(OBJECT_SELF);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID), lLoc);
    CreateObject(OBJECT_TYPE_PLACEABLE, "ks_pl_acidbody", lLoc);
    DestroyObject(OBJECT_SELF);
}
