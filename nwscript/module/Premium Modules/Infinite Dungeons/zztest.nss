void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(OBJECT_SELF, "bFollower", TRUE);

    AddHenchman(oPC);
}
