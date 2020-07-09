//::///////////////////////////////////////////////
//:: aen_a2_tmplmbrl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Mark the player as having entered the
    Temple of Umberlee in Spindrift act 2.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////
void main()
{
    object oModule = GetModule();
    object oEnter = GetEnteringObject();
    object oArea = OBJECT_SELF;
    int iDoOnce = GetLocalInt(oModule, "aen_a2_tmplmbrl");

    if ((iDoOnce == FALSE) && (GetIsPC(oEnter) == TRUE))
    {
        SetLocalInt(oModule, "aen_a2_tmplmbrl", TRUE);
    }
}
