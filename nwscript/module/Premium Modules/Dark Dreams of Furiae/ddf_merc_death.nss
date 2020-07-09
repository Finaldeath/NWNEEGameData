void main()
{
    SetLocalInt(GetModule(), "ddf_sti_mercenary_dead", TRUE);
    ExecuteScript("x2_def_ondeath", OBJECT_SELF);
}
