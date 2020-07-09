// secret: genie gives XP to player

void main()
{
    object oPC = GetPCSpeaker();
    GiveXPToCreature(oPC, 1000);
}
