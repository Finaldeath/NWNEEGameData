//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ncv_tm_maganus
// DATE: October 16, 2018
// AUTH: Rich Barker
// NOTE: Stop background music when Maganus conversed with
//////////////////////////////////////////////////////

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nBusy") == 0)
    {
        MusicBackgroundStop(GetArea(OBJECT_SELF));
        ExecuteScript("nw_c2_default4", OBJECT_SELF);
    }
}
