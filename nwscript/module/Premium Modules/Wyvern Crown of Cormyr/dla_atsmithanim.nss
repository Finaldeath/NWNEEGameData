/*
    DLA_ATSMITHANIM.nss
    crafting animation sequence and crafting handlers for Smith in Thunderstone

    October 2005
    B W-Husey
    This script creates the reforged items, and hands out xp, with effects etc.

    Modified by : gaoneng erick
    on : May 11, 2006

    this replaces the previous scripts to :
    add a little more spice to the animation sequence
    add player interaction if pc agreed to help
    prevent exploit
*/

#include "x2_inc_itemprop"
#include "cu_functions"
void gn_CraftWeapon(object pc)
{
    object self = OBJECT_SELF;

// get all locals
    int      nBonus = GetLocalInt(self, "nBonus");      // crafting bonus
    int       nCost = GetLocalInt(self, "nCost");       // cost in gp
    string    sItem = GetLocalString(self, "sItem");    // Type of item to make (resref)
    int     nShards = GetLocalInt(self, "nShards");     // Number of shards/blades to use in reforging
    string sSpecial = GetLocalString(self, "sSpecial"); // special ingredient selected (Tag)

// take gold and materials
    TakeGoldFromCreature(nCost, pc);
    object item = GetItemPossessedBy(pc, sSpecial);
    CopyItem(item, self, TRUE);
    DestroyObject(item);
    int i;
    item = GetFirstItemInInventory(pc);
    while (GetIsObjectValid(item))
    {
        if (GetStringLeft(GetTag(item), 5) == "Shard")
        {
            CopyItem(item, self, TRUE);
            DestroyObject(item, 0.1);
            i++;
        }
        if (i >= nShards) break;
        item = GetNextItemInInventory(pc);
    }

// copy pasted from DLA_ATSMITHMAKE and cleaned up
    //ITEM PROPERTIES SECTION
    itemproperty eEnhance = ItemPropertyEnhancementBonus(nShards);
    itemproperty eProp, eProp2, eProp3, eProp4;

    //This is split first into the incremental powers from nBonus, then the pwers themselves for
    //each special ingredient
    //By default, uses per day is set below, and reset for those that differ:
    int nSave, nUses;
    nUses = (nBonus > 40) ? IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY :
            (nBonus > 30) ? IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY :
            (nBonus > 20) ? IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY :
            (nBonus > 10) ? IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY :
                            IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY ;


    //==========================FAIRY DUST==================
    //Properties given by Fairy Dust are the least powerful as it is the easiest ingredient to get, and revolve
    //around fairies.
    if (sSpecial == "NW_IT_MSMLMISC19") //Fairy dust
    {
        nUses = (nBonus > 28) ? IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY :
                (nBonus > 21) ? IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY :
                (nBonus > 15) ? IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY :
                (nBonus > 10) ? IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY :
                                IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY ;

        nSave = (nBonus > 27) ? IP_CONST_ONHIT_SAVEDC_20 :
                (nBonus > 19) ? IP_CONST_ONHIT_SAVEDC_18 :
                (nBonus > 11) ? IP_CONST_ONHIT_SAVEDC_16 :
                                IP_CONST_ONHIT_SAVEDC_14 ;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_SLEEP_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_CONFUSION, nSave, IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,nBonus/7);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyRegeneration(nBonus/12);  //fourth property is misc
    }
    //==========================BODAK TOOTH==================
    //Properties given by a Bodak Tooth centre around negative energy and Undead.
    else if (sSpecial == "NW_IT_MSMLMISC06") //Bodak Tooth
    {
        nSave = (nBonus > 27) ? IP_CONST_ONHIT_SAVEDC_20 :
                (nBonus > 19) ? IP_CONST_ONHIT_SAVEDC_18 :
                (nBonus > 11) ? IP_CONST_ONHIT_SAVEDC_16 :
                                IP_CONST_ONHIT_SAVEDC_14 ;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN, nSave, IP_CONST_ABILITY_STR); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_2d4);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyCastSpell(IP_CONST_CASTSPELL_ANIMATE_DEAD_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);  //fourth property is misc
    }
    //==========================WYVERN BLOOD==================
    //Properties given by Wyvern Blood centre around poison and agility
    else if (sSpecial == "WyvernBlood")
    {
        nUses = (nBonus > 27) ? IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY :
                (nBonus > 22) ? IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY :
                (nBonus > 17) ? IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY :
                (nBonus > 11) ? IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY :
                                IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY ;

        nSave = (nBonus > 27) ? IP_CONST_ONHIT_SAVEDC_20 :
                (nBonus > 19) ? IP_CONST_ONHIT_SAVEDC_18 :
                (nBonus > 11) ? IP_CONST_ONHIT_SAVEDC_16 :
                                IP_CONST_ONHIT_SAVEDC_14 ;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_NEUTRALIZE_POISON_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,nSave,IP_CONST_POISON_1D2_CONDAMAGE); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,nBonus/8);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyHaste();  //fourth property is misc
    }
    //==========================UNICORN HORN==================
    //Properties given by a Unicorn Horn centre around spell resistance and magic ability..
    else if (sSpecial == "UnicornHorn")
    {

        nSave = (nBonus > 27) ? IP_CONST_ONHIT_SAVEDC_20 :
                (nBonus > 18) ? IP_CONST_ONHIT_SAVEDC_18 :
                (nBonus > 9)  ? IP_CONST_ONHIT_SAVEDC_16 :
                                IP_CONST_ONHIT_SAVEDC_14 ;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_LESSER_DISPEL_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_BLINDNESS, nSave, IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyImmunityToSpellLevel(1+nBonus/15);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyKeen();  //fourth property is misc
        //-----Following section deals with the quest consequences of using the horn-----
        AddJournalQuestEntry("Order",45, pc);//used the horn, so the 'Theft to Order' sidequest updates.
        AllParty("nToOrder", pc, 4); //and the plot variable for it.
        //Alignment consequences of action
        FloatingTextStringOnCreature("Used the horn for your own ends", pc);
        AligXP("HornAXP", pc, "EVIL", 100, 1);        //Shift/reward any alignment
        ScoreAlign(pc,3,0,1,1,1,3,3,2,3,3);
        //---------end---------
    }
    //==========================RED DRAGON SCALE==================
    //Properties given by a Red Dragon Scale centre around fire resistance, awareness and draconic powers.
    else if (sSpecial == "RedDragonScale")
    {
        nSave = (nBonus > 29) ? IP_CONST_ONHIT_SAVEDC_20 :
                (nBonus > 21) ? IP_CONST_ONHIT_SAVEDC_18 :
                (nBonus > 12) ? IP_CONST_ONHIT_SAVEDC_16 :
                                IP_CONST_ONHIT_SAVEDC_14 ;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR,nSave, IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEIMMUNITY_50_PERCENT);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyTrueSeeing();  //fourth property is misc
    }
    //==========================NAPTHA BLEND==================
    //Properties given by Naptha centre around fire.
    else if (sSpecial == "NapthaBlend")
    {
        nSave = (nBonus > 32) ? IP_CONST_ONHIT_SAVEDC_22 :
                (nBonus > 24) ? IP_CONST_ONHIT_SAVEDC_20 :
                (nBonus > 16) ? IP_CONST_ONHIT_SAVEDC_18 :
                (nBonus > 8)  ? IP_CONST_ONHIT_SAVEDC_16 :
                                IP_CONST_ONHIT_SAVEDC_14 ;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_FIREBALL_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN, nSave, IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,1+(nBonus/8));  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE,(nBonus/5));  //fourth property is misc
    }

    object oForged = CreateItemOnObject(sItem, pc);

    IPSafeAddItemProperty(oForged,eEnhance);
    IPSafeAddItemProperty(oForged,eProp);
    IPSafeAddItemProperty(oForged,eProp2);
    IPSafeAddItemProperty(oForged,eProp3);
    IPSafeAddItemProperty(oForged,eProp4);

    //Clean out the variables for next time, except the cost, which is reset anyway
//    SetLocalInt(OBJECT_SELF,"nBonus",0); //number of spell uses, ability power, etc
//    SetLocalString(OBJECT_SELF,"sItem",""); //Type of item to make
//    SetLocalInt(OBJECT_SELF,"nShards",0);   //Number of shards/blades to use in reforging
//    SetLocalString(OBJECT_SELF,"sSpecial","");  //special ingredient selected (Tag)
    DeleteLocalInt(self, "nBonus");
    DeleteLocalString(self, "sItem");
    DeleteLocalInt(self, "nShards");
    DeleteLocalString(self, "sSpecial");

    //------------------SECTION 2 - Animation & cutscene-----------------------------------

    //------------------SECTION 3 - Rewards-----------------------------------

//    ActionMoveToObject(poPC,FALSE,0.6);
//    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);
//    ActionGiveItem(oForged,oPC);

    //Reward whole party no matter who makes the weapon
    PartyGotEntry("Dud",pc,200+150*(nShards*nShards),"XP Gain - Weapon crafted");  //This comes with XP & message
    AddJournalQuestEntry("Weapon",30,pc,TRUE);                      //Update the journal
}

void gn_SequenceFour(object pc, object anvil, int i)
{
    ClearAllActions(TRUE);
    if (i)
    {
        AssignCommand(pc, ActionCastSpellAtObject(SPELL_RAY_OF_ENFEEBLEMENT, anvil, METAMAGIC_ANY, TRUE));
        AssignCommand(pc, ActionWait(3.0));
        AssignCommand(pc, ActionCastSpellAtObject(SPELL_CURE_SERIOUS_WOUNDS, anvil, METAMAGIC_ANY, TRUE));
    }
    ActionCastSpellAtObject(SPELL_RAY_OF_FROST, anvil, METAMAGIC_ANY, TRUE);
    ActionWait(2.0);
    ActionCastSpellAtObject(SPELL_POWER_WORD_STUN, anvil, METAMAGIC_ANY, TRUE);
    ActionWait(1.0);
    ActionDoCommand(FadeToBlack(pc));
    ActionWait(2.0);
    ActionDoCommand(FadeFromBlack(pc));
    ActionWait(3.0);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0);
    ActionMoveToObject(pc);
    ActionDoCommand(SetFacingPoint(GetPosition(pc)));
    ActionDoCommand(gn_CraftWeapon(pc));
    ActionDoCommand(SetCutsceneMode(pc, FALSE));
    ActionResumeConversation();
}

void gn_SequenceThree(object pc, object anvil, int i)
{
    ClearAllActions();
    if (i)
    {
        AssignCommand(pc, ActionCastSpellAtObject(SPELL_HEAL, anvil, METAMAGIC_ANY, TRUE));
        ActionWait(4.0);
    }
    else ActionCastSpellAtObject(SPELL_HEAL, anvil, METAMAGIC_ANY, TRUE);
    ActionDoCommand(DelayCommand(6.0, gn_SequenceFour(pc, anvil, i)));
    ActionAttack(anvil);
}

void gn_SequenceTwo(object pc, object anvil, int i)
{
    ClearAllActions();
    if (i)
    {
        AssignCommand(pc, ActionMoveToObject(anvil, TRUE));
        AssignCommand(pc, ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, anvil, METAMAGIC_ANY, TRUE));
        ActionWait(4.0);
    }
    else ActionCastSpellAtObject(SPELL_DISPEL_MAGIC, anvil, METAMAGIC_ANY, TRUE);
    ActionDoCommand(DelayCommand(6.0, gn_SequenceThree(pc, anvil, i)));
    ActionAttack(anvil);
}

void gn_SequenceOne(object pc, object anvil, int i)
{
    ActionDoCommand(DelayCommand(5.0, gn_SequenceTwo(pc, anvil, i)));
    ActionAttack(anvil);
}

void main()
{
    object self  = OBJECT_SELF;
    object pc    = GetPCSpeaker();
    object anvil = GetNearestObjectByTag("Anvil");
    location locself  = GetLocation(self);
    location locpc    = GetLocation(pc);

    int i = GetLocalInt(self, "GN_PCCRAFT");

    SetCutsceneMode(pc);

    ActionPauseConversation();
    ActionEquipMostDamagingMelee();
    ActionDoCommand(gn_SequenceOne(pc, anvil, i));

    DeleteLocalInt(self, "GN_PCCRAFT");
}

