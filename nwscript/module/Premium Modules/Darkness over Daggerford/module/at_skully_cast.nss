// edalseye pretends to cast a teleportation spell

void main()
{
    object oPC = GetPCSpeaker();
    object oEdalseye = GetNearestObjectByTag("ks_edalseye", oPC);

    AssignCommand(oEdalseye, ActionPauseConversation());
    AssignCommand(oEdalseye, PlaySound("vs_chant_conj_hm"));
    AssignCommand(oEdalseye, ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0, 3.0));
    AssignCommand(oEdalseye, ActionResumeConversation());
}

