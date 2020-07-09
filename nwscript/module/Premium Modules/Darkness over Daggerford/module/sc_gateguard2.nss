int StartingConditional()
{
    if((GetLocalInt(GetPCSpeaker(), "pm_guardtalked1") == 0) &&
      (GetLocalInt(GetModule(), "pm_Daggerford_open") == 1))
        return TRUE;

    return FALSE;
}
