#include "hf_in_henchman"

void main()
{
    if (!HenchmanIsPassive(OBJECT_SELF))
    {
        ExecuteScript("nw_ch_ac8", OBJECT_SELF);
    }
}
