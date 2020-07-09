// aladara is alive

int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_aladara_dead") == TRUE) return FALSE;

    return TRUE;
}
