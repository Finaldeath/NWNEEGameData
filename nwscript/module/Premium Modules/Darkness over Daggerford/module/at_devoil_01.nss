// player picks-up elwinster's oil bottle

void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_it_devoil", oPC, 1);
    DestroyObject(OBJECT_SELF);
}
