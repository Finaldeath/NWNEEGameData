//:://////////////////////////////////////////////
//:: Act 0: Golden Apple Upstairs (OnExit)
//:: aex_a0_gaupstair.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Jump Tasina to the Midnight Rose if the
     player's completed the escort plot
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
