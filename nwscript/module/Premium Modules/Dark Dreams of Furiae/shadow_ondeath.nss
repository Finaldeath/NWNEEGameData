#include "ddf_util"

#include "ddf_util"

void MoveParty(object oPC);

void main()
{
    int iRequiredKills = 1;

    object oPC = GetFirstPC();
    object oModule = GetModule();
    object oLocation = GetObjectByTag("YourApartmentStartNM");

    int iShadowsKilled = GetLocalInt(oModule, "ddf_shadows_killed");
    iShadowsKilled += 1;
    SetLocalInt(oModule, "ddf_shadows_killed", iShadowsKilled);

    debug("Shadows killed: " + IntToString(iShadowsKilled) + "/" + IntToString(iRequiredKills));

    if(iShadowsKilled == iRequiredKills)
    {
        // done this bit of the nightmare.
        // on to the next bit!
        //DelayCommand(1.0, MoveParty(oPC));

        MovePartyToObject(oPC, GetObjectByTag("YourApartmentStartNM"), TRUE, TRUE);
        /*
        object oPartyMember = GetFirstFactionMember(oPC, TRUE);
        while(GetIsObjectValid(oPartyMember))
        {
            if(!GetIsDead(oPartyMember))
            {
                SetPlotFlag(oPartyMember, TRUE);
                // set cut scene
                AssignCommand(oPartyMember, ClearAllActions());
                SetCutsceneMode(oPartyMember, TRUE, FALSE);
                // Fade to black
                DelayCommand(1.0, FadeToBlack(oPartyMember));
                // AssignCommand(oPartyMember, ClearAllActions());
                // AssignCommand(oPartyMember, JumpToLocation(xxx));
                DelayCommand(2.0, AssignCommand(oPartyMember, ActionJumpToObject(oLocation)));
                // fade from black
                DelayCommand(3.0, FadeFromBlack(oPartyMember));
                // un set cutscene.
                DelayCommand(3.0, SetCutsceneMode(oPartyMember, FALSE, TRUE));
                DelayCommand(3.0, SetPlotFlag(oPartyMember, FALSE));
            }
            oPartyMember = GetNextFactionMember(oPC, TRUE);
        }
        */
    }
}

void MoveParty(object oPC)
{
    MovePartyToObject(oPC, GetObjectByTag("YourApartmentStartNM"), TRUE, TRUE);
}
