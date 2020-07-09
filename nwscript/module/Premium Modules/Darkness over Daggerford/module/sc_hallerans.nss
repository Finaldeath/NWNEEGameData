int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "hallerans_ool") == 0)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
