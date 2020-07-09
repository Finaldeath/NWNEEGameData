//sc_frederic_1
//check to see whether player accepted frederic's spy mission
//Author: Anya Clancy
//Date: Oct. 9, 2005
int StartingConditional()
{
    if (GetLocalInt(GetModule(), "frederic") !=1) return FALSE;
    return TRUE;
}
