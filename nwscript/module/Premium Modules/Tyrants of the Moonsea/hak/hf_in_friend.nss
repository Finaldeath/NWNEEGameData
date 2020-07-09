// friends help the player in combat and cannot die

#include "hf_in_henchman"
#include "hf_in_npc"

// returns true if the friend is dead
int FriendIsDead(object oFriend)
{
    return GetLocalInt(oFriend, "HF_FRIEND_DEAD");
}

// returns the player master, or invalid object if none
object FriendGetMaster(object oFriend)
{
    return GetLocalObject(oFriend, "HF_FRIEND_MASTER");
}

// make friends with the player; pass invalid object to clear this
void FriendSetMaster(object oPC, object oFriend)
{
    if (GetIsObjectValid(oPC))
    {
        SetLocalObject(oFriend, "HF_FRIEND_MASTER", oPC);
        SetIsTemporaryFriend(oPC, oFriend);

        // make sure friend is not invincible
        SetImmortal(oFriend, FALSE);
        SetPlotFlag(oFriend, FALSE);

        // spells like charm can cause faction issues
        effect eImmune = EffectImmunity(IMMUNITY_TYPE_MIND_SPELLS);
        TagEffect(eImmune, "HF_FRIEND");
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eImmune), oFriend);
    }
    else
    {
        DeleteLocalObject(oFriend, "HF_FRIEND_MASTER");
        SetIsTemporaryNeutral(oPC, oFriend);

        // remove the charm effect that we applied earlier
        effect eEffect = GetFirstEffect(oFriend);
        while (GetIsEffectValid(eEffect))
        {
            if (GetEffectTag(eEffect) == "HF_FRIEND")
            {
                RemoveEffect(oFriend, eEffect);
            }
            eEffect = GetNextEffect(oFriend);
        }
    }
}

// rest nearby friends when the player rests
void FriendRest(object oPC)
{
    int i = 1;
    object oNPC = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC, i);
    while (GetIsObjectValid(oNPC))
    {
        object oMaster = FriendGetMaster(oNPC);
        if (GetIsObjectValid(oMaster))
        {
            if (oMaster == oPC)
            {
                ForceRest(oNPC);
            }
        }
        oNPC = GetNearestCreature(CREATURE_TYPE_IS_ALIVE, TRUE, oPC, ++i);
    }
}

// get up after dying
void FriendRaise(object oFriend)
{
    // raise from dead
    SetCommandable(TRUE, oFriend);
    AssignCommand(oFriend, ClearAllActions());
    AssignCommand(oFriend, PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0, 6.0));
    SetPlotFlag(oFriend, FALSE);
    DeleteLocalInt(oFriend, "HF_FRIEND_DEAD");
    SetAssociateState(NW_ASC_MODE_DYING, FALSE, oFriend);

    // make sure we have at least 5 hit points when we get up
    if (GetCurrentHitPoints(oFriend) < 5)
    {
        int nHits = GetCurrentHitPoints(oFriend);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(5-nHits), oFriend);
    }

    // make sure we still trust our master
    object oMaster = FriendGetMaster(oFriend);
    if (GetIsObjectValid(oMaster))
    {
        // it is possible that faction reputation has been affected between
        // dying and raising
        ResetFactionReputation(oMaster, oMaster);
        SetIsTemporaryFriend(oMaster, oFriend);
    }
}

// clear party members feelings towards friend on death, and vice versa.
// important to stop friends perpetually attacking party on raise, and also
// to allow them to be raised under the 'no enemy nearby' condition
void FriendRenewFriendship(object oPC, object oFriend)
{
    object oPartyMember;

    // reset the standard faction feelings towards the PC
    ResetFactionReputation(oPC, oPC);

    // clear personal reputations between the friend and all party members
    // as setting faction is not enough if party member has attacked friend
    oPartyMember = GetFirstFactionMember(oPC, FALSE);
    while (GetIsObjectValid(oPartyMember))
    {
        ClearPersonalReputation(oFriend, oPartyMember);
        ClearPersonalReputation(oPartyMember, oFriend);
        oPartyMember = GetNextFactionMember(oPC, FALSE);
    }

    // restore reputation between party and friend to 100
    SetIsTemporaryFriend(oPC, oFriend);
}

// call this whenever the friend dies
void FriendDeath(object oFriend)
{
    object oMaster = FriendGetMaster(oFriend);

    // remove invisibility and negative effects
    SetActionMode(oFriend, ACTION_MODE_STEALTH, FALSE);
    RemoveSpellEffects(SPELL_INVISIBILITY, oFriend, oFriend);
    RemoveSpellEffects(SPELL_IMPROVED_INVISIBILITY, oFriend, oFriend);
    RemoveSpellEffects(SPELL_SANCTUARY, oFriend, oFriend);
    RemoveSpellEffects(SPELL_ETHEREALNESS, oFriend, oFriend);
    HenchmanRemoveEffects(oFriend);

    // clear any ill feelings between friends and party members
    if(GetIsPC(oMaster))
    {
        FriendRenewFriendship(oMaster, oFriend);
    }

    // set dying mode on
    SetPlotFlag(oFriend, TRUE);
    AssignCommand(oFriend, SetIsDestroyable(FALSE, TRUE, TRUE));
    AssignCommand(oFriend, ClearAllActions(TRUE));
    SetLocalInt(oFriend, "HF_FRIEND_DEAD", 1);
    SetAssociateState(NW_ASC_MODE_DYING, TRUE, oFriend);

    // resurrect friend to 1 HP but pretend to be dead
    // change to a neutral faction so that hostiles stop attacking our corpse
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oFriend));
    DelayCommand(0.3, AssignCommand(oFriend, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 6500000000.0)));
    DelayCommand(0.4, SetCommandable(FALSE, oFriend));
}

