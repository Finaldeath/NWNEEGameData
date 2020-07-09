// secret: genie gives player gold

void main()
{
    object oPC = GetPCSpeaker();
    GiveGoldToCreature(oPC, 5000);
}
