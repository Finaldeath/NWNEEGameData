void main()
{
    object oPC = GetPCSpeaker();
    object oDummy = GetObjectByTag("dla_strengthdummy");
    int nDamage = GetLocalInt(oPC, "nDummyDamage");
    SetLocalInt(oPC,"nDummyChamp",TRUE);
    GiveGoldToCreature(GetPCSpeaker(), 50);
    SetName(oDummy, GetName(oPC)+": "+IntToString(nDamage)+" damage");
}
