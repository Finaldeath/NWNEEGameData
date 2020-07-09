// player takes a book from bookshelf in exeltis' basement

#include "hf_in_plot"

void main()
{
    object oPC = GetPCSpeaker();
    PlayVoiceChat(VOICE_CHAT_LOOKHERE, oPC);

    string sMe = GetTag(OBJECT_SELF);
    SetLocalInt(GetModule(), "nFeldranStairs", 1);
    PlotLevelSet(sMe, 1);
}
