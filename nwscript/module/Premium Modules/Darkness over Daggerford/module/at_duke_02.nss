void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_dagger_medal", oPC, 1);
    PlaySound("it_gem");
}
