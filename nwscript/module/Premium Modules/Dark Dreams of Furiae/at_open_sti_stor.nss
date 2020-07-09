void main()
{
    object oStore = GetObjectByTag("DDF_STI_STORE");

    OpenStore(oStore, GetPCSpeaker());
    ExecuteScript("at_soulinn_attck", OBJECT_SELF);
}
