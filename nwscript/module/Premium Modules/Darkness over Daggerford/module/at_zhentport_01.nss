// the player leaves illefarn via the teleportation portal
// .. veiti should not be coming with the player

#include "hf_in_npc"
#include "hf_in_henchman"

void main()
{
    object oPC = GetPCSpeaker();

    AddJournalQuestEntry("j21", 10, oPC);
    GiveXPToCreature(oPC, 500);

    // veiti can't come with the player; she stays in illefarn
    object oVeiti = GetNearestObjectByTag("db_veiti", oPC);
    if (GetIsObjectValid(oVeiti))
    {
        if (HenchmanIsMine(oVeiti, oPC))
        {
            HenchmanFire(oVeiti, oPC);
        }
    }

    // can't fade 'cuz going into a cutscene; need delay to cope with autosave
    // .. otherwise the entire game audio system crashes (?)
    DelayCommand(2.0, TeleportToWaypoint(oPC, "WP_AR0402_START", FALSE));
    DoSinglePlayerAutoSave();
}
