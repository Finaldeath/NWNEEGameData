//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: pun_tm_chaotic1
// DATE: August 25, 2005
// AUTH: Luke Scull
// NOTE: 1 point shift to chaotic for unlocking.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

#include "hf_in_alignment"

void main()
{
    if ((GetLocalInt(OBJECT_SELF, "fired") < 1))
    {
        SetLocalInt(OBJECT_SELF, "fired", 1);
        AdjustPlayerAlignment(GetLastUnlocked(), ALIGNMENT_CHAOTIC, 5);
    }
}
