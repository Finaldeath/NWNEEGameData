#include "ddf_util"

void main()
{
    int nDay = GetCurrentDay();
    object oPC = GetPCSpeaker();

    // Nightmare related script
    object oLocation = GetObjectByTag("ddf_SpawnPoint_FirstNightmare01");
    if(nDay == 5) oLocation = GetObjectByTag("ddf_SpawnPoint_SecondNightmare01");

    MovePartyToObject(oPC, oLocation, TRUE, TRUE);
    /*
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    while(GetIsObjectValid(oPartyMember))
    {
        if(!GetIsDead(oPartyMember))
        {
            // set cut scene
            SetCutsceneMode(oPartyMember, TRUE, FALSE);
            // Fade to black
            FadeToBlack(oPartyMember);
            // AssignCommand(oPartyMember, ClearAllActions());
            AssignCommand(oPartyMember, ClearAllActions());
            // AssignCommand(oPartyMember, JumpToLocation(xxx));
            DelayCommand(1.0, AssignCommand(oPartyMember, ActionJumpToObject(oLocation)));
            // fade from black
            DelayCommand(3.0, FadeFromBlack(oPartyMember));
            // un set cutscene.
            DelayCommand(3.0, SetCutsceneMode(oPartyMember, FALSE, TRUE));
        }
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
    */
    debug("Sent all players to nightmare.");
}
