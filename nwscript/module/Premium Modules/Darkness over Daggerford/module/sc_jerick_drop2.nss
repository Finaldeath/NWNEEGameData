int StartingConditional()
{
    if (GetLocalInt(GetModule(), "drop_off_conv") ==2)
    return TRUE;
    return FALSE;
}
