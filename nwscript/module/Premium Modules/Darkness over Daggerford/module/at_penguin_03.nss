// the player picks up the penguin

void main()
{
    object oPC = GetPCSpeaker();
    object oPenguin = CreateItemOnObject("a2_penguin", oPC, 1);
    if (GetIsObjectValid(oPenguin))
    {
        DestroyObject(OBJECT_SELF);
    }
}

