void main()
{
    object oPC = GetPCSpeaker();
    //give the pie recipe and a token amount of xp
    CreateItemOnObject("db_pie", oPC, 1);
    if(GetLocalInt(oPC, "pie") !=1)
    {
        GiveXPToCreature(oPC, 50);
        SetLocalInt(oPC, "pie", 1);
    }
    FloatingTextStringOnCreature("Kitchen ninja skills improved", oPC);
}
