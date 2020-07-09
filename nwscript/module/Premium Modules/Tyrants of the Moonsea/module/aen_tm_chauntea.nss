// synchronize priestess worship animations

#include "hf_in_util"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        int n = 1;
        object oPriestess = GetObjectInArea("PriestessofChauntea", oPC, n);
        while (GetIsObjectValid(oPriestess))
        {
            AssignCommand(oPriestess, ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 32767.0));
            oPriestess = GetObjectInArea("PriestessofChauntea", oPC, ++n);
        }
    }
}
