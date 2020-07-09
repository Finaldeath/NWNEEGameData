// this is the throne room cutscene which ends the game

#include "hf_in_cutscene"
#include "hf_in_util"

// removes all effects from the player
// .. the player is visible at this point in the cutscene
void RemoveEffects(object oPC)
{
    effect eEffect = GetFirstEffect(oPC);
    while (GetIsEffectValid(eEffect))
    {
        RemoveEffect(oPC, eEffect);
        eEffect = GetNextEffect(oPC);
    }
}

// returns the first name of a PC
string GetFirstName(object oPC)
{
    string sName = GetName(oPC);
    int nPos = FindSubString(sName, " ");
    if (nPos > 0)
    {
        sName = GetStringLeft(sName, nPos);
    }
    return (sName);
}

// returns "he" or "she" based on an object's gender
// .. first letter is capitalized if nCaps is true
string GetHeShe(object oPC, int nCaps=FALSE)
{
    string s;
    if (GetGender(oPC) == GENDER_FEMALE)
    {
        if (nCaps)
            s = "She";
        else
            s = "she";
    }
    else
    {
        if (nCaps)
            s = "He";
        else
            s = "he";
    }
    return(s);
}

// returns a random NPC tag ... used to create a random looking crowd
string GetRandCrowdTag()
{
    string s;
    int n = d12();
    if      (n == 1)  s = "pm_noble1";
    else if (n == 2)  s = "pm_noble2";
    else if (n == 3)  s = "pm_noble3";
    else if (n == 4)  s = "pm_noble4";
    else if (n == 5)  s = "pm_commoner";
    else if (n == 6)  s = "pm_commoner2";
    else if (n == 7)  s = "pm_commoner3";
    else if (n == 8)  s = "pm_commoner4";
    else if (n == 9)  s = "pm_sailor1";
    else if (n == 10) s = "pm_sailor2";
    else if (n == 11) s = "pm_sailor3";
    else if (n == 12) s = "pm_sailor4";
    return(s);
}

// spawn random NPCs facing a certain object
void SpawnCrowd(object oFace, string sWP)
{
    object oArea = GetArea(oFace);
    object oWP = GetWaypointByTag(sWP);
    vector vWP = GetPosition(oWP);
    vector vFace = GetPosition(oFace);
    float fdy = 0.5;
    float fdx = 0.5;
    int i;
    int j;
    for(i=1; i<=5; i++)
    {
        for (j=1; j<= 5; j++)
        {
            vector vNew = Vector(vWP.x+fdx*i, vWP.y+fdy*j, vWP.z);
            location lLoc = Location(oArea, vNew, 0.0);
            object o = CreateObject(OBJECT_TYPE_CREATURE, GetRandCrowdTag(), lLoc, FALSE, "_ar0401_crowd");
            SetLocalInt(o, "HF_DISABLE_AM", 1);
            AssignCommand(o, SetFacingPoint(vFace));
        }
    }
}

// the crowd all turns to face a certain object
void CrowdFace(object oPC)
{
    vector vPC = GetPosition(oPC);
    int i = 0;
    object o = GetObjectByTag("_ar0401_crowd", i);
    while (GetIsObjectValid(o))
    {
        AssignCommand(o, SetFacingPoint(vPC));
        o = GetObjectByTag("_ar0401_crowd", ++i);
    }
}

// the crowd cheers
void CrowdCheer(object oPC)
{
    int i = 0;
    object o = GetObjectByTag("_ar0401_crowd", i);
    while (GetIsObjectValid(o))
    {
        float fDelay = 0.1*d10();
        int n = d4();
        int n2 = d4();
        if (n2 == 1)
        {
            DelayCommand(fDelay, AssignCommand(o, PlaySound("as_pl_comyaygrp"+IntToString(n))));
        }
        else if (n2 == 2)
        {
            DelayCommand(fDelay, AssignCommand(o, PlaySound("as_pl_nobyaygrp"+IntToString(n))));
        }
        else if (n2 == 3)
        {
            DelayCommand(fDelay, AssignCommand(o, PlaySound("as_pl_tavclap"+IntToString(n/2))));
        }

        int nAction;
        if      (n == 1) nAction = ANIMATION_FIREFORGET_GREETING;
        else if (n == 2) nAction = ANIMATION_FIREFORGET_VICTORY1;
        else if (n == 3) nAction = ANIMATION_FIREFORGET_VICTORY2;
        else if (n == 4) nAction = ANIMATION_FIREFORGET_VICTORY3;
        DelayCommand(fDelay, AssignCommand(o, ActionPlayAnimation(nAction)));

        o = GetObjectByTag("_ar0401_crowd", ++i);
    }
}

void SpawnNPCs(object oPC)
{
    object oWP;
    object o;

    // spawn duke
    oWP = GetWaypointByTag("WP_cs_Baron");
    o = CreateObject(OBJECT_TYPE_CREATURE, "ks_duke", GetLocation(oWP));
    CutsceneAddActor("ks_duke", o);

    // spawn captain frederick
    oWP = GetWaypointByTag("WP_cs_Malitia5b");
    o = CreateObject(OBJECT_TYPE_CREATURE, "pm_captain_frede", GetLocation(oWP));
    CutsceneAddActor("pm_captain_frede", o);

    // spawn lady bronwyn
    oWP = GetWaypointByTag("WP_cs_Malitia6b");
    o = CreateObject(OBJECT_TYPE_CREATURE, "ks_bronwyn", GetLocation(oWP));
    AssignCommand(o, SetFacing(DIRECTION_WEST));
    CutsceneAddActor("ks_bronwyn", o);

    // spawn derval
    oWP = GetWaypointByTag("WP_AR0401_CUT1_DERVAL");
    o = CreateObject(OBJECT_TYPE_CREATURE, "db_dervil", GetLocation(oWP));
    object oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, o);
    if (GetIsObjectValid(oItem))
    {
        AssignCommand(o, ActionUnequipItem(oItem));
    }
    SetLocalInt(o, "HF_DISABLE_AM", 1);
    CutsceneAddActor("db_dervil", o);

    // spawn falias
    oWP = GetWaypointByTag("WP_AR0401_CUT1_FALIAS");
    o = CreateObject(OBJECT_TYPE_CREATURE, "pm_falias2", GetLocation(oWP));
    DeleteLocalInt(o, "NW_GENERIC_MASTER");
    CutsceneAddActor("pm_falias2", o);

    // spawn astriel
    oWP = GetWaypointByTag("WP_AR0401_CUT1_ASTRIEL");
    o = CreateObject(OBJECT_TYPE_CREATURE, "pm_astriel2", GetLocation(oWP));
    CutsceneAddActor("pm_astriel2", o);

    // spawn 2 militia grunts
    oWP = GetWaypointByTag("WP_AR0401_CUT1_MILITIA1");
    CreateObject(OBJECT_TYPE_CREATURE, "pm_malitia", GetLocation(oWP));
    oWP = GetWaypointByTag("WP_AR0401_CUT1_MILITIA2");
    CreateObject(OBJECT_TYPE_CREATURE, "pm_malitia", GetLocation(oWP));

    // spawn talarenne if the player released her; else astriel
    if (GetIsObjectValid(GetItemPossessedBy(oPC, "db_buddyinaglobe")))
    {
        oWP = GetWaypointByTag("WP_AR0401_CUT1_TALKER1");
        o = CreateObject(OBJECT_TYPE_CREATURE, "ks_talarenne", GetLocation(oWP));
        CutsceneAddActor("ks_talarenne", o);
    }
    else
    {
        oWP = GetWaypointByTag("WP_AR0401_CUT1_TALKER1");
        o = CreateObject(OBJECT_TYPE_CREATURE, "pm_astriel2", GetLocation(oWP));
        CutsceneAddActor("pm_astriel", o);
    }

    // spawn hevesar
    oWP = GetWaypointByTag("WP_AR0401_CUT1_TALKER2");
    o = CreateObject(OBJECT_TYPE_CREATURE, "pm_hevesar", GetLocation(oWP));
    DeleteLocalInt(o, "NW_GENERIC_MASTER");
    CutsceneAddActor("pm_hevesar", o);
}

// destroy all creatures with a certain tag in this area
void DestroyCreature(string sTag, object oPC)
{
    object oArea = GetArea(oPC);
    int i = 0;
    object oCreature = GetObjectByTag(sTag, i);
    while (GetIsObjectValid(oCreature))
    {
        if (GetArea(oCreature) == oArea)
        {
            DestroyObject(oCreature);
        }
        oCreature = GetObjectByTag(sTag, ++i);
    }
}

// destroys all creatures hostile to player in this area
void DestroyHostileCreatures(object oPC)
{
    int i = 1;
    object oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, i);
    while (GetIsObjectValid(oCreature))
    {
        DestroyObject(oCreature);
        oCreature = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, oPC, ++i);
    }

    // the above should have destroyed some of these creatures, but do it again
    DestroyCreature("ks_tanarukk", oPC);
    DestroyCreature("ks_malitia_1", oPC);
    DestroyCreature("ks_malitia_2", oPC);
    DestroyCreature("ks_malitia_3", oPC);
    DestroyCreature("ks_malitia_4", oPC);
    DestroyCreature("ks_malitia_5", oPC);
}

// the player puts away weapons (or torches) for this scene
void Unequip(object oPC)
{
    object oItem;
    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    if (GetIsObjectValid(oItem))
    {
        AssignCommand(oPC, ActionUnequipItem(oItem));
    }
    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    if (GetIsObjectValid(oItem))
    {
        AssignCommand(oPC, ActionUnequipItem(oItem));
    }
}

// stop playing background music in this area
void StopMusic(object oArea)
{
    object oMusic1 = GetObjectByTag("ks_snd_throne1");
    SoundObjectStop(oMusic1);
    object oMusic2 = GetObjectByTag("ks_snd_throne2");
    SoundObjectStop(oMusic2);
    object oMusic3 = GetObjectByTag("ks_snd_throne3");
    SoundObjectStop(oMusic3);
    MusicBackgroundStop(oArea);
    MusicBattleStop(oArea);
    AmbientSoundStop(oArea);
}

void start()
{
    object oPC = GetFirstPC();
    StopMusic(GetArea(oPC));
    DestroyHostileCreatures(oPC);
    SpawnNPCs(oPC);
    CutsceneStart(TRUE, FALSE);
    SetCutsceneCameraMoveRate(oPC, 0.75);
}

void next0(float fTime)
{
    object oPC = GetFirstPC();
    object oDerval = CutsceneGetActor("db_dervil");
    object oFalias = CutsceneGetActor("pm_falias2");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        object oMusic = GetObjectByTag("ks_snd_throne1");
        SoundObjectPlay(oMusic);
        Unequip(oPC);                // put away your weapons
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        SetCameraHeight(oPC, 2.0);
        FadeFromBlack(oPC, FADE_SPEED_FAST);
        CutsceneMoveTo("WP_AR0401_CUT1_CAMERA3");
        AssignCommand(oPC, SetCameraFacing(DIRECTION_WEST, 1.0, 80.0, CAMERA_TRANSITION_TYPE_SNAP));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        AssignCommand(oFalias, ActionSpeakString(q+"You know, Derval, I knew "+GetFirstName(oPC)+" before "+GetHeShe(oPC)+" was famous!"+q));
        AssignCommand(oFalias, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        AssignCommand(oFalias, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.0, 10.0));
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        AssignCommand(oDerval, ActionSpeakString(q+"Aye, Falias, a true hero, "+GetHeShe(oPC)+" be!"+q));
        CutsceneNext(15.0);
    }
    else if (fTime == 15.0)
    {
        DestroyObject(oFalias, 3.0);
        DestroyObject(oDerval, 3.0);
        CutsceneNextShot();
    }
}

// cover-up spawns while talarenne and hevesar are talking
void next1(float fTime)
{
    object oPC = GetFirstPC();
    object oTalarenne = CutsceneGetActor("ks_talarenne");
    object oAstriel = CutsceneGetActor("pm_astriel");
    object oHevesar = CutsceneGetActor("pm_hevesar");
    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        object oWP = GetWaypointByTag("WP_AR0401_CUT1_START");
        SpawnCrowd(oWP, "WP_AR0401_CUT1_CROWD1");
        SpawnCrowd(oWP, "WP_AR0401_CUT1_CROWD2");
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        FadeFromBlack(oPC, FADE_SPEED_FAST);
        CutsceneMoveTo("WP_AR0401_CUT1_CAMERA1");
        if (GetIsObjectValid(oTalarenne))
        {
            AssignCommand(oTalarenne, ActionSpeakString(q+"Look, Hevesar, " + GetFirstName(oPC) + " has finally arrived!"+q));
        }
        else
        {
            AssignCommand(oAstriel, ActionSpeakString(q+"Look, Hevesar, " + GetFirstName(oPC) + " has arrived!"+q));
        }
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        if (GetIsObjectValid(oTalarenne))
        {
            AssignCommand(oHevesar, ActionSpeakString(q+"Them, and half of Waterdeep by the looks of things, Talarenne!"+q));
        }
        else
        {
            AssignCommand(oHevesar, ActionSpeakString(q+"Them, and half of Waterdeep by the looks of things, Astriel!"+q));
        }
        CutsceneNext(13.0);
    }
    else if (fTime == 13.0)
    {
        AssignCommand(oTalarenne, ActionSpeakString(q+"Hush! The ceremony is about to begin!"+q));
        CutsceneNext(18.0);
    }
    else if (fTime == 18.0)
    {
        FadeToBlack(oPC);
        CutsceneNext(20.0);
    }
    else if (fTime == 20.0)
    {
        DestroyObject(oTalarenne, 1.0);
        DestroyObject(oAstriel, 1.0);
        DestroyObject(oHevesar, 1.0);
        CutsceneMoveTo("WP_AR0401_CUT1_CAMERA2");
        CutsceneNextShot();
    }
}

// walk down the aisle towards the duke
void next2(float fTime)
{
    object oPC = GetFirstPC();
    object oDuke = CutsceneGetActor("ks_duke");

    if (fTime == 0.0)
    {
        // the crowd should already be facing the player
        FadeFromBlack(oPC);
        RemoveAssociateEffects(oPC); // hack to remove invis on PC
        RemoveEffects(oPC);          // remove things like stoneskin
        //Unequip(oPC);                // put away your weapons
        SetCameraHeight(oPC, 0.0);
        AssignCommand(oPC, SetCameraFacing(DIRECTION_EAST, 3.0, 65.0, CAMERA_TRANSITION_TYPE_SNAP));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        // first music track is 39 seconds with the trumpets
        // bursting from 34 to 39 seconds; we start the second
        // looping tack after 38 seconds (which is here)
        object oMusic = GetObjectByTag("ks_snd_throne2");
        SoundObjectPlay(oMusic);
        CutsceneNext(4.0);
    }
    else if (fTime == 4.0)
    {
        AssignCommand(oPC, ActionMoveToObject(oDuke));
        AssignCommand(oPC, ActionDoCommand(CutsceneNextShot()));
        CutsceneNext(4.1);
    }
    else if (fTime == 4.1)
    {
        object oGuard1 = GetObjectInArea("pm_malitia", oPC, 1);
        object oGuard2 = GetObjectInArea("pm_malitia", oPC, 2);
        AssignCommand(oGuard1, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oGuard1, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
        AssignCommand(oGuard2, SetFacingPoint(GetPosition(oPC)));
        AssignCommand(oGuard2, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
        // next shot fired by PC's action queue
    }
}

// the duke speaks to you
void next3(float fTime)
{
    object oPC = GetFirstPC();
    object oDuke = CutsceneGetActor("ks_duke");

    if (fTime == 0.0)
    {
        CrowdFace(oPC);
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
        CutsceneNext(2.0);
    }
    if (fTime == 2.0)
    {
        AssignCommand(oDuke, ActionStartConversation(oPC, "ks_ar0401_duke", FALSE, FALSE));
        // the next event is fired from a script in the dialog
    }
}

// turn and face the cheering crowd
void next4(float fTime)
{
    object oPC = GetFirstPC();
    object oAstriel = CutsceneGetActor("pm_astriel2");

    string q = GetLocalString(GetModule(), "QUOTE");

    if (fTime == 0.0)
    {
        object oMusic = GetObjectByTag("ks_snd_throne2");
        SoundObjectStop(oMusic);
        oMusic = GetObjectByTag("ks_snd_throne3");
        SoundObjectPlay(oMusic);
        AssignCommand(oPC, SetFacing(DIRECTION_WEST));
        CutsceneNext(2.0);
    }
    else if (fTime == 2.0)
    {
        CrowdCheer(oPC);
        AssignCommand(oPC, SetCameraFacing(DIRECTION_WEST, 9.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        CutsceneNext(5.0);
    }
    else if (fTime == 5.0)
    {
        CrowdCheer(oPC);
        CutsceneNext(8.0);
    }
    else if (fTime == 8.0)
    {
        CrowdCheer(oPC);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oPC, 6.0);
        CutsceneCameraCloseup(oAstriel);
        AssignCommand(oPC, SetCameraFacing(DIRECTION_WEST, -1.0, -1.0, CAMERA_TRANSITION_TYPE_SNAP));
        AssignCommand(oAstriel, ActionSpeakString(q+"Thank you, "+GetFirstName(oPC)+"!"+q));
        AssignCommand(oAstriel, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        CutsceneNext(12.0);
    }
    else if (fTime == 12.0)
    {
        CrowdCheer(oPC);
        CutsceneNextShot();
    }
}

void next5(float fTime)
{
    object oAstriel = CutsceneGetActor("pm_astriel2");
    object oDuke = CutsceneGetActor("ks_duke");
    object oPC = GetFirstPC();

    if (fTime == 0.0)
    {
        RemoveAssociateEffects(oPC); // hack to remove invis
        CutsceneMoveTo("WP_AR0401_CUT1_CAMERA4");
        AssignCommand(oAstriel, SetFacingPoint(GetPosition(oDuke)));
        AssignCommand(oPC, SetCameraFacing(DIRECTION_WEST, 9.0, 60.0, CAMERA_TRANSITION_TYPE_SNAP));
        AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING));
        CutsceneNext(3.0);
    }
    else if (fTime == 3.0)
    {
        object oWP = GetWaypointByTag("WP_AR0401_CUT1_THEEND");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ks_theend", GetLocation(oWP));
        CrowdCheer(oPC);
        CutsceneNext(10.0);
    }
    else if (fTime == 10.0)
    {
        FadeToBlack(oPC, FADE_SPEED_SLOWEST);
        CutsceneNext(14.0);
    }
    else if (fTime == 14.0)
    {
        CutsceneEnd();
    }
}

// make all DoD undroppable items droppable and save the player's character
void ExportCharacter(object oPC)
{
    object oItem = GetItemPossessedBy(oPC, "bw_inv_map");
    if (GetIsObjectValid(oItem))
    {
        SetDroppableFlag(oItem, TRUE);
    }

    oItem = GetItemPossessedBy(oPC, "db_farmlandsevidence");
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    oItem = GetItemPossessedBy(oPC, "db_kitchensevidence");
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    oItem = GetItemPossessedBy(oPC, "db_dropoffevidence");
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    oItem = GetItemPossessedBy(oPC, "db_stockade_key");
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
    {
        if(GetTag(oItem) == "db_harperpin")
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPC);
    }

    oItem = GetItemPossessedBy(oPC, "db_itnote2");
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    oItem = GetItemPossessedBy(oPC, "rb_assaultnote");
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    oItem = GetItemPossessedBy(oPC, "a2_inforcnote");
    if (GetIsObjectValid(oItem))
    {
        DestroyObject(oItem);
    }

    object oSphere = GetItemPossessedBy(oPC, "db_buddyinaglobe");
    if (GetIsObjectValid(oSphere))
    {
        DestroyObject(oSphere);
    }

    DestroyObject(GetItemPossessedBy(oPC, "rb_maerheart"));
    DestroyObject(GetItemPossessedBy(oPC, "rb_boarheart"));

    ExportSingleCharacter(oPC);
}

// display the daggerford credits
void end()
{
    object oPC = GetFirstPC();
    ExportCharacter(oPC);
    DelayCommand(0.1, EndGame("daggerford_cred"));
}

void main()
{
    int nShot = CutsceneGetShot();
    float fTime = CutsceneGetTime();
    int nEvent = CutsceneGetEvent();

    if (nEvent == CUTSCENE_EVENT_START)
    {
        start();
        CutsceneNext(0.0);
    }
    else if (nEvent == CUTSCENE_EVENT_SHOT ||
             nEvent == CUTSCENE_EVENT_NEXT)
    {
        if (nShot == 0) next0(fTime);
        if (nShot == 1) next1(fTime);
        if (nShot == 2) next2(fTime);
        if (nShot == 3) next3(fTime);
        if (nShot == 4) next4(fTime);
        if (nShot == 5) next5(fTime);
    }
    else if (nEvent == CUTSCENE_EVENT_END)
    {
        end();
    }
    else if (nEvent == CUTSCENE_EVENT_ABORT)
    {
        CutsceneEnd();
    }
    else
    {
        SendMessageToPC(GetFirstPC(), "bad event?");
    }
}
