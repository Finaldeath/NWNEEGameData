// Yvonne giving Teddy the ring cinema

void main()
{
    object oYvonne = OBJECT_SELF;

    // If Teddy is dead then don't play the cinema
    object oTeddy = GetObjectByTag("DDF_NPC_Teddy");

    if (GetIsObjectValid(oTeddy) == FALSE)
    {
        return;
    }

    // If Teddy already has the ring then don't play the cinema
    object oRing = GetItemPossessedBy(oTeddy, "RING_TEDDY");

    if(GetIsObjectValid(oRing) == TRUE)
    {
        return;
    }

    object oPC = GetPCSpeaker();

    // Disable player control
    SetCutsceneMode(oPC, TRUE);

    // Teleport Teddy
    object oTeddySpawnWaypoint = GetWaypointByTag("CORANO_TEDDY_SPAWN");
    location locTSWP = GetLocation( oTeddySpawnWaypoint );
    AssignCommand(oTeddy, ActionJumpToLocation(locTSWP));

    // Move to Yvonne
    object oTeddyTalkWaypoint = GetWaypointByTag("CORANO_YVNE_TEDD_CIN");
    DelayCommand(1.0f, AssignCommand(oTeddy, ActionMoveToObject(oTeddyTalkWaypoint)));

    // Play Dialog
    DelayCommand(5.f, AssignCommand(oYvonne, SpeakString("Oh... it's you. This is a terrible time.")));
    DelayCommand(9.f, AssignCommand(oTeddy, SpeakString("Is it? It's always a good time to see you, Yvonne.")));
    DelayCommand(13.f, AssignCommand(oYvonne, SpeakString("Oh, you daft git. Do you not see the blood? The lines on me face? The tears? I swear, the way you see the world will be the death of you.")));
    DelayCommand(17.f, AssignCommand(oTeddy, SpeakString("By the gods, what happened?")));

    // Yvonne still has the ring (give it to Teddy)
    oRing = GetItemPossessedBy(oYvonne, "RING_TEDDY");
    if(GetIsObjectValid(oRing) == TRUE)
    {
        DelayCommand(21.f, AssignCommand(oYvonne, SpeakString("The family was killed last night is what. Here, I got this package together for your mistress, Aladara. Take it and go, you looney halfling.")));
        DelayCommand(21.f, AssignCommand(oYvonne, ActionGiveItem(oRing, oTeddy)));
        DelayCommand(21.f, SetLocalInt(GetModule(), "ddf_tedd_has_ring", TRUE));
        DelayCommand(25.f, AssignCommand(oTeddy, SpeakString("Oh... Yvonne... I'm so sor--")));
        DelayCommand(29.f, AssignCommand(oYvonne, SpeakString("Don't you say it. Just run along back to that woman you adore so much. Spiritual advisor... fluff and nonsense... go!")));
    }
    else
    {
        DelayCommand(21.f, AssignCommand(oYvonne, SpeakString("The family was killed last night is what. Here, I got this package together for your mistress, Aladara... Where... where is it? I had it on me...")));
        DelayCommand(25.f, AssignCommand(oTeddy, SpeakString("Maybe it's in the study?")));
        DelayCommand(29.f, AssignCommand(oYvonne, SpeakString("I know what I had, you blasted halfling. I had it right here! Go tell your mistress she'll have it another day. I... I've enough to deal with.")));
    }

    // Set the flag that they met
    SetLocalInt(GetModule(), "ddf_yvon_tedd_met", TRUE);

    // Teddy exit object
    object oFrontDoor = GetObjectByTag("CoranoVillaExit");
    object oLimbo = GetObjectByTag("NW_LIMBO_TEDDY");

    // Leave the room back to the teleport spot
    //DelayCommand(34.0f, AssignCommand(oTeddy, ActionMoveToObject(oTeddySpawnWaypoint)));
    DelayCommand(34.0f, AssignCommand(oTeddy, ActionMoveToObject(oFrontDoor)));
    //DelayCommand(34.5f, AssignCommand(oTeddy, ActionJumpToObject(oLimbo)));
    //DelayCommand(38.0, AssignCommand(oTeddy, JumpToObject(oLimbo, FALSE)));

    // Enable player control
    DelayCommand(38.0, SetCutsceneMode(oPC, FALSE));
}
