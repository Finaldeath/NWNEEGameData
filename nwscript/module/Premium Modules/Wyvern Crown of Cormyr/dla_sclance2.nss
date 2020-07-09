#include "dla_i0_joust"

int StartingConditional()
{
  object oLanceRack = GetObjectByTag(DLA_TAG_JOUST_LANCERACK);
//  return DLA_GetRackHasLance(oLanceRack, 2);
  return TRUE;
}
