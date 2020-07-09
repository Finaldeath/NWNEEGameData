//Is Beirmoura currently one of the PC's henchmen?
#include "hf_in_henchman"

int StartingConditional()
{
    object oBeirmoura = GetObjectByTag("Beirmoura");

    return (HenchmanIsMine(oBeirmoura, GetPCSpeaker()));
}
