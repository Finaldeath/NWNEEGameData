// tavis gives the player a room key and takes 6 gold

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("breakwaterinnkey", oPC);
    TakeGoldFromCreature(6, oPC);
}
