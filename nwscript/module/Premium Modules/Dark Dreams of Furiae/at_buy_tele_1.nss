void main()
{
    TakeGoldFromCreature(4, GetPCSpeaker());
    SetLocalInt(GetModule(), "ddf_tele_purchase", TRUE);
    CreateItemOnObject("worldwinepotion", GetPCSpeaker(), 1);
}
