//::///////////////////////////////////////////////
//:: Act 3: Walk the Plank
//:: cac_a3_plank.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     The player tries to walk the plank.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 27, 2005
//:://////////////////////////////////////////////

//Ensure that puddles never get duplicated.
void CreatePuddle(location lPC);

void main()
{
    object oPC = GetPCSpeaker();
    location lPC = GetLocation(oPC);
    object oSplash = GetNearestObjectByTag("as_na_splash1");
    object oTelepIn = GetNearestObjectByTag("as_mg_telepin1");
    object oTelepOut = GetNearestObjectByTag("as_mg_telepout1");
    int iActivated = GetLocalInt(GetModule(), "bGangplankActivated");
    effect eKnockdown = EffectKnockdown();
    string sFailure = "The sea spits you back aboard the Rose.";

    //Fade to black.
    FadeToBlack(oPC);

    //Play splash sound.
    DelayCommand(2.0, SoundObjectPlay(oSplash));
    DelayCommand(3.0, SoundObjectStop(oSplash));

    //If they've recited the Rime of the Ancient Mariner...
    if (iActivated == TRUE)
    {

        //Play teleport IN sound.
        DelayCommand(4.0, SoundObjectPlay(oTelepIn));
        DelayCommand(5.0, SoundObjectStop(oTelepIn));

        //Launch Fiddler's Green cutscene (which forces all PCs into Fiddler's Green.)
        DelayCommand(5.0, ExecuteScript("exe_a3_fddlrgrn", oPC));

        //Fade from black.
        DelayCommand(5.1, FadeFromBlack(oPC));
    }
    //Else...
    else
    {
        //Play teleport OUT sound.
        DelayCommand(4.0, SoundObjectPlay(oTelepOut));
        DelayCommand(5.0, SoundObjectStop(oTelepOut));

        //Spawn in puddle at the player's location (never create more than one).
        DelayCommand(4.0, CreatePuddle(lPC));

        //Knock player down.
        DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockdown, oPC, 3.0f));

        //Fade from black.
        DelayCommand(5.5, FadeFromBlack(oPC));

        //Send floaty text feedback.
        DelayCommand(6.5, FloatingTextStringOnCreature(sFailure, oPC));
    }
}

void CreatePuddle(location lPC)
{
    object oPuddle = GetObjectByTag("a3_plankpuddle");
    if (GetIsObjectValid(oPuddle) == TRUE)
    {
        DestroyObject(oPuddle);
    }
    CreateObject(OBJECT_TYPE_PLACEABLE, "a3_plankpuddle", lPC);
}
