// Handles Quill's payment

void main()
{
    SetLocalInt(GetModule(), "ddf_quill_paid", TRUE);

    // Give some random potion
    object oPC = GetPCSpeaker();
    CreateItemOnObject("nw_it_mpotion020", oPC);
}
