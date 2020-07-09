// is the player polymorphed? if so, execute the henchman interject for poly'd

#include "inc_polymorph"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (IsPolymorphed(oPC))
        {
            ExecuteScript("hf_tu_henchman", OBJECT_SELF);
        }
    }
}
