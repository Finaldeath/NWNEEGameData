//////////////////////////////////////////////////////////////////
// dla_ct_nofunds - PC does not have 10 Gold Lions?
// Original Scripter: Deva B. Winblood
// Last Modified By:  Gale 16/7/2006
/////////////////////////////////////////////////////////////////

int StartingConditional()
{
    return (GetGold(GetPCSpeaker())<10);
}