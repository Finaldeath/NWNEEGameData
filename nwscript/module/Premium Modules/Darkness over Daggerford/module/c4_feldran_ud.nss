#include "nw_i0_generic"
#include "x0_i0_partywide"
#include "hf_in_plot"
#include "hf_in_cutscene"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void Damaged()
{
    int nState = GetLocalInt(OBJECT_SELF, "nState");
    int nHP = GetCurrentHitPoints();
    if (nState == 0)
    {
        if (nHP <= GetMaxHitPoints()/2)
        {
            // pull out a poison dagger
            SetLocalInt(OBJECT_SELF, "nState", 1);
            object oSword = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
            //DestroyObject(oSword);
            object oKnife = GetItemPossessedBy(OBJECT_SELF, "ks_weapon_023");
            //CreateItemOnObject("ks_weapon_023");
            ActionEquipItem(oKnife, INVENTORY_SLOT_RIGHTHAND);
            SpeakString("Have you seen my knife? No? Take a close look, fool!");
        }
    }
    else if (nState == 1)
    {
        if (nHP <= GetMaxHitPoints()/5)
        {
            // surrender and run away
            PlotLevelSet("ks_feldran", 1);
            SetLocalInt(OBJECT_SELF, "nState", 2);
            object oPC = GetFirstPC();
            AddJournalQuestEntry("j85", 7, oPC);
            SetPlotFlag(OBJECT_SELF, TRUE);
            AdjustReputationWithFaction(oPC, OBJECT_SELF, 50);
            AdjustReputationWithFaction(OBJECT_SELF, oPC, 50);
            SurrenderToEnemies();
            ClearAllActions(TRUE);
            PlayVoiceChat(VOICE_CHAT_LAUGH);
            ActionSpeakString("Ha! You shall never defeat me! I shall return soon, little monkey!");
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 3.0);
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1);
            location lLoc = GetLocation(OBJECT_SELF);
            DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_AC_BONUS), OBJECT_SELF));
            DelayCommand(3.4, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_MAGIC_RESISTANCE_USE), OBJECT_SELF));
            DelayCommand(3.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), lLoc));
            DelayCommand(3.6, DestroyObject(OBJECT_SELF));
        }
    }
    else if (nState == 3)
    {
        if (nHP <= GetMaxHitPoints()/2)
        {
            // bring back the poison knife (when fighting player)
            SetLocalInt(OBJECT_SELF, "nState", 4);
            object oSword = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
            //DestroyObject(oSword);
            //object oKnife = CreateItemOnObject("ks_weapon_023");
            object oKnife = GetItemPossessedBy(OBJECT_SELF, "ks_weapon_023");
            ActionEquipItem(oKnife, INVENTORY_SLOT_RIGHTHAND);
            SpeakString("Do you remember my knife? Here ... take a closer look!");
        }
    }
    else if (nState == 4)
    {
        // cutscene: griswald kills me with a single blow
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
        CreateObject(OBJECT_TYPE_PLACEABLE, "am_floorblood3", GetLocation(OBJECT_SELF));
        CutsceneNextShot();
    }
}

void Heartbeat()
{
    if (GetIsInCombat() && !GetIsDead(OBJECT_SELF))
    {
        // random witty sayings during battle (every second heartbeat)
        if (GetLocalInt(OBJECT_SELF, "nComment") == 0)
        {
            SetLocalInt(OBJECT_SELF, "nComment", 1);
            string sName = GetName(GetFirstPC());
            string s;
            int n = Random(13)+1;
            if      (n == 1)  s = "Shame! Is that the best that you can do?";
            else if (n == 2)  s = "My blade is sharper than your mind!";
            else if (n == 3)  s = "Ha! My dead mother fought better than you!";
            else if (n == 4)  s = "Watch my fencing technique, and learn from a true master!";
            else if (n == 5)  s = "Come on! Try harder! This is hardly a challenge for me!";
            else if (n == 6)  s = "You shall have the honor of dying by my hand!";
            else if (n == 7)  s = "I shall pen a poem about this battle, called 'The Thrashing of "+sName+"'!";
            else if (n == 8)  s = "Shame! My court jester has better technique than you!";
            else if (n == 9)  s = "You fight like a sick child! Come on! Try harder!";
            else if (n == 10) s = "The bards shall sing of your folly tonight, fool!";
            else if (n == 11) s = "I drank from the fountain of wisdom, but you only gargled!";
            else if (n == 12) s = "You clearly suffer from delusions of adequacy!";
            else if (n == 13) s = "If you were any more stupid, I should have to water you twice each week!";
            SpeakString(s);
        }
        else
        {
            SetLocalInt(OBJECT_SELF, "nComment", 0);
        }
    }
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_DAMAGED)
    {
        Damaged();
    }
    else if (nUser == EVENT_HEARTBEAT)
    {
        Heartbeat();
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
        SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);
    }
}
