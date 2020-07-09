// player collects some quicksilver from the fountain in AR1108

void main()
{
    object oPC = GetPCSpeaker();
    PlaySound("it_potion");
    CreateItemOnObject("ks_it_quicksilve", oPC, 1);
}
