// has the goblin kitchen's quest active (not solved)

int StartingConditional()
{
    object oMod = GetModule();
    return(GetLocalInt(oMod, "hevesar_plot") == 3);
}
