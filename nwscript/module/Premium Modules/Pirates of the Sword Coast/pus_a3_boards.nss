//::///////////////////////////////////////////////
//:: pus_a3_bldgpmp
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The skull and bones Blidge pump has been
    activated by a player.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Hayward
//:: Created On: January 2005
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetLastUsedBy();
    object oBoardPile = OBJECT_SELF;
    object oModule = GetModule();
    object oBoard = GetItemPossessedBy(oPC, "a3_wdnbrds");

    int iPlot = GetLocalInt(oModule, "A3_SEIGE");

    if (iPlot < 40 )
    {
        // create boards in the PC's inventory then destroy the placable.
        if (GetIsObjectValid(oBoard) == FALSE)
        {
            FloatingTextStringOnCreature("You gather an armful of repair planking.", oPC);
            AssignCommand(oPC, PlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0f, 3.0f));
            DelayCommand(0.1f, SetCommandable(FALSE, oPC));
            DelayCommand(3.1f, SetCommandable(TRUE, oPC));
            CreateItemOnObject("a3_wdnbrds", oPC);

        }
        else
        {
            FloatingTextStringOnCreature("You already have as much repair planking as you can carry.", oPC);
        }
    }
    else
    {
        FloatingTextStringOnCreature("You don't need any more repair planking.", oPC);
    }
}
