#include "hf_in_henchman"

void main()
{
    if (!HenchmanIsPassive(OBJECT_SELF))
    {
        ExecuteScript("nw_ch_ac2", OBJECT_SELF);
    }
}

