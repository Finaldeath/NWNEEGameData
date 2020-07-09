//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ncv_tm_ignore
// DATE: October 16, 2018
// AUTH: Rich Barker
// NOTE: Ignore conversation attempts if nBusy int is set
//////////////////////////////////////////////////////

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nBusy") == 0)
    {
        ExecuteScript("nw_c2_default4", OBJECT_SELF);
    }
}
