void main()
{
    SetLocalInt(GetModule(), "ddf_teleth_dead", TRUE);

    ExecuteScript("nw_c2_default7", OBJECT_SELF);
}
