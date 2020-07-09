// to cross the moonsea, we force the player to use the ship
// this script just displays a helpful message about what happened
void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(oPC, "HF_MAP_ROUTE_BLOCKED") > 0)
        {
            DeleteLocalInt(oPC, "HF_MAP_ROUTE_BLOCKED");
            DelayCommand(0.5, AssignCommand(oPC, SpeakString("To complete your journey, you must cross the Moonsea.")));
        }
    }
}
