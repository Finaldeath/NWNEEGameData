//////////////////////////////////////////////////////////////////
// dla_ct_victory -  You have won the archery contest
// Original Scripter: Deva B. Winblood
// Last Modified By:  Gale   16/7/2006
//////////////////////////////////////////////////////////////////

int StartingConditional()
{
    // victory
    return GetLocalInt(GetPCSpeaker(),"bArcheryOver")==1;
}
