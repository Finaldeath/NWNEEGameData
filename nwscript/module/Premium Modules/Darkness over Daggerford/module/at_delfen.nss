void main()
{
    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 400);

    // Give the speaker the items
    CreateItemOnObject("nw_it_mpotion012", GetPCSpeaker(), 1);
    CreateItemOnObject("nw_wmgwn013", GetPCSpeaker(), 1);
}
