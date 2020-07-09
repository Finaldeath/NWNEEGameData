// player opens the "Chest of the Wise"

void main()
{
    object oPC = GetPCSpeaker();
    object oItem = GetFirstItemInInventory();
    if (GetIsObjectValid(oItem))
    {
        SetCustomToken(100, GetName(oItem));
        SetLocalInt(OBJECT_SELF, "HF_ARG", 0);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "HF_ARG", 1);
    }
}
