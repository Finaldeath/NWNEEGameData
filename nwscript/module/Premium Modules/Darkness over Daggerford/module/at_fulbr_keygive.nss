// fulbar hardcheese in the happy cow sells a key to the player

void main()
{
    object oPC = GetPCSpeaker();
    TakeGoldFromCreature(4, oPC, TRUE);
    CreateItemOnObject("pm_happycowkey", oPC, 1);
    SetLocalInt(OBJECT_SELF, "do_once", 1);
}
