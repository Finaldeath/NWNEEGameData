// veiti activates the traps in the feast hall (this can only be done once)
// .. zhents inside the feast hall get damaged

#include "hf_in_plot"
#include "hf_in_util"

// count the number of traps that have axes installed
int CountTraps(object oPC)
{
    int n = 4;
    if (PlotLevelCheckEquals("ks_ar2501_statue1", 0)) n--;
    if (PlotLevelCheckEquals("ks_ar2501_statue2", 0)) n--;
    if (PlotLevelCheckEquals("ks_ar2501_statue3", 0)) n--;
    if (PlotLevelCheckEquals("ks_ar2501_statue4", 0)) n--;
    return(n);
}

// play the sound for each trap that is set
float PlayTrapSounds(object oPC)
{
    float fDelay = 1.0;

    if (!PlotLevelCheckEquals("ks_ar2501_statue1", 0))
    {
        object oStatue = GetObjectByTag("ks_ar2501_statue1");
        string sSound = GetLocalString(oStatue, "sSound");
        DelayCommand(fDelay, AssignCommand(oPC, PlaySound(sSound)));
        fDelay += 2.0;
    }
    if (!PlotLevelCheckEquals("ks_ar2501_statue2", 0))
    {
        object oStatue = GetObjectByTag("ks_ar2501_statue2");
        string sSound = GetLocalString(oStatue, "sSound");
        DelayCommand(fDelay, AssignCommand(oPC, PlaySound(sSound)));
        fDelay += 2.0;
    }
    if (!PlotLevelCheckEquals("ks_ar2501_statue3", 0))
    {
        object oStatue = GetObjectByTag("ks_ar2501_statue3");
        string sSound = GetLocalString(oStatue, "sSound");
        DelayCommand(fDelay, AssignCommand(oPC, PlaySound(sSound)));
        fDelay += 2.0;
    }
    if (!PlotLevelCheckEquals("ks_ar2501_statue4", 0))
    {
        object oStatue = GetObjectByTag("ks_ar2501_statue4");
        string sSound = GetLocalString(oStatue, "sSound");
        DelayCommand(fDelay, AssignCommand(oPC, PlaySound(sSound)));
        fDelay += 2.0;
    }

    return(fDelay);
}

// trigger the traps
void SetTraps(object oPC)
{
    location lLoc = GetLocation(oPC);
    object oMod = GetModule();

    // play some sound effects
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), lLoc);
    float fDelay = PlayTrapSounds(oPC);
    DelayCommand(fDelay, PlaySound("as_pl_battlegrp8"));

    // damage the zhents based on the number of traps
    int nDamaged = 0;
    int nTraps = CountTraps(oPC);
    int i = 1;
    object oZhent = GetNearestObjectByTag("_zhent_feaster", oPC, i);
    while (GetIsObjectValid(oZhent))
    {
        int nHits = GetCurrentHitPoints(oZhent);
        AssignCommand(oMod, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nHits/3), oZhent));
        if (nDamaged++ < (4+nTraps))
        {
            AssignCommand(oMod, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), oZhent));
        } else {
            AssignCommand(oMod, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(5*nTraps), oZhent));
        }
        oZhent = GetNearestObjectByTag("_zhent_feaster", oPC, ++i);
    }

    // create some vfx in the room
    i = 1;
    object oWP = GetNearestObjectByTag("WP_AR2501_TRAP_SOOT", oPC, i);
    while (GetIsObjectValid(oWP))
    {
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_weathmark", GetLocation(oWP));
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_dustplume", GetLocation(oWP));
        oWP = GetNearestObjectByTag("WP_AR2501_TRAP_SOOT", oPC, ++i);
    }
}

void main()
{
    object oDoor = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    object oVeiti = GetObjectInArea("db_veiti", oPC);
    AssignCommand(oVeiti, ClearAllActions());
    AssignCommand(oVeiti, ActionPauseConversation());
    AssignCommand(oVeiti, ActionMoveToObject(oDoor));
    AssignCommand(oVeiti, PlaySound("gui_picklockopen"));
    AssignCommand(oVeiti, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 3.0));
    AssignCommand(oVeiti, ActionDoCommand(SetTraps(oPC)));
    AssignCommand(oVeiti, ActionWait(5.0));
    AssignCommand(oVeiti, ActionResumeConversation());
    PlotLevelSet("ks_ar2501_feastdoor", 2);
}
