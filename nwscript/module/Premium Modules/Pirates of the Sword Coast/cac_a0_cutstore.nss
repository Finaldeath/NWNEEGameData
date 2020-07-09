//::///////////////////////////////////////////////
//:: cac_a0_cutstore
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    End the intro dialog cutscene with allendry,
    then launch the store.
*/
//:://////////////////////////////////////////////
//:: Created By: Rob Bartel
//:: Created On: April 21, 2005
//:://////////////////////////////////////////////
#include "_inc_cutscene"
#include "nw_i0_plot"

void EndCutscene();
void AllendryStore(object oPC);

void main()
{
    object oSelf = OBJECT_SELF;
    object oArea = GetArea(oSelf);
    int iDoOnce = GetLocalInt(oArea, "cac_a0_pscintroc");
    object oPC = GetPCSpeaker();

    if (iDoOnce == FALSE)
    {
        SetLocalInt(oArea, "cac_a0_pscintroc", TRUE);
        AssignCommand(oArea, EndCutscene());
        AssignCommand(oPC, DelayCommand(4.5, AllendryStore(oPC)));
    }
}

void EndCutscene()
{
    cs_CameraDoFade(0.875f, CS_FADE_TYPE_TO_BLACK, FADE_SPEED_FAST);

    // JE: Destroy PC copies manually, slightly before the cutscene ends.
    // This will prevent the player from seeing their copy fade out.
    object oPCCopy = GetObjectByTagInArea("pccopy", OBJECT_SELF, 0);
    int i=0;
    while(GetIsObjectValid(oPCCopy))
    {
        cs_DestroyObject(1.2, oPCCopy);
        i++;
        oPCCopy = GetObjectByTagInArea("pccopy", OBJECT_SELF, i);
    }

    cs_EndCutscene(2.9f, FALSE, TRUE);
}

void AllendryStore(object oPC)
{
    object oStore = GetObjectByTag("a0_shp_allendry");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        //Good Prices
        gplotAppraiseOpenStore(oStore, oPC, 0, 0);
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
