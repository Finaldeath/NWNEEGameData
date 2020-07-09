void main()
{
    object oPC = GetPCSpeaker();
    object oStore = GetObjectByTag("kresh_merchant");

    OpenStore(oStore, oPC);
}
