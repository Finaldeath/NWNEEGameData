void main()
{
    object oPC = GetPCSpeaker();
    int nToll  = GetLocalInt(oPC, "nWH_TollPrice");
    TakeGoldFromCreature(nToll, oPC);
    SetLocalInt(oPC, "nWH_PaidToll", 1);   // paid toll
    SetLocalInt(oPC, "nWH_CrossedOnce", 1);   // paid toll once
}
