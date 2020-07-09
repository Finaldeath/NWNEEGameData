void main()
{
    object oPC=GetPCSpeaker();
    string sReward=("db_cape_xanda");
    CreateItemOnObject(sReward,oPC,1);
    GiveXPToCreature(oPC,250);
    FloatingTextStringOnCreature("Rewarded by Xanda",oPC);
}
