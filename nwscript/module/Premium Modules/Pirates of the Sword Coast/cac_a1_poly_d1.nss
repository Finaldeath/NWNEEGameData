//::///////////////////////////////////////////////
//:: cac_a1_poly_d1
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Do once for Poly greeting the player on the
    Trog Island.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oPC = GetPCSpeaker();
    object oPoly = OBJECT_SELF;

    int iHitDice = GetFactionAverageLevel(oPC);
    int iLevel = GetHitDice(oPoly);

    SetLocalInt(oModule, "cac_a1_poly_d1", TRUE);

    while (iLevel < iHitDice)
    {
        iLevel = LevelUpHenchman(oPoly);
    }

    ForceRest(oPoly);
}
