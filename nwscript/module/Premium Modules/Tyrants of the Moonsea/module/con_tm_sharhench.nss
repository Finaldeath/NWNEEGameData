//Is Sharalyn currently one of the PC's henchmen?
#include "hf_in_henchman"

int StartingConditional()
{
    object oSharalyn = GetObjectByTag("SharalynHenchman");

    return (HenchmanIsMine(oSharalyn, GetPCSpeaker()));
}
