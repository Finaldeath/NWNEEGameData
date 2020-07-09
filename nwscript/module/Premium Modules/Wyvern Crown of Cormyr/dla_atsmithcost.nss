//October 2005
// B W-Husey
// On the initial root conversation of the smith, we need to set the cost of crafting in the custom tokens.
// This is based on charisma and race. This is done for this PC only.


void main()
{
    object oPC = GetPCSpeaker();
    int nBase = 1000;
    if (GetRacialType(oPC) == RACIAL_TYPE_HALFELF) nBase = 900;
    if (GetRacialType(oPC) == RACIAL_TYPE_ELF) nBase = 950;
    if (GetRacialType(oPC) == RACIAL_TYPE_DWARF) nBase = 1020;
    if (GetRacialType(oPC) == RACIAL_TYPE_GNOME) nBase = 1020;

    nBase = nBase - (GetAbilityModifier(ABILITY_CHARISMA,oPC)*50);
    SendMessageToPC(oPC,"Racial Check + Ability Modifier Check: Charisma");
    SetCustomToken(1010,IntToString(nBase)+" golden lions");
    SetCustomToken(1011,IntToString(nBase*5)+" golden lions");
    SetLocalInt(oPC,"nCraftCost",nBase);
}
