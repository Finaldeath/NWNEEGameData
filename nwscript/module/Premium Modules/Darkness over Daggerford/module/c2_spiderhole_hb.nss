// spiders move between holes in illefarn

void SpawnSpider(object oDest, object oArea)
{
    if (GetLocalInt(oArea, "nLittleSpidersAttacked") == 0)
    {
        object oStart = GetNearestObjectByTag("ks_ar2501d_tunnel2_DST", oDest);
        object oSpider = CreateObject(OBJECT_TYPE_CREATURE, "ks_small_spider", GetLocation(oStart));
        ChangeToStandardFaction(oSpider, STANDARD_FACTION_COMMONER);
        AssignCommand(oSpider, ActionMoveToObject(oDest, TRUE, 1.0));
    }
}

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    object oPC = GetFirstPC();
    if (GetArea(oPC) == oArea)
    {
        SpawnSpider(oSelf, oArea);
        DelayCommand(3.0, SpawnSpider(oSelf, oArea));
    }
}
