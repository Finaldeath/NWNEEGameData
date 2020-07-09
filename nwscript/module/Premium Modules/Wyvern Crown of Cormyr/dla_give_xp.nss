void main()
{
    //this script is used to grant experience
    object oPC = GetLastUsedBy();

    GiveXPToCreature(oPC, 1000);
}
