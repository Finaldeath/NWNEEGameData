int StartingConditional()
{
    //simple check to see if the player has met hevesar
    if(GetLocalInt(GetModule(), "hevesar_met")== 1 &&
      GetLocalInt(GetModule(), "iMetHevesarLH") == 0)
    return TRUE;
    return FALSE;
}
