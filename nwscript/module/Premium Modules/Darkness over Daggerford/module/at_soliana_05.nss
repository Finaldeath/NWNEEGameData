// soliana gives her amulet to the player as a reward

void main()
{
    object oPC = GetPCSpeaker();
    object oSoliana = GetNearestObjectByTag("ks_soliana", oPC);
    object oAmulet = GetItemPossessedBy(oSoliana, "ks_it_sol_amu");
    AssignCommand(oSoliana, ActionGiveItem(oAmulet, oPC));
    AssignCommand(oPC, PlaySound("it_jewelry"));
}
