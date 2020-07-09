//::///////////////////////////////////////////////
//:: aen_a2_willmanor
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Area OnEnter for Willigan's Manor.
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 18/05
//:://////////////////////////////////////////////
#include "inc_willigan"
#include "nw_i0_generic"

void main()
{
    object oPC = GetEnteringObject();

    cs_AreaOnEnter_Poly(oPC);

    if(GetIsPCNotDM(oPC))
    {
        // Regardless of what happens below, we always want the PC to
        // be immortal in this area. This is turned off in the area on-exit event.
        SetImmortal(oPC, TRUE);

        // are we supposed to start the Willigan escape cutscene?
        if(GetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_SUCCESS_CS_START))
        {
            // only do once of course
            SetLocalInt(OBJECT_SELF, l_n_A2_WILLIGAN_SUCCESS_CS_START, FALSE);

            // stop Fanny and her sisters from doing their normal stuff

            object oFanny = GetObjectByTag(a2c_tag_Fanny);
            object oFannySis1 = GetObjectByTag(a2c_tag_FannySis1);
            object oFannySis2 = GetObjectByTag(a2c_tag_FannySis2);

            SetLocalInt(oFanny, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_CUTSCENE);
            SetLocalInt(oFannySis1, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_CUTSCENE);
            SetLocalInt(oFannySis2, l_n_A2_WILLIGAN_FANNY_STATE, l_nv_A2_WILLIGAN_FANNY_STATE_CUTSCENE);

            SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oFanny);
            SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oFannySis1);
            SetWalkCondition(NW_WALK_FLAG_CONSTANT, FALSE, oFannySis2);

            AssignCommand(oFanny, ClearAllActions(TRUE));
            AssignCommand(oFannySis1, ClearAllActions(TRUE));
            AssignCommand(oFannySis2, ClearAllActions(TRUE));

            cs_PreCutsceneFade(CS_FADE_TYPE_BLACK);
            cs_StartCutscene_Poly("cut_a2_wwesc", "cut_a2_wwesc_end", 2.5, TRUE);
            // the delay is a little high, but this for multiplayer, just in
            // case a PC got caught by a sister just as another PC triggered
            // the escape cutscene. This allows time for the first PC to get
            // kicked out, and in theory nothing should screw up.
        }
        else
        {
            object oFanny = GetObjectByTag(a2c_tag_Fanny);
            object oFannySis1 = GetObjectByTag(a2c_tag_FannySis1);
            object oFannySis2 = GetObjectByTag(a2c_tag_FannySis2);

            // Jump Fanny and her sisters back to their waypoints.
            AssignCommand(oFanny, JumpToObject(GetObjectByTag("WP_a2_fanny_01")));
            AssignCommand(oFannySis2, JumpToObject(GetObjectByTag("WP_a2_fannysis1_01")));
            AssignCommand(oFannySis2, JumpToObject(GetObjectByTag("WP_a2_fannysis2_01")));

            // spawn Willigan's items, as needed
            object oModule = GetModule();
            // first check to see if the player has even heard of the items
            if(GetLocalInt(oModule, "A2_WHIPD") >= 30)
            {
                object oBoots = GetObjectByTag(a2i_Willigan_Boots);
                object oCutlass = GetObjectByTag(a2i_Willigan_Cutlass);
                object oGarb = GetObjectByTag(a2i_Willigan_Garb);

                // for each item - if the item does not exist in the game,
                // and the item has not yet been given to Willigan, then
                // spawn the item in a chest. In theory, checking to see if
                // the items have been given to Willigan is not needed, since
                // he should have the items, and therefore they exist. But it
                // doesn't hurt.
                if( (!GetIsObjectValid(oBoots)) &&
                    (GetLocalInt(oModule, "A2_WWBOOT") < 30) )
                {
                    A2WillyChestSpawnItem(a2i_Willigan_Boots);
                }
                if( (!GetIsObjectValid(oCutlass)) &&
                    (GetLocalInt(oModule, "A2_WWCTLS") < 30) )
                {
                    A2WillyChestSpawnItem(a2i_Willigan_Cutlass);
                }
                if( (!GetIsObjectValid(oGarb)) &&
                    (GetLocalInt(oModule, "A2_WWGARB") < 30) )
                {
                    A2WillyChestSpawnItem(a2i_Willigan_Garb);
                }
            }

        }
    }
}
