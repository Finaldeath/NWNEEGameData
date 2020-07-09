//::///////////////////////////////////////////////
//:: c2_oe_wafootstep
//:: Copyright (c) 2006 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Plays a water footstep (normal or large) when walking
    over placeable water.  Works for any terrain type. Exceptions,
    for creatures that would not play this footstep type, are handled.
*/
//:://////////////////////////////////////////////
//:: Created On: January, 2006
//:://////////////////////////////////////////////

void main()
{
  object oCreature = GetEnteringObject();
  int nFootStepType = GetFootstepType(oCreature);

  if (nFootStepType == FOOTSTEP_TYPE_LEATHER_WING ||
      nFootStepType == FOOTSTEP_TYPE_FEATHER_WING ||
      nFootStepType == FOOTSTEP_TYPE_INVALID      ||
      nFootStepType == FOOTSTEP_TYPE_SHARK ) return;

  if (nFootStepType == FOOTSTEP_TYPE_LARGE  ||
      nFootStepType == FOOTSTEP_TYPE_DRAGON ||
      nFootStepType == FOOTSTEP_TYPE_HOOF_LARGE )
  {
    SetFootstepType(FOOTSTEP_TYPE_WATER_LARGE, oCreature);
  }
  else
  {
    SetFootstepType(FOOTSTEP_TYPE_WATER_NORMAL, oCreature);
  }
}
