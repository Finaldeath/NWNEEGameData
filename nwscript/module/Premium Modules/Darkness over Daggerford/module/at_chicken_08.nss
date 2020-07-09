// the player picks up the chicken

void main()
{
    object oPC = GetPCSpeaker();
    object oChicken = CreateItemOnObject("a2_chicken", oPC, 1);
    if (GetIsObjectValid(oChicken))
    {
        DestroyObject(OBJECT_SELF);
    }
}
