//nPiracy is less than 5 - security vs Salvatori3 conversation being interrupted
int StartingConditional()
{
   if (GetLocalInt(GetPCSpeaker(),"nPiracy")<5)
    return TRUE;
    return FALSE;
}
