// dla_trigtreasure
// May 2006
// B W-Husey
// If the creature does not have the treasure map when entering this trigger, the stones are deacitvatd so they can't be opened.

void main()
{
    object oPC = GetEnteringObject();
    object oRock = GetNearestObjectByTag("TreasureStone");
    if (GetLocalInt(oRock,"nOpen")<1)
    {
        if (GetItemPossessedBy(oPC,"TreasureMap") != OBJECT_INVALID)
        {
         //SetUseableFlag(oRock,TRUE); //  No such function   Deva Winblood 5/15/2006
         SetLocalInt(oRock,"nOpen",1);
        }
        else
        {
         // SetUseableFlag(oRock,FALSE); //  No such function   Deva Winblood 5/15/2006
        }
    }
}
