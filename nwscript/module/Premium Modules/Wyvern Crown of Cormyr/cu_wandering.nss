// B W-Husey
// February 2002, rebuilt October 2005 for Wyvern Crown
// This is the library for encounter tables and wandering monster functions.
/* Functions included are:
    GenerateMonster     Spawn the monsters at the spawn point and tell them to attack the PC
    WandMonCheck        Do a check for wandering monsters
*/


//============================DECLARATIONS==================================
// GenerateMonster     Spawn the monsters at the spawn point and tell them to attack the PC
// Inputs are:
//        lSpawn  The location of the spawn point (sent from WandMonCheck)
//        oPC     The character to attack (sent from WandMonCheck)
//        sEncountertable     The encounter table to use (also sent from WandMonCheck)
void GenerateMonster(location lSpawn, object oPC, string sEncounterTable);

// WandMonCheck        Do a check for wandering monsters
// Inputs are:
//        oPC     The character trying to sleep/travel
//        iUnsafe Integer that if 1 tells us to check for monsters (comes from area variable "Unsafe" or overland travel dialogue)
//        iChance Integer percentile chnce of monsters (comes from area variable "WMChance" or overland travel dialogue)
//        sTable  String, encounter table to use (comes from area variable "WMTable" or overland travel dialogue)
//        nTravel If the PC is travelling, the PC must first go to the encounter area to generate the monsters.
int WandMonCheck(object oPC,int iUnsafe = 0, int iChance = 0, string sTable = "Null", int nTravel = FALSE);

//============================END DECLARATIONS==================================
void GenerateMonster(location lSpawn, object oPC, string sEncounterTable)
{
// Generate Monster
int nCase = 0;
if (sEncounterTable == "Forest") nCase = 1;//Hullack Forest and journeys too/from Polter & Barrows
if (sEncounterTable == "PolterOut") nCase = 2;//Sleeping in upper levels and outside Polters
if (sEncounterTable == "PolterIn") nCase = 3;//Undead part of Polters
if (sEncounterTable == "CastleOut") nCase = 4;//Outside Wyvernwater Castle/lake
if (sEncounterTable == "CastleIn") nCase = 5;//Inside Wyvernwater Castle
if (sEncounterTable == "Roads") nCase = 6;//Anywhere else (probably decided not to use inns)
// Check the HD of the PC - this means you can scale the monsters somewhat if you desire
int nBonus = GetHitDice(oPC);
nBonus = nBonus/2 - 2; //PC up to level 7, bonus = 0, PC level 13 bonus = 4,
if (nBonus < 1) nBonus == 0;//min bonus
if (nBonus > 3) nBonus == 4;//max bonus

int nNumber = 1;
int nNumber2 = 1;
int nNumber3 = 1;
string sCreature = "Null";
string sCreature2 = "Null";
string sCreature3 = "Null";
int nRoll = d6() + nBonus; //random roll + PC Hit Dice bonus
//debug line**************************
//SendMessageToPC(oPC,"Roll Bonus "+IntToString(nBonus)+" and total: "+ IntToString(nRoll));
    switch(nCase)
    {
       case 1: //Forest
            if (nRoll == 1) {sCreature = "blackcobra2"; nNumber = d3();}   //
            if (nRoll == 2) {sCreature = "hobgoblinscout"; nNumber = d3();}   //Standard Polter scout force
            if (nRoll == 3) {sCreature = "nw_wolf"; nNumber = d6()+1;
                                sCreature2 = "nw_direwolf"; nNumber2 = Random(2);}
            if (nRoll == 4) {sCreature = "nw_pixie"; nNumber = d6()+1;}
            if (nRoll == 5) {sCreature = "nw_wight"; nNumber = d3();
                            sCreature2 = "nw_ghoul"; nNumber2 = Random(3);
                            sCreature3 = "nw_ghast"; nNumber3 = Random(2);}
            if (nRoll == 6) {sCreature = "nw_spidgiant"; nNumber = d3();
                            sCreature2 = "nw_spidphaset"; nNumber2 = d3();
                                    if (Random(2)==1) sCreature3 = "nw_spidswrd";
                                    else sCreature3 = "nw_ettercap";
                                    nNumber3 = d2();}
            if (nRoll == 7) {sCreature = "hobgoblinsoldie"; nNumber = d6()+2;
                            sCreature2 = "ogre"; nNumber2 = 1;
                            sCreature3 = "hobgoblinshaman"; nNumber3 = 1;} //Standard Polter raiding force 2
            if (nRoll == 8) {sCreature = "nw_bearkodiak"; nNumber = 1;}
            if (nRoll == 9) {sCreature = "nw_ettin"; nNumber = 1;}
            if (nRoll > 9) {sCreature = "hillgiant"; nNumber = 1;}
       break;
       case 2: //Polters raiding forces
             if (nRoll == 1) {sCreature = "hobgoblinsoldie"; nNumber = d3()+1;}
            if (nRoll == 2) {sCreature = "hobgoblinsoldie"; nNumber = d3()+1;}
            if (nRoll == 3) {sCreature = "hobgoblinscout"; nNumber = d3();}   //Standard Polter scout force
            if (nRoll == 4) {sCreature = "hobgoblinsoldie"; nNumber = d3()+1;}
            if (nRoll == 5) {sCreature = "hobgoblinsoldie"; nNumber = d6()+2;
                            sCreature2 = "hobgoblinchampi"; nNumber2 = 1;
                            sCreature3 = "hobgoblinleader"; nNumber3 = 1;} //Standard Polter raiding force 1
            if (nRoll == 6) {sCreature = "hobgoblinsoldie"; nNumber = d6()+2;
                            sCreature2 = "ogre"; nNumber2 = 1;
                            sCreature3 = "hobgoblinshaman"; nNumber3 = 1;} //Standard Polter raiding force 2
            if (nRoll == 7) {sCreature = "nw_ghoul"; nNumber = Random(3);
                            sCreature2 = "nw_ghast"; nNumber2 = d2();
                            sCreature3 = "nw_wight"; nNumber3 = Random(2);} //Standard Polter raiding force 2
            if (nRoll == 8) {sCreature = "ogre2"; nNumber = Random(3);
                            sCreature2 = "ogre"; nNumber2 = d2();
                            sCreature3 = "ogrechief"; nNumber3 = Random(2);} //Standard Polter raiding force 2
            if (nRoll == 9) {sCreature = "nw_shadow"; nNumber = d3()+1;}
            if (nRoll > 9) {sCreature = "nw_bodak"; nNumber = d2();}
        break;
       case 3: //Polters Undead
             if (nRoll == 1) {sCreature = "nw_wight"; nNumber = d3()+1;}
            if (nRoll == 2) {sCreature = "nw_ghoul"; nNumber = d3()+1;}
            if (nRoll == 3) {sCreature = "nw_ghast"; nNumber = d3();}
            if (nRoll == 4) {sCreature = "nw_shadow"; nNumber = d3()+1;}
            if (nRoll == 5) {sCreature = "hobgoblinsoldie"; nNumber = d6()+2;
                            sCreature2 = "hobgoblinchampi"; nNumber2 = 1;
                            sCreature3 = "hobgoblinleader"; nNumber3 = 1;} //Standard Polter raiding force 1
            if (nRoll == 6) {sCreature = "nw_wight"; nNumber = d6()+2;
                            sCreature2 = "nw_ghoul"; nNumber2 = 1;
                            sCreature3 = "nw_ghast"; nNumber3 = 1;}
            if (nRoll == 7) {sCreature = "nw_skeleton"; nNumber = Random(3);
                            sCreature2 = "nw_skelmage"; nNumber2 = d2();
                            sCreature3 = "nw_skelpriest"; nNumber3 = Random(2);}
            if (nRoll == 8) {sCreature = "ogre2"; nNumber = Random(3);
                            sCreature2 = "ogre"; nNumber2 = d2();
                            sCreature3 = "ogrechief"; nNumber3 = Random(2);}
            if (nRoll == 9) {sCreature = "nw_shadow"; nNumber = d3()+1;}
            if (nRoll > 9) {sCreature = "nw_bodak"; nNumber = d2();}
       break;
       case 4: //Lake Wyvernwater
            if (nRoll == 1) {sCreature = "blackcobra"; nNumber = d3();
                            sCreature2 = "blackcobra3"; nNumber2 = d2();}
            if (nRoll == 2) {sCreature = "bandit"; nNumber = d3();
                            sCreature2 = "bandit001"; nNumber2 = d2();
                            sCreature3 = "banditleader"; nNumber3 = Random(2);}
            if (nRoll == 3) {sCreature = "x0_wyrmling_blk"; nNumber = d3()+1;}
            if (nRoll == 4) {sCreature = "nw_werewolf001"; nNumber = d4()+1;
                            sCreature2 = "nw_werewolf"; nNumber2 = d4();
                            sCreature3 = "bandit004"; nNumber3 = d2();}
            if (nRoll == 5) {sCreature = "juvenilewyvern"; nNumber = d2();
                            sCreature2 = "wyvern"; nNumber2 = 1;}
            if (nRoll == 6) {sCreature = "blackcobra"; nNumber = d4();
                             sCreature2 = "blackcobra3"; nNumber2 = d3();}
            if (nRoll == 7) {sCreature = "wyvern"; nNumber = d3();}
            if (nRoll == 8) {sCreature = "x2_harpy001"; nNumber = d4()+2;}
            if (nRoll == 9) {sCreature = "x0_manticore"; nNumber = d2();}
            if (nRoll > 9) {sCreature = "wyvern"; nNumber = d3()+2;}
       break;
       case 5: //Inside Wyvernwater Castle
            if (nRoll == 1) {sCreature = "blackcobra"; nNumber = d3();
                            sCreature2 = "blackcobra3"; nNumber2 = d2();}
            if (nRoll == 2) {sCreature = "pirate"; nNumber = d2();
                            sCreature2 = "pirate001"; nNumber2 = d2();
                            sCreature3 = "pirate002"; nNumber3 = d2();}
            if (nRoll == 3) {sCreature = "pirate"; nNumber = d3();
                            sCreature2 = "pirate2"; nNumber2 = d2();
                            sCreature3 = "piratecleric"; nNumber3 = Random(2);}
            if (nRoll == 4) {sCreature = "pirate"; nNumber = d4();
                            sCreature2 = "pirate002"; nNumber2 = d4();
                            sCreature3 = "pirateleader"; nNumber3 = Random(2);}
            if (nRoll == 5) {sCreature = "nw_trog001"; nNumber = d4()+1;
                            sCreature2 = "nw_trog002"; nNumber2 = d4();
                            sCreature3 = "nw_trog003"; nNumber3 = Random(2);}
            if (nRoll == 6) {sCreature = "blackcobra"; nNumber = d4();
                             sCreature2 = "blackcobra3"; nNumber2 = d2();}
            if (nRoll == 7) {sCreature = "nw_gargoyle"; nNumber = d3()+3;}
            if (nRoll == 8) {sCreature = "pirate2"; nNumber = d4()+1;
                            sCreature2 = "pirate002"; nNumber2 = d4();
                            sCreature3 = "pirateconjuror"; nNumber3 = 1;}
            if (nRoll == 9) {sCreature = "pirate002"; nNumber = d4()+1;
                            sCreature2 = "pirateconjuror"; nNumber2 = 1;
                            sCreature3 = "pirateleader"; nNumber3 = 1;}
            if (nRoll > 9) {sCreature = "sahuagin"; nNumber = d6()+1;
                            sCreature2 = "sahuaginsub"; nNumber2 = 1;
                            sCreature3 = "sahuagin001"; nNumber3 = 1;}
       break;
       case 6: //On the roads to/from Wyvernwater
            if (nRoll == 1) {sCreature = "bandit003"; nNumber = d3();
                            sCreature2 = "bandit004"; nNumber2 = d2();}
            if (nRoll == 2) {sCreature = "nw_stirge"; nNumber = d12();}
            if (nRoll == 3) {sCreature = "blackcobra"; nNumber = d3();
                                sCreature2 = "blackcobra3"; nNumber2 = Random(3);}
            if (nRoll == 4) {sCreature = "nw_wererat"; nNumber = d6()+2;}
            if (nRoll == 5) {sCreature = "hobgoblinsoldie"; nNumber = d6()+2;
                            sCreature2 = "ogre"; nNumber2 = 1;
                            sCreature3 = "hobgoblinleaderm"; nNumber3 = 1;} //Standard Polter raiding force 2
            if (nRoll == 6) {sCreature = "hobgoblinscout"; nNumber = d4();
                             sCreature2 = "ogre"; nNumber2 = Random(2);}
            if (nRoll == 7) {sCreature = "nw_werewolf001"; nNumber = d4()+1;
                            sCreature2 = "nw_werewolf"; nNumber2 = d3();
                            sCreature3 = "bandit004"; nNumber3 = d2();}
            if (nRoll == 8) {sCreature = "bandit"; nNumber = d3();
                            sCreature2 = "bandit001"; nNumber2 = d3()+1;
                            sCreature3 = "banditleader"; nNumber3 = 1;}
            if (nRoll == 9) {sCreature = "nw_minotaur"; nNumber = d3();}
            if (nRoll > 9) {sCreature = "hillgiant"; nNumber = d2();}
       break;
       default:
       break;
    }

    object oEnemy;
    int nCounter = 0;
    while (nCounter < nNumber)
    {
        oEnemy = CreateObject(OBJECT_TYPE_CREATURE, sCreature, lSpawn, FALSE);
        DelayCommand(0.1,AssignCommand(oEnemy, ActionAttack(oPC)));
        nCounter ++;  //increment our counter
    }
    if (sCreature2 != "Null")
    {
    int nCounter = 0; //Next creature type
    while (nCounter < nNumber2)
            {
                oEnemy = CreateObject(OBJECT_TYPE_CREATURE, sCreature2, lSpawn, FALSE);
                DelayCommand(0.1,AssignCommand(oEnemy, ActionAttack(oPC)));
                nCounter ++;  //increment our counter
            }
    }
            if (sCreature3 != "Null")
            {
                int nCounter = 0; //Next creature type
                while (nCounter < nNumber3)
                {
                    oEnemy = CreateObject(OBJECT_TYPE_CREATURE, sCreature3, lSpawn, FALSE);
//                    DelayCommand(0.1,AssignCommand(oEnemy, ActionAttack(oPC)));
                DelayCommand(0.1,AssignCommand(oEnemy, ActionForceMoveToObject(oPC,TRUE,8.0,5.0)));
                    nCounter ++;  //increment our counter
                }
            }
}

// WandMonCheck        Do a check for wandering monsters
/* Inputs are:
        oPC     The character trying to sleep/travel
        iUnsafe Integer that if 1 tells us to check for monsters (comes from area variable "Unsafe" or overland travel dialogue)
        iChance Integer percentile chnce of monsters (comes from area variable "WMChance" or overland travel dialogue)
        sTable  String, encounter table to use (comes from area variable "WMTable" or overland travel dialogue)
*/

int WandMonCheck(object oPC,int iUnsafe = 0, int iChance = 0, string sTable = "Null", int nTravel = FALSE)
{
    int StateToReturn;
    object oArea = GetArea(oPC);
    vector vEndvector;
    // The following two lines get the chance of Wandering Monsters from an area.
    // They are not needed in Overland travel
    // when the values are sent to the function dependant on inn use, etc.
    if (iUnsafe==0) iUnsafe = GetLocalInt(oArea, "Unsafe"); //pick up the area safe variable
    if (iChance==0) iChance = GetLocalInt(oArea, "WMChance"); //pick up the area wandering monster chance variable

    // FloatingTextStringOnCreature(GetName(oPC) + ": Unsafe = " + IntToString(iUnsafe) + " & Chance = " + IntToString(iChance), oPC);
    // If the area is not safe, continue
    if (iUnsafe > 0)  // the area variable (this does not have to be set OnEnter any more - thanks for variables on areas!
    {
        int iRoll = d100();   //Now a percentile dice
        // debug lines (2)**************************************************
//        FloatingTextStringOnCreature("Roll " + IntToString(iRoll), oPC);
//        FloatingTextStringOnCreature("Chance " + IntToString(iChance), oPC);
        if (iRoll < iChance)   //Did we get a monster? If yes...
        {
            //define some variables we're going to use
            location lSpawn;
            string sEncounterTable;

            AssignCommand(oPC, ClearAllActions());
            // Set the location to spawn the wandering monsters.
            object oSpawn = GetNearestObjectByTag("WMSpawn",oPC);
            //Make sure we've called a valid object in our area and we're not leaving it
            if (GetIsObjectValid(oSpawn) && GetArea(oSpawn)==GetArea(oPC) && nTravel == FALSE)
                lSpawn = GetLocation(oSpawn);
            else //we'll use a vector instead
            {
                float fX;
                float fY;
                int iDirection=d4();
                switch(iDirection)  //move the creature away from the PC 10 in a cardinal direction.
                // In general avoid calling this as it requires very careful area design to avoid
                // getting monsters on rooves etc.
                {
                    case 1: fX=0.0; fY=10.0; break;
                    case 2: fX=10.0; fY=0.0; break;
                    case 3: fX=0.0; fY=-10.0; break;
                    case 4: fX=-10.0; fY=0.0; break;
                }
                vector vStart = GetPosition(oPC);
                vector vOffset = Vector(fX,fY);
                vector vEndvector=vStart+vOffset;
                lSpawn=Location(oArea, vEndvector, GetFacing(oPC));
            }
          //Right, we got a monster and we know where to put it. Let's generate it.

        //If the PC slept in this area, get the encounter table variable
        if (sTable == "Null") sEncounterTable = GetLocalString(oArea, "WMTable");
        // Else the function was sent the table (overland travel)
        //if this is not an overland encounter, generate it now.
        if (nTravel == FALSE)        GenerateMonster(lSpawn, oPC, sEncounterTable);
        else //we're in overland travel, we need to jump to an encounter area first.
            {
            string sTarget = "Enc_"+GetLocalString(oPC,"sEncounter")+IntToString(d2());
            object oTarget = GetWaypointByTag(sTarget);
            /* Removed, not satisfactory
            float fX = IntToFloat(d8()+4);
            float fY = IntToFloat(d8()+4);
            vector vShift = Vector(fX,fY);
            lSpawn=Location(GetArea(oTarget), GetPosition(oPC)+vShift, GetFacing(oPC));
            */
            //***********************debug line*****************
            //SendMessageToPC(oPC,"I found the area "+sTarget);
            AssignCommand(oPC,JumpToLocation(GetLocation(oTarget)));
            //executed seperately else random number generator does not work properly. (next line)
            DelayCommand(4.0,ExecuteScript("misc_monster",oPC));
//            lSpawn = GetLocation(GetWaypointByTag("WM"+sTarget));
//            DelayCommand(8.0,GenerateMonster(lSpawn, oPC, GetLocalString(oPC,"sEncounter")));
            }

        StateToReturn = 1;
        } //end of got a monster if
    } // end of safe if
    else StateToReturn = 0; //we didn't get a monster
    return StateToReturn;
}


