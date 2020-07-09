// this script determines toll cost for PC based off wealth displayed - bw

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nWealth = 0;

    // these values determine wealth levels, in GP
    int nSuperRich  = 500000;
    int nRich       = 100000;
    int nWellOff    = 30000;

    // these values determine toll costs based off of above limits
    int nToll       = 200;  // default
    int nTollSR     = 3000;
    int nTollR      = 1000;
    int nTollWO     = 500;

    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_BELT, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_NECK, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
    nWealth += GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));

    if      (nWealth >= nSuperRich) nToll = nTollSR;
    else if (nWealth >= nRich)      nToll = nTollR;
    else if (nWealth >= nWellOff)   nToll = nTollWO;

    // toll should be set to previous level, if pc assessed before
    int nPastToll = GetLocalInt(oPC, "nWH_TollPrice");
    if (nPastToll > nToll) nToll = nPastToll;

    SetLocalInt(oPC, "nWH_TollPrice", nToll);

    SetCustomToken(1000, IntToString(nToll));

    return FALSE;
}
