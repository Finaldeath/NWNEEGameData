// returns true when the player has 1 henchman who is not the speaker
#include "cu_functions"
int StartingConditional()
{
    object oHench = ReturnHenchman(GetPCSpeaker(), 2);
    return oHench != OBJECT_INVALID && oHench != OBJECT_SELF;
}
