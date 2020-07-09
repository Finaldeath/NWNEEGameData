// has the player met jonas sr before?

int StartingConditional()
{
    object oJonas1 = GetObjectByTag("ac_jonas1");
    return(GetLocalInt(oJonas1, "has_met_pc") > 0);
}
