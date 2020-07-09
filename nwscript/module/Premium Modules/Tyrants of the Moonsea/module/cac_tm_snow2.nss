// secret: snowdrift zhent - give play the reward item and exit

#include "hf_in_alignment"

void main()
{
    object oPC = GetPCSpeaker();
    AdjustPlayerAlignment(oPC, ALIGNMENT_GOOD, 5);
    CreateItemOnObject("ringofantivenom", oPC);
    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
