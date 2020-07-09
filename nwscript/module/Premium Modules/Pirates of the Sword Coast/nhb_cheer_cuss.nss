//::///////////////////////////////////////////////
//:: nhb_cheer_cuss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This NPC Heart Beat script will cause the owners
    (Angry trogoldytes) to animate and shake their
    fists.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith K2 Hayward
//:: Created On: August 2004
//:://////////////////////////////////////////////

void main()
{
    object oSelf = OBJECT_SELF;
    int iOrder = Random(5);

    // Do a set of animations based off a random value.
    if (iOrder == 1)
    {
        DelayCommand(0.2f, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.1f, 2.3f));
        DelayCommand(3.0f, PlaySound("c_lizardm_bat1"));
        DelayCommand(3.0f, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 0.9f, 1.0f));
        DelayCommand(4.2f, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.2f, 2.0f));
        DelayCommand(6.5f, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 1.4f, 1.2f));
    }
    else if (iOrder == 2)
    {
        DelayCommand(0.5f, PlaySound("c_lizardm_bat2"));
        DelayCommand(0.5f, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0f, 2.3f));
        DelayCommand(3.2f, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.4f, 2.0f));
        DelayCommand(5.5f, ActionPlayAnimation(ANIMATION_FIREFORGET_SPASM, 0.8f, 1.0f));
        DelayCommand(6.7f, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.1f, 2.2f));
    }
    else if (iOrder == 3)
    {
        DelayCommand(0.2f, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.1f, 4.3f));
        DelayCommand(5.0f, PlaySound("c_lizardmc_bat1"));
        DelayCommand(5.0f, ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.2f, 3.0f));
    }
    else if (iOrder == 4)
    {
        DelayCommand(0.2f, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0f, 1.3f));
        DelayCommand(2.0f, PlaySound("c_lizardmw_bat1"));
        DelayCommand(2.0f, ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.4f, 6.0f));
    }
    else
    {
        DelayCommand(0.2f, ActionPlayAnimation(ANIMATION_LOOPING_LISTEN, 0.7f, 7.2f));
    }
}
