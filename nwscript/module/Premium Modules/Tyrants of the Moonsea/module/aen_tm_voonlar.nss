// area enter script for voonlar

#include "hf_in_cutscene"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        // automatically explore this urban area
        if (GetLocalInt(OBJECT_SELF, "nEntered") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            ExploreAreaForPlayer(GetArea(oPC), oPC, TRUE);
        }

        //Create Bennart and engage in dialog if PC is carrying Bennart body
        if(GetItemPossessedBy(oPC, "BennartWaters") != OBJECT_INVALID)
        {
            CutscenePlay(oPC, "cut_tm_bennart");
        }
    }
}
