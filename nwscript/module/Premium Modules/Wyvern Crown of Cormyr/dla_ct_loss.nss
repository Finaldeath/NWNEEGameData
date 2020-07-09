//////////////////////////////////////////////////////////////////
// dla_ct_loss - You have lost the archery contest
// Original Scripter: Deva B. Winblood
// Last Modified By:  Deva B. WInblood   5/3/2006
/////////////////////////////////////////////////////////////////

int StartingConditional()
{
    if (GetLocalInt(GetPCSpeaker(),"bArcheryOver")==2)
    { // loss
      DeleteLocalInt(GetPCSpeaker(),"bArcheryOver");
      return TRUE;
    } // loss
    return FALSE;
}
