// January 2006
// B W-Husey
// PC taken to caravan location on the road for guard duty.

void main()
{
    object oPC = GetPCSpeaker();
    string sName = "XP2"+GetTag(OBJECT_SELF);
    if (GetLocalInt(oPC,sName)==2) GiveGoldToCreature(oPC,5); //pay fee if necessary
    location lLoc = GetLocation(GetWaypointByTag("WP_PCPointRoad"));
    FadeToBlack(oPC);
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,JumpToLocation(lLoc));
}

