//:://////////////////////////////////////////////
//:: cex_a0_gldnppl
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The plot is resolved, teleport Tasina to the
    Midnight Rose.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: July, 2004
//:://////////////////////////////////////////////

void main()
{
    object oTasina = GetObjectByTag("a0_tasina");
    object oBag1 = GetObjectByTag("a0_tasbag1");
    object oBag2 = GetObjectByTag("a0_tasbag2");
    object oTargetWay = GetWaypointByTag("a0_tasinaboat1");
    object oModule = GetModule();

    int iEscort = GetLocalInt(oModule, "A0_ESCORT");
    int iDoOnce = GetLocalInt(oModule, "cex_a0_gldnppl");

    if ((iEscort >= 50) && (iDoOnce == FALSE))
    {
        SetLocalInt(oModule, "cex_a0_gldnppl", TRUE);

        // Teleport Tasina and destroy ehr bagagge.
        AssignCommand(oTasina, JumpToObject(oTargetWay));
        DestroyObject(oBag1);
        DestroyObject(oBag2);
    }
}
