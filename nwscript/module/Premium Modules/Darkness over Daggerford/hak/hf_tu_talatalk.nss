// trigger tala in globe to say something
// .. HF_COMMENT_NUM = dialog branch number in Tala's dialog
// .. HF_COMMENT_WHISPER = 1 for a one-liner

#include "hf_in_talatalk"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        if (TalaIsAvailable(oPC))
        {
            if (GetLocalInt(OBJECT_SELF, "nDone") == 0)
            {
                SetLocalInt(OBJECT_SELF, "nDone", 1);
                int nBanterLevel = GetLocalInt(OBJECT_SELF, "HF_COMMENT_NUM");
                if (nBanterLevel != 0)
                {
                    if (!GetLocalInt(OBJECT_SELF, "HF_COMMENT_WHISPER"))
                    {
                        TalaTalk(oPC, nBanterLevel);
                    }
                    else
                    {
                        TalaWhisper(oPC, nBanterLevel);
                    }
                }
            }
        }
    }
}
