// is the goblin kitchen's quest done?

int StartingConditional()
{
    object oMod = GetModule();
    return(GetLocalInt(oMod, "hevesar_plot") >= 5);
}
