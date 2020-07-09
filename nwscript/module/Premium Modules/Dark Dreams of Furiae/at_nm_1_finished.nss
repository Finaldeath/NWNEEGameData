#include "ddf_util"
#include "ddf_journal"
#include "x0_i0_partywide"

void UpdateXPAndDay(object oPC);

void main()
{

    SetLocalInt(GetModule(), "ddf_nm_1_finished", TRUE);

    // Inc-day (maybe also set/check/run at_inc_day script?)
    // move everyone to normal version of your apartment

    // drain 1 con from everyone
    // update journal
    // get some XP

    object oPC = GetFirstPC();// GetPCSpeaker();
    object oLocation = GetObjectByTag("YourApartmentStart");
        object oPartyMember = GetFirstFactionMember(oPC, TRUE);

        effect eDrain;
        effect eVis;

    debug(IntToString(GetIsObjectValid(oPC)) + " " + IntToString(GetIsObjectValid(oLocation)) + " " + IntToString(GetIsObjectValid(oPartyMember)));


        while(GetIsObjectValid(oPartyMember))
        {
            if(!GetIsDead(oPartyMember))
            {
                // set cut scene
                //SetCutsceneMode(oPartyMember, TRUE, FALSE);
                // Fade to black
                //FadeToBlack(oPartyMember);
                // AssignCommand(oPartyMember, ClearAllActions());
                //AssignCommand(oPartyMember, ClearAllActions());

                eDrain = EffectAbilityDecrease(ABILITY_CONSTITUTION, 1);
                eDrain = SupernaturalEffect(eDrain); // to make it permanent --  https://app.asana.com/0/842177838074622/1116978695178841
                eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPartyMember);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oPartyMember);

                DelayCommand(4.0, SetCutsceneMode(oPartyMember, TRUE, FALSE));
                DelayCommand(4.0, FadeToBlack(oPartyMember));

                // AssignCommand(oPartyMember, JumpToLocation(xxx));
                DelayCommand(5.0, AssignCommand(oPartyMember, ActionJumpToObject(oLocation)));
                // fade from black
                DelayCommand(6.0, FadeFromBlack(oPartyMember));
                // un set cutscene.
                DelayCommand(6.0, SetCutsceneMode(oPartyMember, FALSE, TRUE));
            }
            oPartyMember = GetNextFactionMember(oPC, TRUE);
        }
        DelayCommand(8.0, UpdateXPAndDay(oPC));
        DestroyObject(OBJECT_SELF, 9.0);
}

void UpdateXPAndDay(object oPC)
{
    //GiveXPToAll(oPC, XP_SMALL);
    IncrementDay();
    UpdateJournal(oPC);

    SetLocalInt(GetModule(), "ddf_quill_paid", FALSE);
    SetLocalInt(GetModule(), "ddf_forv_spoke", FALSE);
    //SetLocalInt(GetModule(), "ddf_forv_asked", FALSE);
    SetLocalInt(GetModule(), "ddf_luic_spoke", FALSE);
    SetLocalInt(GetModule(), "ddf_luic_asked", FALSE);
}
