// the player has selected a forge item to make

#include "hf_in_forge"

void main()
{
    object oPC = GetPCSpeaker();
    int nItemNum = GetLocalInt(OBJECT_SELF, "HF_ARG");
    ForgeMake(OBJECT_SELF, oPC, nItemNum);
}
