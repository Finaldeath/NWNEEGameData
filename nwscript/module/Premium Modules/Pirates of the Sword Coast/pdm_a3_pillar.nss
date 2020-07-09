location GetClosestSpwnToPillar(object oPillar);
void DamageLocation(location lMonster);

void main()
{
    location lTarg = GetClosestSpwnToPillar(OBJECT_SELF);
    //effect eVFX1 = EffectVisualEffect(353); //VFX_COM_CHUNK_STONE_SMALL
    //effect eVFX2 = EffectVisualEffect(354); //VFX_COM_CHUNK_STONE_MEDIUM
    effect eVFX3 = EffectVisualEffect(356); //VFX_FNF_SCREEN_SHAKE2

    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX1, lTarg);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX2, lTarg);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVFX3, lTarg);

    DelayCommand(1.0f, DamageLocation(lTarg));
}

location GetClosestSpwnToPillar(object oPillar)
{
    object oWPA = GetWaypointByTag("WP_BEASTSPWN_A");
    object oWPB = GetWaypointByTag("WP_BEASTSPWN_B");
    object oWPC = GetWaypointByTag("WP_BEASTSPWN_C");
    object oWPD = GetWaypointByTag("WP_BEASTSPWN_D");

    float fDistA = GetDistanceBetween(oPillar, oWPA);
    float fDistB = GetDistanceBetween(oPillar, oWPB);
    float fDistC = GetDistanceBetween(oPillar, oWPC);
    float fDistD = GetDistanceBetween(oPillar, oWPD);

    location lReturn = GetLocation(oWPA);

    if ((fDistA < fDistB) && (fDistA < fDistC) && (fDistA < fDistD))
    {
        lReturn = GetLocation(oWPA);
    }
    else if ((fDistB < fDistA) && (fDistB < fDistC) && (fDistB < fDistD))
    {
        lReturn = GetLocation(oWPB);
    }
    else if ((fDistC < fDistA) && (fDistC < fDistB) && (fDistC < fDistD))
    {
        lReturn = GetLocation(oWPC);
    }
    else if ((fDistD < fDistA) && (fDistD < fDistB) && (fDistD < fDistC))
    {
        lReturn = GetLocation(oWPD);
    }

    return lReturn;
}

void DamageLocation(location lMonster)
{
    effect eDamage = EffectDamage(d8(3)+5, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_PLUS_FIVE);
    object oCursor = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE,
        lMonster, FALSE, OBJECT_TYPE_ALL);

    while (GetIsObjectValid(oCursor) == TRUE)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oCursor);
        oCursor = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE,
            lMonster, FALSE, OBJECT_TYPE_ALL);
    }
}
