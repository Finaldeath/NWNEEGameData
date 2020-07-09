#include "ddf_journal"
#include "ddf_util"

void main()
{
    debug("FINISHED quill dialog 001");

    // Set the variables
    SetLocalInt(GetModule(), "dlg_quill_001_done", TRUE);
    UpdateJournal(GetPCSpeaker());

    // Move the whole party together.
    MovePartyToObject(GetFirstPC(), GetObjectByTag("YourApartmentStart"));

    // Teleport Quillian into your apartment
    AssignCommand(GetObjectByTag("DDF_NPC_Quillian"), ActionJumpToObject(GetWaypointByTag("DDF_QUILL_START"), FALSE));

    // Teleport Witnesses to in front of the warehouse
    AssignCommand(GetObjectByTag("DDF_WarehouseCityGuard01"), ActionJumpToObject(GetWaypointByTag("NW_SM_Guard1"), FALSE));
    AssignCommand(GetObjectByTag("DDF_WarehouseCityGuard02"), ActionJumpToObject(GetWaypointByTag("NW_SM_Guard2"), FALSE));
    AssignCommand(GetObjectByTag("DDF_WarehouseCityGuard03"), ActionJumpToObject(GetWaypointByTag("NW_SM_Guard3"), FALSE));
    AssignCommand(GetObjectByTag("DDF_WarehouseCityGuard04"), ActionJumpToObject(GetWaypointByTag("NW_SM_Guard4"), FALSE));
    AssignCommand(GetObjectByTag("SeaMarketCommoner1"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Commoner1"), FALSE));
    AssignCommand(GetObjectByTag("SeaMarketCommoner2"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Commoner2"), FALSE));
    AssignCommand(GetObjectByTag("SeaMarketCommoner3"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Commoner3"), FALSE));
    AssignCommand(GetObjectByTag("Commoner1WhisperingShylia"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Whisperer1"), FALSE));
    AssignCommand(GetObjectByTag("Commoner2WhisperingShylia"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Whisperer2"), FALSE));
    AssignCommand(GetObjectByTag("Shylia"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Shylia"), FALSE));

    AssignCommand(GetObjectByTag("DDF_NPC_Teddy"), ClearAllActions(TRUE));
    AssignCommand(GetObjectByTag("DDF_NPC_Teddy"), ActionJumpToObject(GetWaypointByTag("seamarket_arrival_teddy"), FALSE));

    AssignCommand(GetObjectByTag("DDF_NPC_HarasiF"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Harasi"), FALSE));
    AssignCommand(GetObjectByTag("NamedWitnesstoExplosion"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Bilbang"), FALSE));
    AssignCommand(GetObjectByTag("NamedWitnesstoExplosion2"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Karina"), FALSE));
    AssignCommand(GetObjectByTag("DDF_NPC_Lucenna"), ActionJumpToObject(GetWaypointByTag("Sea_Market_Lucenna"), FALSE));
    AssignCommand(GetObjectByTag("DDF_WarehouseCityGuard01"), ActionJumpToObject(GetWaypointByTag("NW_SM_Guard1"), FALSE));

    // Destroy the trigger so it can't be used again
    object oAreaTrigger = GetObjectByTag("YourAptTransition");
    DestroyObject(oAreaTrigger);
    object oAreaBlocker = GetObjectByTag("RemoveAfterTeleport");
    DestroyObject(oAreaBlocker);
}
