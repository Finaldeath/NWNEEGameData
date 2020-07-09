void main()
{
    object oPC = GetPCSpeaker();
    //give the ice cream recipe and a token amount of xp
    CreateItemOnObject("db_icecream", oPC, 1);
    if(GetLocalInt(oPC, "icecream") !=1)
    {
        GiveXPToCreature(oPC, 50);
        SetLocalInt(oPC, "icecream", 1);
    }
    FloatingTextStringOnCreature("Kitchen ninja skills improved", oPC);
}
