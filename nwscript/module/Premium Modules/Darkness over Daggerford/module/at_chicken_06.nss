// the butcher takes 25 gold coins from the player as payment
// ... for the tasty chicken

void main()
{
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(25, oPC);
}
