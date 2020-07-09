void main()
{
    object oPC = GetPCSpeaker();

    DelayCommand(0.01, OpenInventory(OBJECT_SELF, oPC));
}
