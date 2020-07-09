// the player has killed the dragon thuraskulusk
// .. flag a variable so that the player can tell redeye the dragon is dead

void main()
{
    object oModule = GetModule();
    SetLocalInt(oModule, "nTuraskuluskDead", 1);
    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
