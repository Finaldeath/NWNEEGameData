#include "_inc_cutscene"

const string TASINA1 = "I've asked you nicely. Now give me the statue or face the consequences.";
const string ALLENDRY1 = "Slow down, lass. There be no need to make things worse than they already are.";
const string RAHMAN1 = "See? The captain, in his wisdom, knows I have the right of things. The statue is mine!";
const string ALLENDRY2 = "Mr. Madani!! Ye be a passenger aboard me ship and I order ye to hold yer tongue!";
const string TASINA2 = "Hold your tongue? Relinquish the statue, wizard, or I'll feed your tongue to the sharks!";
const string RAHMAN2 = "Ha! You have no power over Rahman Madani! My spells are more potent than your puny mind could ever imagine!";
const string TASINA3 = "The gods hold more power than any mortal and *that* is the power by which I command you!";
const string ALLENDRY3 = "Aye, what was that against the hull? Have we struck something?";

void main()
{
    object oPC = GetLocalObject(GetModule(), "MAGICPCOBJECT");
    object oWP_PCcam = GetWaypointByTag("WP_CAMERA");

    effect eVFXShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
    effect eKnockDown = EffectKnockdown();

    location lPCCopy = GetLocation(oPC);

    object oPCCopy = cs_CopyPC(lPCCopy);
    object oTasina = GetObjectByTag("a0rm_Tasina");
    object oRahman = GetObjectByTag("a0rm_Rahman");
    object oAllendry = GetObjectByTag("a0rm_Allendry");

    cs_CameraUseCameraWaypoint(0.5, 1);
    cs_CameraDoFade(1.0f, CS_FADE_TYPE_FROM_BLACK);

    cs_ActionPlayAnimation(1.2f, oTasina, ANIMATION_LOOPING_TALK_NORMAL,
        1.0f, 5.0f);

    cs_SetFacingPoint(3.0f, oTasina, GetPosition(oAllendry));
    cs_SpeakString(3.5f, oTasina, TASINA1);

    cs_SetFacingPoint(7.0f, oAllendry, GetPosition(oTasina));
    cs_SpeakString(7.2f, oAllendry, ALLENDRY1);
    cs_ActionPlayAnimation(7.2f, oAllendry, ANIMATION_LOOPING_TALK_PLEADING,
        1.0f, 3.0f);

    cs_SetFacingPoint(9.9f, oRahman, GetPosition(oAllendry));
    cs_SpeakString(10.1f, oRahman, RAHMAN1);
    cs_ActionPlayAnimation(10.1f, oRahman, ANIMATION_LOOPING_TALK_FORCEFUL,
        1.0f, 3.0f);

    cs_SetFacingPoint(13.9f, oAllendry, GetPosition(oRahman));
    cs_SpeakString(14.1f, oAllendry, ALLENDRY2);
    cs_ActionPlayAnimation(14.1f, oAllendry, ANIMATION_LOOPING_TALK_NORMAL,
        1.0f, 3.0f);

    cs_SetFacingPoint(17.9f, oTasina, GetPosition(oRahman));
    cs_SpeakString(18.1f, oTasina, TASINA2);
    cs_ActionPlayAnimation(18.1f, oTasina, ANIMATION_LOOPING_TALK_NORMAL,
        1.0f, 3.0f);

    cs_SetFacingPoint(21.0f, oRahman, GetPosition(oTasina));
    cs_SpeakString(21.2f, oRahman, RAHMAN2);
    cs_ActionPlayAnimation(21.2f, oRahman, ANIMATION_LOOPING_TALK_LAUGHING,
        1.0f, 3.0f);

    cs_SetFacingPoint(24.6f, oTasina, GetPosition(oRahman));
    cs_SpeakString(24.8f, oTasina, TASINA3);
    cs_ActionPlayAnimation(24.8f, oTasina, ANIMATION_LOOPING_TALK_FORCEFUL,
        1.0f, 3.0f);
    cs_SetFacingPoint(25.1f, oAllendry, GetPosition(oTasina));

    cs_ApplyEffectToObject(25.3f, DURATION_TYPE_INSTANT, eVFXShake, oAllendry);
    cs_ActionPlayAnimation(26.0f, oAllendry, ANIMATION_FIREFORGET_DODGE_SIDE, 0.5f);
    cs_ApplyEffectToObject(26.3f, DURATION_TYPE_TEMPORARY, eKnockDown, oRahman, 4.0f);

    cs_SpeakString(28.1f, oAllendry, ALLENDRY3);
    cs_ActionPlayAnimation(29.1f, oAllendry, ANIMATION_LOOPING_PAUSE_TIRED,
        1.0f, 3.0f);

    cs_CameraDoFade(31.0f, CS_FADE_TYPE_TO_BLACK);
    cs_EndCutscene(35.0f, FALSE);
}
