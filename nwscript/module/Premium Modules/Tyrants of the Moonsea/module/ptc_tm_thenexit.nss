// mount horses before leaving thentia

#include "hf_in_horse"

void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        float fDelay = HorsePartyMount(oPC, FALSE, TRUE);
        DelayCommand(fDelay, ExecuteScript("hf_map_show", OBJECT_SELF));
    }
}
