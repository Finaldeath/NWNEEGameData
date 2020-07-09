#include "NW_I0_GENERIC"

void main()
{
    object oPC = GetPCSpeaker();

    if (GetLocalInt(OBJECT_SELF, "HF_ARG") == 1)
    {
        SetLocalInt(OBJECT_SELF, "HF_ARG", 0);
        ActionMoveAwayFromObject(oPC, TRUE, 25.0f);
    }
    else
    {
        WalkWayPoints();
    }
}

