// April 2004
// B W-Husey
// Detects creature variables to set up various states.This is the default UDF used for most creatures.
// Modifications: ongoing
// Last modification 5th August - Wyvern flying attacks modified

// Syrsnein, 26 April 2006: Modified to include an event to start the barrow
//  battlefield escape cutscene for the Witch Lord.

#include "cu_treasure"
#include "cu_magicvariable"
#include "cu_magicspecific"
#include "cu_magic"
#include "x0_i0_anims"
#include "x0_i0_petrify"
#include "cu_functions"
#include "dla_i1_battle"

//function to allow items to be dropped some of the time
int DropChance(int nDrop = 2) //Chance of dropping item 2 =1 in 2, 3 =1 in 3 etc/
{
   int nReturn = Random(nDrop);
   if (nReturn<nDrop-1) nReturn = 0;
   return nReturn;
}

// function used by wyverns to fly when they can't reach their enemies
void JumpToEnemy(object oTarget, float fDistanceAway, float fDelay)
{
    //won't jump if closer than 5 metres to target/or already fled from combat/immobilised/dominated or jumping
    if (GetLocalInt(OBJECT_SELF,"nJumping")>0)
    {
        return;
    }
    else if (GetDistanceToObject(oTarget) > fDistanceAway && GetLocalInt(OBJECT_SELF,"nWontRun")<1 && GetIsMobile(OBJECT_SELF))
    {
        ClearAllActions();
        //Stop me jumping if I'm already doing so
        SetLocalInt(OBJECT_SELF,"nJumping",1);
        DelayCommand(fDelay+7.4,SetLocalInt(OBJECT_SELF,"nJumping",0));
        //use fly effects to 'teleport'
        effect eJump = EffectDisappearAppear(GetLocation(oTarget));
        effect eVis = EffectVisualEffect(VFX_IMP_PULSE_WIND);
        effect eLink = EffectLinkEffects(eVis,eJump);
        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, OBJECT_SELF,7.0));
        DelayCommand(fDelay+7.5,ActionAttack(oTarget));
    }
}

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

//======================================================MAIN==========================
void main()
{
    int nUser = GetUserDefinedEventNumber();

    if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    {
    }
//Syrsnein, 24 April 2006
/* removed 29 April 2006, Syrsnein
    else if (nUser == DLA_EVENT_BARROWEXIT)
    {// Do Barrow Exit cutscene for finalle
        ExitBattle();
    }
    else if (nUser == DLA_EVENT_BARROWEXIT_JONAS)
    {// Do Barrow Exit routine for Jonas (should only be fire on jonas)
        ExitBattleJonas(OBJECT_SELF);
    }
    else if (nUser == DLA_EVENT_BARROWEXIT_WL)
    {// Do Barrow Exit routine for the WL (should only be fire on the witchlord)
        ExitBattleWL(OBJECT_SELF);
    }
//End Syrsnein, 24 April 2006
end removal by Syrsnein */
    else if (nUser == EVENT_PERCEIVE)
    {
        if (IsInConversation(OBJECT_SELF) == FALSE && GetLocalInt(OBJECT_SELF,"Smith")==1) {
        object oRubble = GetNearestObjectByTag("Anvil");
        ActionAttack(oRubble);
        PlaySound("as_cv_smithhamr1");
        }
        // Following require the variable nPerceive to be 1 on the creature to fire the perceive event.
        //Code for sleeping creatures to get a single listen check to wake.
        if (GetHasEffect(EFFECT_TYPE_SLEEP)&& GetLocalInt(OBJECT_SELF,"nPerceive")==1)
        {
            object oPC = GetLastPerceived();
            if(GetIsEnemy(oPC))
            {
                SetLocalInt(OBJECT_SELF,"nPerceive",0);  //one wake check, after this stone deaf.
                // ********debug line**************
//                SendMessageToPC(GetFirstPC(),"udf peception says listen");
                if (GetIsSkillSuccessful(OBJECT_SELF,SKILL_LISTEN,20))
                {
//               effect eEffect;
//               eEffect = GetFirstEffect(OBJECT_SELF);
//                while(GetIsEffectValid(eEffect))
//                {
//                     if (GetEffectType(eEffect) == EFFECT_TYPE_SLEEP)
//                     {
                     //Remove the effect
//                     DelayCommand(5.0,RemoveEffect(OBJECT_SELF, eEffect));
                       DelayCommand(5.0,RemoveEffectOfType(OBJECT_SELF, EFFECT_TYPE_SLEEP));
//                     }
//                 eEffect = GetNextEffect(OBJECT_SELF);
//                 }
            }
            else
                {
                           effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
                           DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF));
                           DelayCommand(7.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,OBJECT_SELF));
                }
            }
        }
        if (GetLocalInt(OBJECT_SELF,"nPerceive")>0 && GetLocalInt(OBJECT_SELF,"nOneLine")>0 && GetIsDead(OBJECT_SELF)==FALSE)
        switch (GetLocalInt(OBJECT_SELF,"nOneLine"))
        {
        case 1:
            SpeakOneLinerConversation("forthewitch");
            break;
        case 2:
            SpeakOneLinerConversation("killkathryn");
            break;
        }
        if (GetLocalInt(OBJECT_SELF,"nCombat")==1) //Wyvern fly to attack event
        {
           //*******debug line*********
           //SendMessageToPC(GetFirstPC(),"Perceive behaviour fired");
           JumpToEnemy(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY),12.0,6.0);
        }
    }
    else if (nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT ROUND - Wyverns only
    {
        if (GetLocalInt(OBJECT_SELF,"nCombat")==1) //Wyvern fly to attack event
        {
           //*******debug line*********
           //SendMessageToPC(GetFirstPC(),"Special combat behaviour fired");
           JumpToEnemy(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY),5.0,0.0);
        }
    }
    else if(nUser == EVENT_DIALOGUE) // ON DIALOGUE
    {

    }
    else if(nUser == EVENT_ATTACKED) // ATTACKED
    {
    }
    else if(nUser == EVENT_DAMAGED) // DAMAGED
    {
    }
    else if(nUser == 1007) // DEATH  - do not use for critical code, does not fire reliably all the time
    {
        if(GetLocalInt(OBJECT_SELF,"nBandit")==1)
        {
            //line counts the bandits killed by the party in the caravan attack
            SetLocalInt(GetLastKiller(),"nBandits",GetLocalInt(GetLastKiller(),"nBandits")+1);
            //*******debug line
//            SendMessageToPC(GetFirstPC(),"kill registered "+GetName(GetLastKiller()));
        }
    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {

    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        // all creature variables start with c
        if (GetLocalInt(OBJECT_SELF,"cDarkness")==1)   ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_DARKNESS),OBJECT_SELF);
        if (Random(100)+1 < GetLocalInt(OBJECT_SELF,"cRandom1")) GetTreasure("OneHand");
        //This one used for testing. Occasionaly some generations don't seem to use their variables, so check with this effect
        if (GetLocalInt(OBJECT_SELF,"cEffect")==1)    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GLOW_RED),OBJECT_SELF);
        if (GetLocalInt(OBJECT_SELF,"cEffect")==2)    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSleep(),OBJECT_SELF);
        if (GetLocalInt(OBJECT_SELF,"cEffect")==3)    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectSpellFailure(65),OBJECT_SELF);
        if (GetLocalInt(OBJECT_SELF,"cEffect")==4)    ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT),OBJECT_SELF);
        if (GetLocalInt(OBJECT_SELF,"cEffect")==5)
            {
            effect eDam = EffectDamage(10);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,OBJECT_SELF);
            ClearAllActions();
            DelayCommand(0.1,ActionPlayAnimation(ANIMATION_LOOPING_DEAD_BACK,1.0,1000.0));
            }
        if (GetLocalInt(OBJECT_SELF,"cEffect")==6)
            {
            effect eVis = EffectVisualEffect(VFX_DUR_PROT_STONESKIN);
            effect eStone = EffectDamageReduction(5,2,50);
            effect eLink = EffectLinkEffects(eVis,eStone);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eLink,OBJECT_SELF);
            }
        if (GetLocalInt(OBJECT_SELF,"cAnimation")==1)   ActionSit(GetNearestObjectByTag("Chair"));
        if (GetLocalInt(OBJECT_SELF, "nRanged") == 1)  SetCombatCondition(X0_COMBAT_FLAG_RANGED);
        if (GetLocalInt(OBJECT_SELF, "nRanged") == 2)  //Ballista operator (set their perception to long)
    /*    {
                    // ********debug line**************
    //                SendMessageToPC(GetFirstPC(),"udf says active and fire");
    //            object oBall = GetNearestObjectByTag("Ballista");
                ClearAllActions(TRUE);
                SetLocalInt(OBJECT_SELF,"Active",1);
    //            ActionMoveToObject(oBall, TRUE);
                ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0);
                DelayCommand(2.5,ActionInteractObject(GetNearestObjectByTag("Ballista")));
    //            SetCommandable(FALSE,OBJECT_SELF);           //Stop DetermineCombatRound() overiding flee orders
    //            DelayCommand(5.0,SetCommandable(TRUE,OBJECT_SELF));
        }*/
        if (GetLocalInt(OBJECT_SELF, "nRanged") == 3)  SetCombatCondition(X0_COMBAT_FLAG_AMBUSHER);


        // Treasure tables for equipment and treasure carried by creatures. In some cases they cannot be dropped, or might
        // not want to be dropped (smashed, undesired to have too many, etc):

        //For reference these functions use:
        //GetTreasure(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nEquip=0, int nDrop =0)
        //GetVariable(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nEquip=0, int nPlus=0)
        //GetMagic(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nBonus=0, int nDrop =0, int nEquip=0)
        //GetTreasureType(string sTreasureSet, object oCreateIn=OBJECT_SELF, int nChance=100, int nLevel=1, int nItems=1)


        //One hand weapon - very low chance of gold and miscellaneous (soldiers). Don't drop weapons.
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Soldier")
        {
            GetTreasure("OneHand",OBJECT_SELF,100,0,1,1);
            GetTreasure("Gold10",OBJECT_SELF,5);
            GetTreasure("Misc",OBJECT_SELF,5);
        }
        //One hand weapon - very low chance of gold and miscellaneous (soldiers). Can drop weapons. (use early in
        //mod when the PC might want to pick weapons up)
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="SoldierDrop")
        {
            GetTreasure("OneHand",OBJECT_SELF,100,0,1,DropChance(3));
            GetTreasure("Gold10",OBJECT_SELF,5);
            GetTreasure("Misc",OBJECT_SELF,5);
        }
        //Ranged weapon - chance of gold and miscellaneous (scouts). Might drop weapons. Ammo might be interesting.
        // Give them a hand to hand weapon
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Scout")
        {
            GetTreasure("Ranged",OBJECT_SELF,100,0,1,DropChance(2));
            GetTreasure("Gold10",OBJECT_SELF,10);
            GetTreasure("Misc",OBJECT_SELF,10);
            GetTreasureType("Ammo",OBJECT_SELF,5);
        }
        // Two handed weapon, chance of gold & minor items. Don't drop weapons (used later in mod). Possible droppable potions
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Champion")
        {
            GetTreasure("TwoHand",OBJECT_SELF,100,0,1,1);
            GetTreasure("Gold10",OBJECT_SELF,100);
            GetTreasure("Misc",OBJECT_SELF,5);
            GetTreasure("Minor",OBJECT_SELF,25);
            GetTreasure("Gem",OBJECT_SELF,5);
            GetMagic("Potions", OBJECT_SELF, 5, 0, DropChance(2));
        }
        //One hand special weapon - chance of gold, miscellaneous and minor treasure. Always drop weapons.  Possible droppable potions
        //Give them a shield!
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Commander1")
        {
            GetVariable("OneHand",OBJECT_SELF,100,0,1,d2());
            GetTreasure("Gold10",OBJECT_SELF,100,2*d12());
            GetTreasure("Misc",OBJECT_SELF,25);
            GetTreasure("Minor",OBJECT_SELF,25);
            GetMagic("Potions", OBJECT_SELF, 5, 0, DropChance(3));
        }
        // Chance of various treasure.  Possible droppable potions. Have a +1 weapon
        // since it might be ranged give a back up and ammo to the creature.
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Commander2")
        {
            GetMagic("Weapon1", OBJECT_SELF, 100, 0, DropChance(4), 1);
            GetTreasure("Gold10",OBJECT_SELF,100,5*d10());
            GetTreasure("Major",OBJECT_SELF,50);
            GetTreasure("Gem",OBJECT_SELF,5);
            GetMagic("Potions", OBJECT_SELF, 20, 0, DropChance(3));
        }
        //Weapons should be preset, chance of various treasure, more wizard focussed.
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="WizardLow") //
        {
            GetTreasure("Gold10",OBJECT_SELF,100,2*d10());
            GetTreasure("Misc",OBJECT_SELF,15);
            GetTreasure("Minor",OBJECT_SELF,25);
            GetMagic("Books", OBJECT_SELF, 2);
            GetMagic("Scrolls1", OBJECT_SELF, 25);
            GetMagic("Scrolls12", OBJECT_SELF, 5);
            GetTreasureType("Wizardry",OBJECT_SELF,5,1,1);
        }
        //As above but powerful
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="WizardHigh") //
        {
            GetTreasure("Gold10",OBJECT_SELF,100,5*d10());
            GetTreasure("Minor",OBJECT_SELF,25);
            GetMagic("Potions", OBJECT_SELF, 10, 0, DropChance(3));
            GetMagic("Books", OBJECT_SELF, 5);
            GetMagic("Scrolls1", OBJECT_SELF, 5);
            GetMagic("Scrolls12", OBJECT_SELF, 5);
            GetMagic("Scrolls34", OBJECT_SELF, 50);
            GetMagic("Scrolls56", OBJECT_SELF, 35);
            GetTreasureType("Jewelry",OBJECT_SELF,25,1,1);
            GetTreasureType("Wizardry",OBJECT_SELF,50,d2(),1);
        }
        //Weapons should be preset, chance of various treasure, more priest focussed.
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Priest") //
        {
            GetTreasure("Gold10",OBJECT_SELF,100,5);
            GetTreasure("Minor",OBJECT_SELF,50);
            GetTreasure("Major",OBJECT_SELF,15);
            GetMagic("Potions", OBJECT_SELF, 50, 0, DropChance(2));
            GetTreasureType("Jewelry",OBJECT_SELF,15,2,1);
        }
        // Drop weapons, some gold/miscellaneous. Can be given droppable shield. Might also carry ranged weapons & potions
        // so give undroppable ammo if you want them to have more than 20 rounds.
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Bandit") //
        {
            GetTreasure("Ranged",OBJECT_SELF,30,0,1,DropChance(3));
            GetTreasure("OneHand",OBJECT_SELF,100,0,1,DropChance(5));
            GetTreasure("Gold10",OBJECT_SELF,100);
            GetTreasure("Misc",OBJECT_SELF,15);
            GetTreasure("Minor",OBJECT_SELF,5);
            GetMagic("Potions", OBJECT_SELF, 5);
        }
        // No shields, don't drop weapons, but some chance of gold/miscellaneous/gems. Add ranged if you want them
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Pirate")
        {
            GetTreasure("AnyHand",OBJECT_SELF,100,0,1,1);
            GetTreasure("Gold10",OBJECT_SELF,70);
            GetTreasure("Misc",OBJECT_SELF,15);
            GetTreasure("Gem",OBJECT_SELF,5);
        }
        // Hired hands - preset weapons. They will carry a few gold, and small chance of all sorts.
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Hired")
        {
            GetTreasure("Gold10",OBJECT_SELF,70);
            GetTreasure("Misc",OBJECT_SELF,10);
            GetTreasure("Gem",OBJECT_SELF,5);
            GetTreasure("Minor",OBJECT_SELF,5);
            GetTreasure("Ranged",OBJECT_SELF,10,0,1,1);
        }
        // Undroppable Two handed weapon, gold & minor items. Possible magic items
        if (GetLocalString(OBJECT_SELF,"sTreasure")=="Chief")
        {
            GetTreasure("TwoHand",OBJECT_SELF,100,0,1,1);
            GetTreasure("Gold10",OBJECT_SELF,100,5*d10());
            GetTreasureType("Misc",OBJECT_SELF,10,d2());
            GetTreasureType("Jewelry",OBJECT_SELF,10);
            GetTreasure("Gem",OBJECT_SELF,25);
            GetMagic("Potions", OBJECT_SELF, 5, 0, DropChance(2));
        }

    }
}


