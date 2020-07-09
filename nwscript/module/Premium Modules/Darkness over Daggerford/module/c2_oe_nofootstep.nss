/////////////////////////////////////////
//c2_oe_nofootstep
//Script for Alan M to use with his water placeables
//since there is no water footstep sound the alternative is to have no footstep
//
//Author: Phil Mitchell (Baron of Gateford)
//////////////////////////////////////////

void main()
{
 object oPC = GetEnteringObject();
 if (!GetIsPC(oPC)) return;
 SetFootstepType(FOOTSTEP_TYPE_NONE,oPC);
}
