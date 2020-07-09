//Move Thoyana and PC to Still Waters Inn
#include "x0_i0_walkway"

#include "hf_in_plot"

void MovePC(object oPC)
{
     AssignCommand(oPC, JumpToObject(GetWaypointByTag("WP_ELSWI_PC_JUMP")));
}

void main()
{
    object oPC = GetPCSpeaker();
    object oThoyana = OBJECT_SELF;

    FadeToBlack(oPC, FADE_SPEED_FASTEST);

    SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE);
    SetWalkCondition(NW_WALK_FLAG_INITIALIZED,FALSE);
    PlotLevelSet("SharalynHenchman", 1);
    PlotLevelSet(GetTag(OBJECT_SELF), 2);
    ClearAllActions();
    ActionJumpToObject(GetWaypointByTag("WP_ELSWI_THOYANA_JUMP"));
    ActionDoCommand(MovePC(oPC));
}
