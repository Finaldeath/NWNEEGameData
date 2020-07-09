void main()
{
    TakeGoldFromCreature(10, GetPCSpeaker());
    SetLocalInt(GetModule(), "ddf_trin_purchase", TRUE);
    CreateItemOnObject("worldwinepotion", GetPCSpeaker(), 3);
}
