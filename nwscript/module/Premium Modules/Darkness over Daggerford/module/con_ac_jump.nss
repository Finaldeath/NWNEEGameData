//::///////////////////////////////////////////////
//:: FileName con_ac_jump
//:: Xianga and Beb-Shuur jump off the cliff
//:://////////////////////////////////////////////
//:: Created By: Anya Clancy
//:: Created On: June 18, 2006
//:://////////////////////////////////////////////

effect eDis = EffectDisappear(1);
effect eAppear = EffectAppear(1);
effect eInvis = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY);
effect eGhost = EffectCutsceneGhost();
object oPC = GetPCSpeaker();

void MyDestroyObject(string sTag2)
{
    DestroyObject(GetObjectByTag(sTag2),0.0);
}

void ahcJump(object oTarget)
{
    AssignCommand(oTarget, ActionDoCommand(SetFacing(180.0)));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDis,oTarget);
    DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eInvis,oTarget));
}

void main()
{
    object oB = OBJECT_SELF;
    object oX = GetObjectByTag("ac_xianga");

    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eGhost,oX);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eGhost,oB);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, 2, FALSE);
    AssignCommand(oX, ActionMoveToObject(GetObjectByTag("WP_AR2000_JUMP_XIANGA"), TRUE, 0.0));
    DelayCommand(0.2,AssignCommand(oX, ActionDoCommand(ahcJump(oX))));

    AssignCommand(oB, ActionMoveToObject(GetObjectByTag("WP_AR2000_JUMP_BEBSHUUR"), TRUE, 0.0));
    DelayCommand(0.2, AssignCommand(oB, ActionDoCommand(ahcJump(oB))));
    DelayCommand(1.7,AssignCommand(oPC,PlaySound("as_pl_screamm1")));
    DelayCommand(2.2,AssignCommand(oPC,PlaySound("as_pl_screamm3")));
    DelayCommand(3.0,AssignCommand(oPC,PlaySound("bf_small")));
    DelayCommand(3.2,AssignCommand(oPC,PlaySound("bf_small")));
}
