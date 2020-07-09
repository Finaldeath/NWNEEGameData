// aladara is dead

int StartingConditional()
{
    if(GetLocalInt(GetModule(), "ddf_aladara_dead") == TRUE) return TRUE;

    return FALSE;
}
