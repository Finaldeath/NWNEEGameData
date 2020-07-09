int StartingConditional()
{
    if (GetLocalInt(GetModule(), "drop_off_conv") ==1)
    return TRUE;
    return FALSE;
}
