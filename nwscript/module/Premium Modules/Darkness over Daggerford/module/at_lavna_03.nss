// lavna gives the player a charm

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_it_charm1", oPC, 1);
}
