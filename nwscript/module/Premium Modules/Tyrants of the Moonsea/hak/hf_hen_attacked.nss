#include "hf_in_henchman"

void main()
{
    if (!HenchmanIsPassive(OBJECT_SELF))
    {
        ExecuteScript("nw_ch_ac5", OBJECT_SELF);
    }
}
