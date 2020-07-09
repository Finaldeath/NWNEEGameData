void main()
{
    TakeGoldFromCreature(3, GetPCSpeaker());
    SetLocalInt(GetModule(), "ddf_trin_purchase", TRUE);
    CreateItemOnObject("worldwinepotion", GetPCSpeaker(), 1);
}
