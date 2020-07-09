// this onEnter event will spawn extra "end game" commoners in the area
// .. it is used in the various inns in daggerford to spawn folks hiding
// .. from the orc invasion

#include "hf_in_spawn"

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        SpawnEnter(oPC);

        if (GetLocalInt(GetModule(), "pm_endgame_start") == 1 &&
            GetLocalString(OBJECT_SELF, "HF_SP_NAME") != "EndGame")
        {
            SetLocalString(OBJECT_SELF, "HF_SP_NAME", "EndGame");
            SpawnEnter(oPC);
        }
    }
}
