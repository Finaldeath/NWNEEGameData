void main()
{
    object oPC = GetPCSpeaker();
    CreateItemOnObject("ks_fzoul_note", oPC, 1);
    SetLocalInt(GetModule(), "astriel_fzoulnote", 1);
    DestroyObject(OBJECT_SELF);
}
