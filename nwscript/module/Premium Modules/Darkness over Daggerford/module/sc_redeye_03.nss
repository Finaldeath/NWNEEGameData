// returns true if thuraskulusk is dead

int StartingConditional()
{
    object oModule = GetModule();
    return(GetLocalInt(oModule, "nTuraskuluskDead") != 0);
}
