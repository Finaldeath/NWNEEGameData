// (if Aladara is alive and if you have not chosen this option before

int StartingConditional()
{
     if(GetLocalInt(GetModule(), "ddf_aladara_dead") == TRUE) return FALSE;

     if(GetLocalInt(GetModule(), "ddf_teddy_aladara_lie_01") == TRUE) return FALSE;

     //SetLocalInt(GetModule(), "ddf_teddy_aladara_lie_01", TRUE);

     return TRUE;
}
