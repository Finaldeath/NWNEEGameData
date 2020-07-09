#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();
    object oSharalyn = CreateObject(OBJECT_TYPE_CREATURE, "sharalynhenchman", GetLocation(oPC));
    HenchmanHire(oSharalyn, oPC);
}
