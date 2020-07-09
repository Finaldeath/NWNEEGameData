//::///////////////////////////////////////////////
//:: ten_a2_snprsnrs
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Has the PC seen the prisoners in the prison?
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: Aug, 2004
//:://////////////////////////////////////////////

void main()
{
    object oModule = GetModule();
    object oEnter = GetEnteringObject();

    if (GetIsPC(oEnter) == TRUE)
    {
        SetLocalInt(oModule, "PC_SEEN_PRISONERS", TRUE);
    }
}
