// dla_atmanderpay
// B W-Husey
// Pay mander for the treasure map the required amount.

void main()
{
    object oPC = GetPCSpeaker();
    int nCost = GetLocalInt(oPC,"nTMapCost");
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,3.0);
    TakeGoldFromCreature(nCost, oPC);
    CreateItemOnObject("TreasureMap",oPC);
}
