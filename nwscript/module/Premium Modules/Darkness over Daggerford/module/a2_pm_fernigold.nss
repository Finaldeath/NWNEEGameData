//a2_pm_fernigold
#include "x2_inc_switches"

void main()
{
  int nEvent =GetUserDefinedItemEventNumber();

  if (nEvent == X2_ITEM_EVENT_UNACQUIRE)
      {
       object oPC = GetModuleItemLostBy();
       object oItem  = GetModuleItemLost();

       object oCorpse = CreateObject(OBJECT_TYPE_CREATURE,"pm_fernigold_yng",GetLocation(GetNearestObjectByTag("a2_pm_fernigold",oPC)));
       object oPlace = CreateObject(OBJECT_TYPE_PLACEABLE,"pm_fernigolddead",GetLocation(oCorpse));
       DestroyObject(GetNearestObjectByTag("a2_pm_fernigold",oPC),0.2);
      }



}
