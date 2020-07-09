//::///////////////////////////////////////////////
//:: Starts the betting fight
//:: cac_a2_redtip_bt
//:: Copyright (c) 2005 Bioware Corp.
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: March 14/05
//:://////////////////////////////////////////////
#include "inc_global"

void main()
{
    // OBJECT_SELF = Redtip

    // remember which player did the betting, so we give the money
    // to the right person if they win.
    object oPC = GetPCSpeaker();
    SetLocalObject(OBJECT_SELF, l_o_FIGHTCLUB_BETTING_PLAYER, oPC);

    // If the fight cutscene is aborted, it would then be possible to
    // start another while the delayed commands for the previous fight
    // are still firing. So, we have to use a new cutscene number each
    // time we start this cutscene.
    int nCutsceneNumber = GetLocalInt(OBJECT_SELF, l_n_FIGHTCLUB_CUTSCENE_NUMBER);
    if(nCutsceneNumber < 10)
    {
        // start at 10, to allow room for other cutscenes (currently only
        // one other one, but who knows, we might add more).
        nCutsceneNumber = 10;
    }
    else
    {
        nCutsceneNumber++;
        // heh, somehow I doubt this will ever be needed.. but I still like
        // to cover all scenarios :)
        if(nCutsceneNumber>100000) nCutsceneNumber = 10;
    }
    SetLocalInt(OBJECT_SELF, l_n_FIGHTCLUB_CUTSCENE_NUMBER, nCutsceneNumber);

    // store the fighter's original positions, so we can put them back
    // after the fight
    object oFighter1 = GetLocalObject(OBJECT_SELF, l_o_FIGHTCLUB_FIGHTER1);
    object oFighter2 = GetLocalObject(OBJECT_SELF, l_o_FIGHTCLUB_FIGHTER2);
    location lFighter1 = GetLocation(oFighter1);
    location lFighter2 = GetLocation(oFighter2);
    SetLocalLocation(OBJECT_SELF, l_l_FIGHTCLUB_ORIG_POS_FIGHTER1, lFighter1);
    SetLocalLocation(OBJECT_SELF, l_l_FIGHTCLUB_ORIG_POS_FIGHTER2, lFighter2);

    // remove plot flag, set immortal flag
    SetImmortal(oFighter1, TRUE);
    SetImmortal(oFighter2, TRUE);
    SetPlotFlag(oFighter1, FALSE);
    SetPlotFlag(oFighter2, FALSE);

    // determine winner and set winner variable on both fighters
    int nWinner = Random(2);
    if(nWinner==1)
    {
        SetLocalInt(oFighter1, l_n_FIGHTCLUB_PARTICIPANT, l_nv_FIGHTCLUB_PARTICIPANT_WINNER);
        SetLocalInt(oFighter2, l_n_FIGHTCLUB_PARTICIPANT, l_nv_FIGHTCLUB_PARTICIPANT_LOSER);
        SetLocalInt(OBJECT_SELF, l_n_FIGHTCLUB_PLAYER_WON_BET, TRUE);
    }
    else
    {
        SetLocalInt(oFighter1, l_n_FIGHTCLUB_PARTICIPANT, l_nv_FIGHTCLUB_PARTICIPANT_LOSER);
        SetLocalInt(oFighter2, l_n_FIGHTCLUB_PARTICIPANT, l_nv_FIGHTCLUB_PARTICIPANT_WINNER);
        SetLocalInt(OBJECT_SELF, l_n_FIGHTCLUB_PLAYER_WON_BET, FALSE);
    }

    // and start the cutscene
    cs_PreCutsceneFade(CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);
    cs_StartCutscene_Poly("cut_a2_betfight", "cut_a2_betfighte", 1.0, TRUE, TRUE, nCutsceneNumber);
}
