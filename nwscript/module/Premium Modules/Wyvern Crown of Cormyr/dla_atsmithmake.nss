/*
    DLA_ATSMITHMAKE.nss
    modified by : gaoneng erick
    modified on : may 12, 2006

    THIS SCRIPT IS NO LONGER IN USE.
    Everything has been absorbed into DLA_ATSMITHANIM.nss
*/

//October 2005
// B W-Husey
// This script creates the reforged items, and hands out xp, with effects etc.


#include "x2_inc_itemprop"
#include "cu_functions"
/*  // **** gao mod start
//This function removes the correct number of shards from the Pc's inventory
void TakeShards(object oTarget,int nNumItems)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);


    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetStringLeft(GetTag(oItem),5) == "Shard")  //only remove shards (check first five letters of tag)
        {
            DestroyObject(oItem);
            nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}

//This function removes the special item from the Pc's inventory
void TakeSItem(object oTarget,string sItem)
{
    int nCount = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem) == TRUE && nCount < 1)
    {
        if (GetTag(oItem) == sItem) //Remove the special item (once only)
        {
            DestroyObject(oItem);
            nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return;
}


*/  // **** gao mod end
void main()
{

    //------------------SECTION - Weapon making-----------------------------------
    object oPC = GetPCSpeaker();
    //Pick up all the stored parameters
    int nBonus = GetLocalInt(OBJECT_SELF,"nBonus"); //number of spell uses, ability power, etc
//    int nCost = GetLocalInt(OBJECT_SELF,"nCost");   //cost   // **** gao removed
    string sItem = GetLocalString(OBJECT_SELF,"sItem"); //Type of item to make (resref)
    int nShards = GetLocalInt(OBJECT_SELF,"nShards");   //Number of shards/blades to use in reforging
    string sSpecial = GetLocalString(OBJECT_SELF,"sSpecial");  //special ingredient selected (Tag)
// **** gao mod start
    //debug line ************************
//    SendMessageToPC(oPC,"Result: "+sItem+" with "+IntToString(nShards)+" pieces, using "+sSpecial+" with a bonus of "+IntToString(nBonus)+"and costing "+IntToString(nCost));

    //PAYMENT SECTION
//    TakeGoldFromCreature(nCost, GetPCSpeaker(), FALSE);
//    TakeShards(oPC,nShards);
//    TakeSItem(oPC,sSpecial);
    //reset the variables for next time.
//    SetLocalInt(oPC,"nCraftCost",0);
//    SetLocalInt(oPC,"nCraftAd",0);
    DeleteLocalInt(oPC, "nCraftCost");
    DeleteLocalInt(oPC, "nCraftAd");
// **** gao mod end

    //ITEM PROPERTIES SECTION
    itemproperty eEnhance = ItemPropertyEnhancementBonus(nShards);
    itemproperty eProp;
    itemproperty eProp2;
    itemproperty eProp3;
    itemproperty eProp4;
    //This is split first into the incremental powers from nBonus, then the pwers themselves for
    //each special ingredient
    //By default, uses per day is set below, and reset for those that differ:
        int nUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        if (nBonus>10)nUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        if (nBonus>20)  nUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        if (nBonus>30)  nUses = IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
        if (nBonus>40)  nUses = IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY;


    //==========================FAIRY DUST==================
    //Properties given by Fairy Dust are the least powerful as it is the easiest ingredient to get, and revolve
    //around fairies.
    if (sSpecial == "NW_IT_MSMLMISC19") //Fairy dust
    {

        int nUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        if (nBonus>10)nUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        if (nBonus>15)  nUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        if (nBonus>21)  nUses = IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
        if (nBonus>28)  nUses = IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY;

        int nSave = IP_CONST_ONHIT_SAVEDC_14;
        if (nBonus>11) nSave = IP_CONST_ONHIT_SAVEDC_16;
        if (nBonus>19) nSave = IP_CONST_ONHIT_SAVEDC_18;
        if (nBonus>27) nSave = IP_CONST_ONHIT_SAVEDC_20;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_SLEEP_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_CONFUSION, nSave, IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL,nBonus/7);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyRegeneration(nBonus/12);  //fourth property is misc
    }
    //==========================BODAK TOOTH==================
    //Properties given by a Bodak Tooth centre around negative energy and Undead.
    if (sSpecial == "NW_IT_MSMLMISC06") //Bodak Tooth
    {

        int nSave = IP_CONST_ONHIT_SAVEDC_14;
        if (nBonus>11) nSave = IP_CONST_ONHIT_SAVEDC_16;
        if (nBonus>19) nSave = IP_CONST_ONHIT_SAVEDC_18;
        if (nBonus>27) nSave = IP_CONST_ONHIT_SAVEDC_20;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_ABILITYDRAIN, nSave, IP_CONST_ABILITY_STR); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD,IP_CONST_DAMAGETYPE_COLD,IP_CONST_DAMAGEBONUS_2d4);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyCastSpell(IP_CONST_CASTSPELL_ANIMATE_DEAD_10,IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY);  //fourth property is misc
    }
    //==========================WYVERN BLOOD==================
    //Properties given by Wyvern Blood centre around poison and agility
    if (sSpecial == "WyvernBlood")
    {
        int nUses = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        if (nBonus>11)nUses = IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY;
        if (nBonus>17)  nUses = IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY;
        if (nBonus>22)  nUses = IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY;
        if (nBonus>27)  nUses = IP_CONST_CASTSPELL_NUMUSES_5_USES_PER_DAY;

        int nSave = IP_CONST_ONHIT_SAVEDC_14;
        if (nBonus>11) nSave = IP_CONST_ONHIT_SAVEDC_16;
        if (nBonus>19) nSave = IP_CONST_ONHIT_SAVEDC_18;
        if (nBonus>27) nSave = IP_CONST_ONHIT_SAVEDC_20;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_NEUTRALIZE_POISON_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,nSave,IP_CONST_POISON_1D2_CONDAMAGE); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,nBonus/8);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyHaste();  //fourth property is misc
    }
    //==========================UNICORN HORN==================
    //Properties given by a Unicorn Horn centre around spell resistance and magic ability..
    if (sSpecial == "UnicornHorn")
    {

        int nSave = IP_CONST_ONHIT_SAVEDC_14;
        if (nBonus>9) nSave = IP_CONST_ONHIT_SAVEDC_16;
        if (nBonus>18) nSave = IP_CONST_ONHIT_SAVEDC_18;
        if (nBonus>27) nSave = IP_CONST_ONHIT_SAVEDC_20;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_LESSER_DISPEL_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_BLINDNESS, nSave, IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyImmunityToSpellLevel(1+nBonus/15);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyKeen();  //fourth property is misc
        //-----Following section deals with the quest consequences of using the horn-----
        AddJournalQuestEntry("Order",45,oPC);//used the horn, so the 'Theft to Order' sidequest updates.
        AllParty("nToOrder",oPC,4); //and the plot variable for it.
        //Alignment consequences of action
        FloatingTextStringOnCreature("Used the horn for your own ends",GetPCSpeaker());
        AligXP("HornAXP", oPC, "EVIL", 100, 1);        //Shift/reward any alignment
        ScoreAlign(oPC,3,0,1,1,1,3,3,2,3,3);
        //---------end---------
    }
    //==========================RED DRAGON SCALE==================
    //Properties given by a Red Dragon Scale centre around fire resistance, awareness and draconic powers.
    if (sSpecial == "RedDragonScale")
    {

        int nSave = IP_CONST_ONHIT_SAVEDC_14;
        if (nBonus>12) nSave = IP_CONST_ONHIT_SAVEDC_16;
        if (nBonus>21) nSave = IP_CONST_ONHIT_SAVEDC_18;
        if (nBonus>29) nSave = IP_CONST_ONHIT_SAVEDC_20;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR,nSave, IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE,IP_CONST_DAMAGEIMMUNITY_50_PERCENT);  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyTrueSeeing();  //fourth property is misc
    }
    //==========================NAPTHA BLEND==================
    //Properties given by Naptha centre around fire.
    if (sSpecial == "NapthaBlend")
    {

        int nSave = IP_CONST_ONHIT_SAVEDC_14;
        if (nBonus>8) nSave = IP_CONST_ONHIT_SAVEDC_16;
        if (nBonus>16) nSave = IP_CONST_ONHIT_SAVEDC_18;
        if (nBonus>24) nSave = IP_CONST_ONHIT_SAVEDC_20;
        if (nBonus>32) nSave = IP_CONST_ONHIT_SAVEDC_22;

        eProp = ItemPropertyCastSpell(IP_CONST_CASTSPELL_FIREBALL_5,nUses);  //first property is a spell
        if (nShards > 1)   eProp2 = ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN, nSave, IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS); //second property is an onhit bonus
        if (nShards > 2)   eProp3 = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_FIRE,1+(nBonus/8));  //third property is misc
        if (nShards > 3)   eProp4 = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_FIRE,(nBonus/5));  //fourth property is misc
    }

    object oForged = CreateItemOnObject(sItem);

    IPSafeAddItemProperty(oForged,eEnhance);
    IPSafeAddItemProperty(oForged,eProp);
    IPSafeAddItemProperty(oForged,eProp2);
    IPSafeAddItemProperty(oForged,eProp3);
    IPSafeAddItemProperty(oForged,eProp4);

    //Clean out the variables for next time, except the cost, which is reset anyway
    SetLocalInt(OBJECT_SELF,"nBonus",0); //number of spell uses, ability power, etc
    SetLocalString(OBJECT_SELF,"sItem",""); //Type of item to make
    SetLocalInt(OBJECT_SELF,"nShards",0);   //Number of shards/blades to use in reforging
    SetLocalString(OBJECT_SELF,"sSpecial","");  //special ingredient selected (Tag)

    //------------------SECTION 2 - Animation & cutscene-----------------------------------

    //------------------SECTION 3 - Rewards-----------------------------------

    ActionMoveToObject(oPC,FALSE,0.6);
    ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,4.0);
    ActionGiveItem(oForged,oPC);

    //Reward whole party no matter who makes the weapon
    PartyGotEntry("Dud",oPC,200+150*(nShards*nShards),"XP Gain - Weapon crafted");  //This comes with XP & message
    AddJournalQuestEntry("Weapon",30,oPC,TRUE);                      //Update the journal
}
