// applies the selected blessing to the weapon and deducts gold

#include "inc_aob"

void main()
{
    object oPC = GetPCSpeaker();
    AltarApplyBlessing(oPC);
}
