#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    HenchmanFire(OBJECT_SELF, oPC);
    HenchmanGoHome(OBJECT_SELF);
}
