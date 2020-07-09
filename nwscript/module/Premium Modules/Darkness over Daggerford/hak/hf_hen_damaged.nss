#include "hf_in_henchman"

void main()
{
    if (!HenchmanIsPassive(OBJECT_SELF))
    {
        ExecuteScript("nw_ch_ac6", OBJECT_SELF);
    }
}
