//cut blackriver bandits

#include "x0_i0_henchman"
#include "_inc_cutscene"

const string sLine01 = "Well, well, well... What have we here?";

void main()
{
    object oArea = OBJECT_SELF;
    object oStandin = GetObjectByTag("brbnd_standin");
    object oTalker = GetLocalObject(oArea, "A0_BRB_Talker");

    object oRealNisar = GetObjectByTag("a0_hench_nisar");

    object oWP_Player1 = GetWaypointByTag("wp_brbcut_plr01");
    object oWP_Player2 = GetWaypointByTag("wp_brbcut_plr02");
    object oWP_Player3 = GetWaypointByTag("wp_brbcut_plr03");
    object oWP_Player4 = GetWaypointByTag("wp_brbcut_plr04");

    object oWP_Nisar = GetWaypointByTag("wp_brb_nisar");

    object oWP_BRBSpawn1 = GetWaypointByTag("wp_brb_spawn1");
    object oWP_BRBSpawn2 = GetWaypointByTag("wp_brb_spawn2");

    object oWP_BRBDest1 = GetWaypointByTag("wp_brb_dest1c");
    object oWP_BRBDest2 = GetWaypointByTag("wp_brb_dest2c");

    object oBRBandit2 = CreateObject(OBJECT_TYPE_CREATURE,
        "a0_honeypea", GetLocation(oWP_BRBSpawn1), TRUE);
    object oBRBandit1 = CreateObject(OBJECT_TYPE_CREATURE,
        "a0_bradleyblkr", GetLocation(oWP_BRBSpawn2), TRUE);

    object oWP_Blood1 = GetWaypointByTag("wp_brb_bloodsailor1");
    object oWP_Blood2 = GetWaypointByTag("wp_brb_bloodsailor2");
    object oWP_Blood3 = GetWaypointByTag("wp_brb_bloodsailor3");
    object oWP_Blood4 = GetWaypointByTag("wp_brb_bloodsailor4");

    location lBlood1 = GetLocation(oWP_Blood1);
    location lBlood2 = GetLocation(oWP_Blood2);
    location lBlood3 = GetLocation(oWP_Blood3);
    location lBlood4 = GetLocation(oWP_Blood4);

    object oSailor1 = CreateObject(OBJECT_TYPE_CREATURE,
        "a0_bloodcut1", lBlood1, FALSE);
    object oSailor2 = CreateObject(OBJECT_TYPE_CREATURE,
        "a0_bloodcut2", lBlood2, FALSE);
    object oSailor3 = CreateObject(OBJECT_TYPE_CREATURE,
        "a0_bloodcut3", lBlood3, FALSE);
    object oSailor4 = CreateObject(OBJECT_TYPE_CREATURE,
        "a0_bloodcut4", lBlood4, FALSE);

    location lPlayer1 = GetLocation(oWP_Player1);
    location lPlayer2 = GetLocation(oWP_Player2);
    location lPlayer3 = GetLocation(oWP_Player3);
    location lPlayer4 = GetLocation(oWP_Player4);

    location lNisar = GetLocation(oWP_Nisar);
    location lBRBSpawn1 = GetLocation(oWP_BRBSpawn1);
    location lBRBSpawn2 = GetLocation(oWP_BRBSpawn2);

    int iCounter = 0;

    object oPCHolder = cs_GetPCObject(iCounter);
    object oPCClone1, oPCClone2, oPCClone3;

    // Fill the avaible seats in the frount row
    while (GetIsPC(oPCHolder) == FALSE)
    {
        if (oPCHolder != oTalker)
        {
            if (GetIsObjectValid(oPCClone1) == TRUE)
            {
                oPCClone1 = oPCHolder;
            }
            else if (GetIsObjectValid(oPCClone1) == TRUE)
            {
                oPCClone2 = oPCHolder;
            }
            else if (GetIsObjectValid(oPCClone1) == TRUE)
            {
                oPCClone3 = oPCHolder;
            }
        }
        oPCHolder = cs_GetPCObject(++iCounter);
    }

    cs_CopyPC(lPlayer1, FALSE, cs_GetPCNumber(oTalker), "PCTalker");
    cs_CopyPC(lPlayer2, FALSE, cs_GetPCNumber(oPCClone1), "PCClone1");
    cs_CopyPC(lPlayer3, FALSE, cs_GetPCNumber(oPCClone2), "PCClone2");
    cs_CopyPC(lPlayer4, FALSE, cs_GetPCNumber(oPCClone3), "PCClone3");

    object oNisar = CopyObject(oRealNisar, lNisar, OBJECT_INVALID, "A0_TEMP_NISAR");
    AssignCommand(oNisar,ChangeToStandardFaction(oNisar,STANDARD_FACTION_COMMONER));
    FireHenchman(GetMaster(oNisar), oNisar);
    AssignCommand(oNisar, SetIsDestroyable(TRUE, FALSE, FALSE));
    DelayCommand(1.0f, AssignCommand(oNisar, ClearAllActions(TRUE)));


    if (cs_GetPCNumber(GetMaster(oNisar)) != -1)
    {
        AssignCommand(oNisar, ClearAllActions(TRUE));
        AssignCommand(oNisar, JumpToLocation(lNisar));
    }

    cs_CameraUseCameraWaypoint(0.0f, 1);
    cs_CameraSetFacing(0.2f, 115.0f, 9.0f, 75.0f, CAMERA_TRANSITION_TYPE_SLOW);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    cs_ActionMoveToObject(1.0f, oBRBandit2, oWP_BRBDest1, TRUE);
    cs_ActionMoveToObject(1.0f, oBRBandit1, oWP_BRBDest2, TRUE);

    cs_ActionMoveToObject(2.0f, oBRBandit1, oTalker, FALSE, 0.5f);
    cs_SpeakString(2.0, oBRBandit1, sLine01, TALKVOLUME_SHOUT);

    cs_ActionStartConversation(4.0, oStandin, oTalker);

}
