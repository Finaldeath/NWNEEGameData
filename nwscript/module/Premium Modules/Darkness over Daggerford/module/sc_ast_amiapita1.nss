int StartingConditional()
{
    if (GetLocalInt(GetModule(), "drop_off_conv") ==2 &&
    GetLocalInt(GetModule(), "amiapita1") !=1)
    return TRUE;
    return FALSE;
}
