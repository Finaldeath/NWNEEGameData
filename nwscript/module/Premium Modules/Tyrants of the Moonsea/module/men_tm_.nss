// client enter event is called whenever a player enters the game

void main()
{
    object oPC = GetEnteringObject();

    // if the player was polymorphed to a human, adjust the appearance
    int nWasPoly = GetLocalInt(oPC, "HF_POLY_CREATURE_TYPE");
    if (nWasPoly > 0)
    {
         DelayCommand(1.0f, SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_HUMAN));
    }

    SetMaxHenchmen(4);
    ExecuteScript("x3_mod_def_enter", OBJECT_SELF);
}
