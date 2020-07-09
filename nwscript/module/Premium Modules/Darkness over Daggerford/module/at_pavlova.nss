void main()
{
    object oPC = GetPCSpeaker();
    //give the pavlova recipe and a token amount of xp
    CreateItemOnObject("db_pavlova", oPC, 1);
    if(GetLocalInt(oPC, "pavlova") !=1)
    {
        GiveXPToCreature(oPC, 50);
        SetLocalInt(oPC, "pavlova", 1);
    }
    FloatingTextStringOnCreature("Kitchen ninja skills improved", oPC);
}
