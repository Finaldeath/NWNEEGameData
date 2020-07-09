void main()
{
    object oPC=GetPCSpeaker();
    GiveGoldToCreature(oPC,200);
    AdjustAlignment(oPC,ALIGNMENT_EVIL,2);
}
