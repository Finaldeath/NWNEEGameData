#include "hf_in_henchman"

void main()
{
    object oPC = GetFirstPC();
    object oHench = GetObjectByTag("hf_henchman");
    HenchmanHire(oHench, oPC);
}
