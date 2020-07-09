// for use in dialogs; tala appears beside the player
// ... tala's object tag is ks_pl_talatlk

#include "hf_in_talatalk"

void main()
{
    object oPC = GetPCSpeaker();
    if (TalaIsAvailable(oPC))
    {
        TalaAppear(oPC);
    }
}
