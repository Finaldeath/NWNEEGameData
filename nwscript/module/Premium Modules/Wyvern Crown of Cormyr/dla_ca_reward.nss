////////////////////////////////////////////////////////////////////////////////
// dla_ca_reward - Reward the player for winning the Archery Contest
// Original Scripter: Deva B. Winblood
// Last Modified By:  Gale   16/7/2006
////////////////////////////////////////////////////////////////////////////////
void main()
{
    object oPC=GetPCSpeaker();
    object oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    int nBT=GetBaseItemType(oItem);
    string sRes;

    DeleteLocalInt(oPC,"bArcheryOver");

    if (nBT==BASE_ITEM_HEAVYCROSSBOW||nBT==BASE_ITEM_LIGHTCROSSBOW)
    { // bolts
      nBT=d100();
      if (nBT<50) sRes="nw_wammbo008";
      else if (nBT<70) sRes="nw_wammbo001";
      else if (nBT<80) sRes="boltsofdivine";
      else if (nBT<85) sRes="nw_wammbo005";
      else if (nBT<90) sRes="nw_wammbo001";
      else if (nBT<95) sRes="nw_wammbo002";
      else { sRes="nw_wammbo003"; }
    } // bolts
    else
    { // arrows
      nBT=d100();
      if (nBT<30) sRes="silverarrows";
      else if (nBT<50) sRes="nw_wammar009";
      else if (nBT<60) sRes="flamearrows";
      else if (nBT<70) sRes="pinpointarrows";
      else if (nBT<80) sRes="scribingarrows";
      else if (nBT<85) sRes="nw_wammar006";
      else if (nBT<90) sRes="nw_wammar003";
      else { sRes="nw_wammar005"; }
    } // arrows
    oItem=CreateItemOnObject(sRes,oPC,Random(19)+4);
}
