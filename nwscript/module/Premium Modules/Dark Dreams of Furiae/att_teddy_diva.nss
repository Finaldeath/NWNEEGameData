#include "ddf_util"

const string dlg_d0 = "Stand and declare.";
const string dlg_t0 = "Oh, I'm Teddy. I'm the steward of Aladara? I think Yvonne is expecting me?";
const string dlg_d1 = "I've been informed. Go right in, but don't interfere with the City Guards or inspectors inside.";

void main()
{
    object oEnter = GetEnteringObject();


    // If the player entered this trigger
    if (GetIsPC(oEnter))
    {
        object oTeddy = GetObjectByTag("DDF_NPC_Teddy");

        // Early out if Teddy is dead
        if (GetLocalInt(GetModule(), "ddf_teddy_dead") == TRUE)
        {
            return;
        }

        // Early out if Teddy has already spoken to Yvonne
        if (GetLocalInt(GetModule(), "ddf_yvon_tedd_met") == TRUE)
        {
            return;
        }

        // Early out if Teddy already talked to Divala
        if (GetLocalInt(oTeddy, "Teddy_Diva_Talk") == TRUE)
        {
            return;
        }

        // 2019-08-22 JY
        // Because we are exiting earlier, this script can be retriggered before this was
        // set to TRUE before, so we are setting it here, right away.
        SetLocalInt(oTeddy, "Teddy_Diva_Talk", TRUE);

        debug("-- doing Teddy-Divala talk");

        // Disable player control
        SetCutsceneMode(oEnter, TRUE);

        // Move teddy
        AssignCommand(oTeddy, ActionMoveToObject(GetWaypointByTag("NW_DIVA_TALK"), TRUE));

        // Talk to Dilvala
        object oDivala = GetObjectByTag("CaptainDivala");
        SetLocalInt(oDivala, "speaking", TRUE);
        DelayCommand(4.f , AssignCommand(oDivala, SpeakString(dlg_d0)));
        DelayCommand(6.f , AssignCommand(oTeddy, SpeakString(dlg_t0)));
        DelayCommand(10.f , AssignCommand(oDivala, SpeakString(dlg_d1)));


        // Make Teddy invisible
        DelayCommand(14.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_INVISIBILITY), oTeddy, 3.0));

        // Clear Teddy's line before he teleports.
        DelayCommand(14.f , AssignCommand(oTeddy, SpeakString("")));


        // Teleport to other side
        DelayCommand(15.f , AssignCommand(oTeddy, ActionJumpToObject(GetWaypointByTag("NW_DIVA_PASS"), FALSE)));
        DelayCommand(15.f, AssignCommand(oDivala, SpeakString("")));

        // 2019-08-23 JY
        // We are going to kick out of cut-scene mode here, after the teleport...
        // https://app.asana.com/0/842177838074622/913231148219763
        DelayCommand(16.f , SetCutsceneMode(oEnter, FALSE));
        DelayCommand(16.0 , SetLocalInt(oDivala, "speaking", FALSE));

        // Walk to front door
        DelayCommand(17.0f , AssignCommand(oTeddy, ActionMoveToObject(GetWaypointByTag("ORISAW_FRONT_DOOR"))));


        // Teleport to limbo
        object oTeddyLimboWaypoint = GetWaypointByTag("NW_LIMBO_TEDDY");
        location locTLWP = GetLocation( oTeddyLimboWaypoint );
        DelayCommand(20.f , AssignCommand(oTeddy, ActionJumpToLocation(locTLWP)));


    }
}
