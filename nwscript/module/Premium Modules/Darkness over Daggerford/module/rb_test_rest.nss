#include "hf_in_henchman"
#include "hf_in_rest"

void main()
{
    object oPC = GetPCSpeaker();

    RestSetTired(oPC, FALSE);

    int i = 1;
    object oHench = GetHenchman(oPC, i);
    while (GetIsObjectValid(oHench))
    {
        HenchmanRest(oHench);
        oHench = GetHenchman(oPC, ++i);
    }

    ForceRest(oPC);
}
