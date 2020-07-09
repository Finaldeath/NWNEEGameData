void main()
{
    object oPC=GetPCSpeaker();
    //reward PC after intro battle
    FloatingTextStringOnCreature("Falias rewards you for saving his caravan.",oPC);
    GiveGoldToCreature(oPC,100);
    GiveXPToCreature(oPC,500);
}
