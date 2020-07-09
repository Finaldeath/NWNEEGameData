// dla_trigtreasure
// May 2006
// B W-Husey
// If the creature does have the treasure map when entering this area, the stones are created.
// (see dla_trigtreasure if the SetUseableFlag function is included in next patch)

void main()
{
    object oPC = GetEnteringObject();
    object oArea = OBJECT_SELF;
    location lLoc = GetLocation(GetWaypointByTag("WP_TreasurePoint"));
    if (GetLocalInt(oArea,"nOpen")<1)
    {
        if (GetIsObjectValid(GetItemPossessedBy(oPC,"TreasureMap")))
        {
         CreateObject(OBJECT_TYPE_PLACEABLE,"wcboulder001",lLoc,FALSE);
         SetLocalInt(oArea,"nOpen",1);
        }
   }
}
