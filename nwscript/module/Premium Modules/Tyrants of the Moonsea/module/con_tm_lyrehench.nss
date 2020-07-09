//Is Lyressa currently one of the PC's henchmen?
#include "hf_in_henchman"

int StartingConditional()
{
    object oLyressa = GetObjectByTag("Lyressa");

    return (HenchmanIsMine(oLyressa, GetPCSpeaker()));
}
