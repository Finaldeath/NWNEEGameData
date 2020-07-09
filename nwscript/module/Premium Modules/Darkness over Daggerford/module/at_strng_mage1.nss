// player has taken an item from the mage work table in the stronghold

void main()
{
    string sTag;
    object oPC = GetPCSpeaker();
    int nChoice = GetLocalInt(OBJECT_SELF, "HF_ARG");
    if      (nChoice == 1) sTag = "x2_it_cfm_bscrl";
    else if (nChoice == 2) sTag = "x2_it_cfm_pbottl";
    else if (nChoice == 3) sTag = "x2_it_cfm_wand";
    CreateItemOnObject(sTag, oPC, 1);
}
