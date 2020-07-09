// griswald gives the player a reward (his belt)

void main()
{
    object oPC = GetPCSpeaker();
    object oGriswald = GetNearestObjectByTag("ks_griswald", oPC);
    object oBelt = GetItemPossessedBy(oGriswald, "ks_it_gris_belt");
    AssignCommand(oGriswald, ActionGiveItem(oBelt, oPC));
    AssignCommand(oPC, PlaySound("it_genericmedium"));
}
