//Remove Grimswold from stocks and kill Bennart and Lashan
void main()
{
    effect eDeath = EffectDeath();

    DestroyObject(GetObjectByTag("GrimswoldStocks"));
    CreateObject(OBJECT_TYPE_CREATURE, "bennartdead",
                 GetLocation(GetWaypointByTag("POST_GrimswoldStocks")));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetObjectByTag("LashanStocks"));
    SetLocalInt(GetObjectByTag("StocksTrigger"), "nLashanDead", 1);

    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
