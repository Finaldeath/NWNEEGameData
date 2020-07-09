#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    object oLyressa = CreateObject(OBJECT_TYPE_CREATURE, "lyressa", GetLocation(oPC));
    HenchmanHire(oLyressa, oPC);
}
