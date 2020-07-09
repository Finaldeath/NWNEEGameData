#include "hf_in_henchman"

void main()
{
    SetMaxHenchmen(3);

    object oPC = GetPCSpeaker();
    object oHench = CreateObject(OBJECT_TYPE_CREATURE, "ks_purfbin", GetLocation(oPC));

    DelayCommand(1.0, HenchmanHire(oHench, oPC));
}
