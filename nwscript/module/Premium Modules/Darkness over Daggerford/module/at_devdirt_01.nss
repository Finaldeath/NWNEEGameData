// player takes some dirt from the pile of sacks on the floor

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_it_dirtbag", oPC, 1);
    PlaySound("it_materialsoft");
}
