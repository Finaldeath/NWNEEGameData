// end the cutscene and flee to exit

#include "hf_in_cutscene"

void main()
{
    CutsceneNextShot();

    // this allows the next messenger to arrive
    DeleteLocalObject(GetModule(), "oQuestGiver");
    SetLocalInt(GetModule(), "nQuestMsgerWaiting", 0);

    ExecuteScript("hf_cs_exit", OBJECT_SELF);
}
