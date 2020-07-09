void main()
{
    if(GetLocalInt(OBJECT_SELF, "iRewardBandits") == 0)
    {
        object oPC=GetPCSpeaker();
        //reward PC after intro battle
        FloatingTextStringOnCreature("Teygan is impressed by your actions.",oPC);
        GiveXPToCreature(oPC,1000);
        SetLocalInt(OBJECT_SELF, "iRewardBandits", 1);
    }
}
