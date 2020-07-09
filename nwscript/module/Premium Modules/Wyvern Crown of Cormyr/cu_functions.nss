//::///////////////////////////////////////////////
//:: Name: cu_functions
//:: B G P Hughes (Modified for DLA Team)
//:://////////////////////////////////////////////
// This is the include file for general functions.
// Modification May 7th (goaneng) - clean up disarm/rearm
// Modification May 12th (B W-Husey) - removed dud lines, function names

/*
Functions included are:
PartyGotEntry:  to reward a party with xp for an action, describe why the xp was given,
                and set a variable so it is only given once for the action.
AllParty:       set a local variable on every member of a party - particularly useful to stop
                every party member having to have the same conversation.
AligXP:         to reward alignment xp, and shift alignment
ApplyTravel:    Sets up the variables on the PC for cost, time and destination,
                as prescribed by CalculateTravel()
CalculateTravel: calculates the distance between two points, and returns the cost of that travel
                dependant on whether the PC is mounted or not.
SkillCheck:     returns a random skill
GroupTransition: Jumps all associates with the PC - used for transitions within the same area.
CheckWeather:   Sets the fog distances & skybox dependant on the weather.
Refresh:        Used for overland travel, this function 'rests' the PC and associates.
ScoreAlign:     Records the maximum score and actual score dependant on alignment of the PC.
GetIsPartyTogether: Checks the other party members are in the same area within 20.
GetShards       Returns the number of shards a PC is carrying
GetInParty      Checks the party for a certain henchman
EffectAll          Gets PC and all associates and applys an effect to them
ReturnHenchmen  Returns and assigns only non horse henchmen of the PC.
ActionCreateCreature & ActionCreatePlaceable create objects as an action (useful for delaying)
GiveKnightReputation  Gives the PC a nickname
JonasRace       Make the correct racial copy of Jonas
GetIsDefPC      Make sure we really have a PC
RemoveOneFromStackableItem
DisarmParty     Remove weapon from hand and store in variable (if not a knight)
RearmParty      Restore weapons to hand
GetIsMobile     Creature can move with at least limited free will
RemoveEffectsByCreator Remove all on the target creature owned by owner
*/

#include "dla_i0_horse"

//============Declarations=======================================================

//This function is used to reward a party with xp for an action, describe why the xp was given, and set a variable
// so it is only given once for the action. It DOES NOT check the variable.
// Inputs are:  sGotEntry = The name of the Local Variable,
//              oPCGotEntry = the PC that called this function (speaker, chest opener, etc)
//              nXPToGive = xp for each party member
//              sTextMessage = Message to display, telling why xp was given
void PartyGotEntry(string sGotEntry,object oPCGotEntry, int nXPToGive, string sTextMessage);

//This function is used to to set a local variable on every member of a party - particularly useful to stop every party member having to have the same conversation.
// Inputs are:  sGotEntry = The name of the Local Variable,
//              oPCGotEntry = the PC that called this function (speaker, chest opener, etc)
//              nValue = value to set variable to
void AllParty(string sGotEntry,object oPCGotEntry, int nValue);

//This function is used to reward alignment xp, and shift alignment
// Inputs are:  sVar = The name of a local variable
//              oPCGotXP = the PC to affect
//              sAlig = the alignment to shift and/or reward
//              nXP = The xp reward
//              nShift = the alignment amount to shift
// Modify: if shift of 0 sent, no message wanted. If xp = 0 no message wanted.
// Examples:
// if you send AligXP(Variable, Player, "CHAOTIC",100,0) then if Player is a chaotic character will get 100xp and a message to tell them (the variable stops this happening more than once)
// Or AligXP(Variable, Player, "CHAOTIC",0,5) then Player will shift alignment 5 points towards chaotic and a message to tell them about the shift
// AligXP(Variable, Player, "CHAOTIC",100,5) will do both:
//                  Any PC will shift 5 towards chaotic and
//                  A chaotic character will gain 100xp.
void AligXP(string sVar, object oPCGotXP, string sAlig, int nXP, int nShift);

// Sets up the variables on the PC for cost, time and destination, as prescribed by CalculateTravel()
void ApplyTravel(string sFinish, int nTime, int nCost,object oPC);

// This function calculates the distance between two points, and returns the cost of that
// travel dependant on whether the PC is mounted or not.
// sStartName = Tag of starting area
// sFinish = Tag of finishing waypoint
// oPC = Where to set the variables and apply costs etc.
// Note travel to the final battle is not handled by this function
void CalculateTravel(string sStartName, string sFinish, object oPC, );

// This function returns a random skill
int SkillCheck();

// This function takes all associated belonging to the PC through the area transition
// It is used for transitions within the same area, where associates would otherwise get left behind
// It takes all henchmen (up to 4), and the first animal companion, familiar and summoned creature.
// oPC = the object that used the transition.
// oTarget = the destination of the transition.
void GroupTransition(object oPC, object oTarget);

// This function checks the weather and applies the correct skybox and fog distance
// oArea = the area just entered
// oPC = The PC that entered it
void CheckWeather(object oArea, object oPC);

// The StoreMyWeather function stores the local weather on the PC, so you can use it in the next area if desired.
// The GetMyWeather function restores the weather to the current area.
// oPC = the character to store/retrieve the weather.
// oArea = the area's weather you wish to store or set
void StoreMyWeather(object oPC, object oArea);

// Function records the PC's alignment score.
// oPC         The PC to score. Thos function is on the current PC only
// Max         Maximum available for this quest
// All others  What this alignment scored for this call (in order from lawful --> chaos, and good--> evil)
void ScoreAlign(object oPC,int Max=1, int LG=1,int NG=1,int CG=1,int LN=1,int TN=1,int CN=1,int LE=1,int NE=1,int CE=1);

// Used for checking all of the party are in the same area/close. Not sure if the mod will be multiplayer compatible
// but it pays to plan!
int GetIsPartyTogether(object oPC);

// Gets the number of shards the PC is carrying
int GetShards(object oTarget);

//Checks oPC's party for a certain henchman by tag sHenchTag
int GetInParty(string sHenchTag, object oPC);

// This function takes all associates belonging to the PC and the PC and applies the same effect to them
// It takes all henchmen (up to 4), and the first animal companion, familiar and summoned creature.
// oPC = PC to whom we wish to apply the effect (and their companions).
// eEffect = effect to apply.
// nDur = Duration type
// fDur = Duration
void EffectAll(object oPC, effect eEffect, int nDur, float fDur);

// Function refreshes (rests) the party and removes summoned/dominated creatures
void Refresh(object oPC);

//Gale:
//Function gets all the non horse henchmen of the PC (i.e. like GetHenchman but more specific)
// It does NOT return henchmen with <1 hit point
object ReturnHenchman(object oPC, int nPosition);

// Makes a creature as an action (use the resref)
void ActionCreateCreature(string sCreature, location lLoc, string sNewTag="",int nVis = FALSE);

// Makes a placeable as an action (use the resref)
void ActionCreatePlace(string sPlace, location lLoc, string sNewTag="",int nVis = FALSE);

//Executes travel using inns (cost, time & rest applied)
void DoTravelInn(object oPC);

//Executes travel using inns (cost, time; no rest applied)
void DoTravelNoInn(object oPC);

// Give PC a knightly reputation
void GiveKnightReputation(object oPC, string sRep);


//Gets the racial variant of Jonas to match the PC
// inputs are race desired and location to spawn
object JonasRace(int nRace, location lLoc, string sTag="Jonas");

// returns true if oPC is a PC
int GetIsDefPC(object oPC);

//Gale 21 March, 2006:
//Removes 1 unity of the item with the tag sTag on oOwner inventory.
//Removes the plot flag before destroying it, if needed be.
//Returns a boolean meaning if the item was destroyed or not.
//(in case the creature don't have the item)
int RemoveOneFromStackableItem(object oOwner, string sTag);

//Take weapons out of hand of PC's party
void DisarmParty(object oPC);

// Put back weapons of PC's party in hand
void RearmParty(object oPC);

//check if oPC is mobile/capable of movement under at least limited willpower (excl. fear, slow)
int GetIsMobile(object oPC);

// Make nice to standard friendly factions  PC and henchmen - use on PC
void BeHappy(object oPC);

// Resets camera angle on transitions when the PC enters the next area.  Set
// a local INT nNewAreaCameraFacing for the degree angle on the target area to
// the transition object (door or trigger) in the current area.  Automatically
// called in nw_g0_transition, so no special transition script is required.
// do NOT use 0 for nNewAreaCameraFacing, use 1.  E=1,N=90,W=160,S=270
void DLA_SetAreaTransCameraFacing(object oPC, object oDestination, int nTransCam = CAMERA_TRANSITION_TYPE_SNAP, object oSource=OBJECT_SELF);


// New wrapper for GetIsSkillSuccessful for cloak build.  If bFeedback = TRUE,
// player will get feedback.  If not, it is hidden.
int GetSkillCheckSucceeded(object oObject, int nSkill, int nDC, int bFeedback=TRUE);

//==========================end declarations=====================================


//This function is used to reward a party with xp for an action, describe why the xp was given, and set a variable
// so it is only given once for the action. It DOES NOT check the variable.
// Inputs are:  sGotEntry = The name of the Local Variable,
//              oPCGotEntry = the PC that called this function (speaker, chest opener, etc)
//              nXPToGive = xp for each party member
//              sTextMessage = Message to display, telling why xp was given

void PartyGotEntry(string sGotEntry,object oPCGotEntry, int nXPToGive, string sTextMessage)
{
    object oPartyMember = GetFirstFactionMember(oPCGotEntry, TRUE); // oPartyMember is the PC that called this function
    //***********debug line*******************
    //SendMessageToPC(oPCGotEntry,"PartyGotEntry call "+sGotEntry+" to 1 (default for this call)");

    while (GetIsObjectValid(oPartyMember) == TRUE) // While there are more members in the party
  {
    GiveXPToCreature(oPartyMember,nXPToGive); //Give xp to each member
    SetLocalInt(oPartyMember,sGotEntry,1);  // Sets a local variable in case you want to check for it (i.e. give the bonus once only)
    FloatingTextStringOnCreature(sTextMessage, oPartyMember, TRUE); //Tell the player what the xp was for with a string above his PC's head
    oPartyMember = GetNextFactionMember(oPCGotEntry, TRUE); // Find next party member
  }
}

//This function is used to to set a local variable on every member of a party - particularly useful to stop every party member having to have the same conversation.
// Inputs are:  sGotEntry = The name of the Local Variable,
//              oPCGotEntry = the PC that called this function (speaker, chest opener, etc)
//              nValue = value to set variable to

void AllParty(string sGotEntry,object oPCGotEntry, int nValue)
{
  SetLocalInt(oPCGotEntry, sGotEntry, nValue);
  object oPartyMember = GetFirstFactionMember(oPCGotEntry, TRUE);
  //***********debug line*******************
  //  SendMessageToPC(oPCGotEntry,"AllParty call "+sGotEntry+" to "+IntToString(nValue));
  while (GetIsObjectValid(oPartyMember) == TRUE)
  {
    SetLocalInt(oPartyMember,sGotEntry,nValue);  // Sets a local variable on each party member
    oPartyMember = GetNextFactionMember(oPCGotEntry, TRUE);
  }
}

//This function is used to reward alignment xp, and shift alignment
// Inputs are:  sVar = The name of a local variable
//              oPCGotXP = the PC to affect
//              sAlig = the alignment to shift and/or reward
//              nXP = The xp reward
//              nShift = the alignment amount to shift
// Modify: if shift of 0 sent, no message wanted. If xp = 0 no message wanted.
// Examples:
// if you send AligXP(Variable, Player, "CHAOTIC",100,0) then if Player is a chaotic character will get 100xp and a message to tell them (the variable stops this happening more than once)
// Or AligXP(Variable, Player, "CHAOTIC",0,5) then Player will shift alignment 5 points towards chaotic and a message to tell them about the shift
// AligXP(Variable, Player, "CHAOTIC",100,5) will do both:
//                  Any PC will shift 5 towards chaotic and
//                  A chaotic character will gain 100xp.


void AligXP(string sVar, object oPCGotXP, string sAlig, int nXP, int nShift)
{
  if (GetLocalInt(oPCGotXP, sVar)==FALSE) {
    SetLocalInt(oPCGotXP, sVar, TRUE);
    int nAlig;
// This section deals with what alignment gets the xp, or towards which alignment the shift takes place
    if (sAlig == "CHAOTIC") nAlig = ALIGNMENT_CHAOTIC;
    else if (sAlig == "GOOD") nAlig = ALIGNMENT_GOOD;
    else if (sAlig == "LAWFUL") nAlig = ALIGNMENT_LAWFUL;
    else if (sAlig == "EVIL") nAlig = ALIGNMENT_EVIL;
    else if (sAlig == "NEUTRAL") nAlig = ALIGNMENT_NEUTRAL;

    if (GetAlignmentGoodEvil(oPCGotXP) == nAlig)
        {
            if (nXP==0) PartyGotEntry(sVar,oPCGotXP,nXP, ""); // No xp = no message
            else PartyGotEntry(sVar,oPCGotXP,nXP, "XP gained - Playing alignment");
        }
    else if (GetAlignmentLawChaos(oPCGotXP) == nAlig)
        {
            if (nXP==0) PartyGotEntry(sVar,oPCGotXP,nXP, ""); // No xp = no message
            else PartyGotEntry(sVar,oPCGotXP,nXP, "XP gained - Playing alignment");
        }
    if (nShift!=0) AdjustAlignment(oPCGotXP, nAlig, nShift); //only execute if shift is not 0 otherwise you get a message in the console.
    }
}

// Sets up the variables on the PC for cost, time and destination, as prescribed by CalculateTravel()

void ApplyTravel(string sFinish, int nTime, int nCost, object oPC)
{
    SetLocalString(oPC,"sDestination",sFinish);
    SetLocalInt(oPC,"nTravelTime",nTime);
    SetLocalInt(oPC,"nTravelCost",nCost);
    SetCustomToken(1002,IntToString(nTime/24));
    SetCustomToken(1003,IntToString(nCost));
    SetCustomToken(1004,"night");
    if (nTime>36) SetCustomToken(1004,"nights");
//    if (nTime<12) SetCustomToken(1004,"nights");
    if (GetIsObjectValid(DLA_GetHorseHenchman(oPC)) || DLA_GetIsMounted(oPC))
        SetCustomToken(1051,"horseback");
    else SetCustomToken(1051,"foot");
//    SendMessageToPC(oPC,IntToString(nTime)+" hours");
}

// This function calculates the distance between two points, and returns the cost of that
// travel dependant on whether the PC is mounted or not.
// sStartName = Tag of starting area
// sFinish = Tag of finishing waypoint
// oPC = Where to set the variables and apply costs etc.
// Note travel to the final battle is not handled by this function

void CalculateTravel(string sStartName, string sFinish, object oPC)
{
    SetLocalInt(oPC,"nTravelHasInn",0); // by default every route has inns, so set it.
    string sStart; //This will be the general start area
    string sStop; //This will be the general stop area
    int nTime;
    int nCost;

    string sStartName6 = GetStringLeft(sStartName,6);
    string sStartName7 = GetStringLeft(sStartName,7);

    // Work out the starting general area from the options that have overland travel
    if ( sStartName6 == "Thunde") sStart = "Thunder";
    else if (sStartName7 == "Polters") sStart = "Polters";
    else if (sStartName7 == "Hawklin") sStart = "Thunder";
    else if (sStartName7 == "Hullack") sStart = "Hullack";
    else if (sStartName7 == "LakeWyv") sStart = "Wyvern";
    else if (sStartName7 == "CastleW") sStart = "Wyvern";
    else if (sStartName6 == "Morfen") sStart = "Morfen";
    else sStart = "Null"; //we don't care about anywhere else
    //*******debug lines
    //SendMessageToPC(oPC,"Picked up start: "+sStartName6);
    //Work out the finishing general area from the waypoint we are going to be sent to

    string sFinish5 = GetStringLeft(sFinish,5);
    string sFinish4 = GetStringLeft(sFinish,4);

    if      (sFinish5 == "WP_PF") sStop = "Polters";
    else if (sFinish4 == "WP_T" ) sStop = "Thunder";
    else if (sFinish5 == "WP_HC") sStop = "Thunder";
    else if (sFinish5 == "WP_ON") sStop = "Thunder";
    else if (sFinish5 == "WP_LW") sStop = "Wyvern";
    else if (sFinish5 == "WP_CW") sStop = "Wyvern";
    else if (sFinish5 == "WP_HF") sStop = "Hullack";
    else if (sFinish5 == "TP_Hu") sStop = "Hullack";
    else sStop = "Null"; //we don't care about anywhere else
    // Set start and finish to null if they are the same
    if (sStart == sStop)
        {
        sStart = "Null";
        sStop = "Null";
        }

    //*******debug lines
    //SendMessageToPC(oPC,"Start: "+sStart);
    //SendMessageToPC(oPC,"End: "+sStop);

    if (sStop == "Null" || sStart == "Null") // Don't bother with the rest of the checks, just go there.
    {
        object oWaypoint = GetWaypointByTag(sFinish);
        AssignCommand(oPC,ActionJumpToLocation(GetLocation(oWaypoint)));
    }
    // The following applies the time and cost for overland travel via inns
    else if (sStart == "Morfen" && sStop == "Thunder") //this is a one way travel only
    {
        nCost = 2;
        nTime = 24;
    }
    //Thunderstone to Hullack Forest (or reverse)
    else if ((sStart == "Thunder" && sStop == "Hullack") || (sStart == "Hullack" && sStop == "Thunder"))
    {
        nCost = 10;
        nTime = 48;
        SetLocalInt(oPC,"nTravelHasInn",1);
        SetLocalString(oPC,"sEncounter","Forest");}
        //Thunderstone to Polter's (or reverse) - NO inns on this route
    else if ((sStart == "Thunder" && sStop == "Polters") || (sStart == "Polters" && sStop == "Thunder"))
    {
        nCost = 15;
        nTime = 60;
        SetLocalString(oPC,"sEncounter","Forest");
    }
    // Thunderstone to Wyvernwater (or reverse)
    else if ((sStart == "Thunder" && sStop == "Wyvern") || (sStart == "Wyvern" && sStop == "Thunder"))
    {
        nCost = 16;
        SetLocalString(oPC,"sEncounter","Roads");
        SetLocalInt(oPC,"nTravelHasInn",1);
        nTime = 60;
    }
//debug    else SendMessageToPC(oPC,"THIS LINK IS BROKEN");

    //modify travel cost and time for horses.
    if (DLA_GetNumHorsesOwned(oPC) > 0 )
    {
        nTime = nTime/2;
        nCost=nCost*2;
    }

// if not using inns.

// if travelling with Kathryn, check for werewolf sidequest.
    ApplyTravel(sFinish,nTime,nCost,oPC);
}


// This function returns a random skill
int SkillCheck()
{
    int nSkill = 0;
    switch (Random(28)+1)
    {
        case 1: nSkill = SKILL_CONCENTRATION     ; break;
        case 2: nSkill = SKILL_DISCIPLINE        ; break;
        case 3: nSkill = SKILL_HEAL              ; break;
        case 4: nSkill = SKILL_LISTEN            ; break;
        case 5: nSkill = SKILL_LORE              ; break;
        case 6: nSkill = SKILL_OPEN_LOCK         ; break;
        case 7: nSkill = SKILL_PARRY             ; break;
        case 8: nSkill = SKILL_PERSUADE          ; break;
        case 9: nSkill = SKILL_PERFORM           ; break;
        case 10: nSkill = SKILL_SEARCH           ; break;
        case 11: nSkill = SKILL_SPELLCRAFT       ; break;
        case 12: nSkill = SKILL_SPOT             ; break;
        case 13: nSkill = SKILL_TUMBLE           ; break;
        case 14: nSkill = SKILL_USE_MAGIC_DEVICE ; break;
        case 15: nSkill = SKILL_ALL_SKILLS       ; break;
        case 16: nSkill = SKILL_DISABLE_TRAP     ; break;
        case 17: nSkill = SKILL_ANIMAL_EMPATHY   ; break;
        case 18: nSkill = SKILL_APPRAISE         ; break;
        case 19: nSkill = SKILL_BLUFF            ; break;
        case 20: nSkill = SKILL_CRAFT_TRAP       ; break;
        case 21: nSkill = SKILL_HIDE             ; break;
        case 22: nSkill = SKILL_INTIMIDATE       ; break;
        case 23: nSkill = SKILL_MOVE_SILENTLY    ; break;
        case 24: nSkill = SKILL_PICK_POCKET      ; break;
        case 25: nSkill = SKILL_SET_TRAP         ; break;
        case 26: nSkill = SKILL_TAUNT            ; break;
        case 27: nSkill = SKILL_CRAFT_WEAPON     ; break;
        case 28: nSkill = SKILL_CRAFT_ARMOR      ; break;
    }
    return nSkill;
}

// This function takes all associated belonging to the PC through the area transition
// It is used for transitions within the same area, where associates would otherwise get left behind
// It takes all henchmen (up to 4), and the first animal companion, familiar and summoned creature.
/*  Inputs are:
        oPC = the object that used the transition.
        oTarget = the destination of the transition.
        */

void GroupTransition(object oPC, object oTarget)
{
AssignCommand(oPC,JumpToObject(oTarget));
object oAssociate1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
object oAssociate2 = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
object oAssociate3 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
object oAssociate4 = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
/*
object oAssociate5 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,1);
object oAssociate6 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,2);
object oAssociate7 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,3);
object oAssociate8 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,4);
object oAssociate9 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,5);
*/
AssignCommand(oAssociate1, JumpToObject(oTarget));
AssignCommand(oAssociate2, JumpToObject(oTarget));
AssignCommand(oAssociate3, JumpToObject(oTarget));
AssignCommand(oAssociate4, JumpToObject(oTarget));
/*
AssignCommand(oAssociate5, JumpToObject(oTarget));
AssignCommand(oAssociate6, JumpToObject(oTarget));
AssignCommand(oAssociate7, JumpToObject(oTarget));
AssignCommand(oAssociate8, JumpToObject(oTarget));
AssignCommand(oAssociate9, JumpToObject(oTarget));
*/
int i;
object oHench;
for (i = 1; GetIsObjectValid(oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC, i)); i++)
AssignCommand(oHench, JumpToObject(oTarget));
}

// This function checks the weather and applies the correct skybox and fog distance
/*  Inputs are:
        oArea = the area just entered
        oPC = The PC that entered it
        */

void CheckWeather(object oArea, object oPC)
{
    int nSky = SKYBOX_NONE;
    int nFog = 5;
    int nWeather = GetWeather(oArea);
    int nRand;
    //First day check removed - not needed here, just use default
    /*
    if (GetLocalInt(oPC,"nWeatherDay")<1) //First time let's have nice weather for the tournament
    // so we can enjoy it!
    {
    //Debug line *********************
    SendMessageToPC(oPC,"Nice weather for day 1");

                nFog = 0;
                nSky = SKYBOX_GRASS_CLEAR;
                SetWeather(oArea,WEATHER_CLEAR);
    }
    */
    //no bad weather on tournament days
    if (GetLocalInt(oPC,"nMainPlot")==1) return;
    if (GetLocalInt(oPC,"nMainPlot")==7) return;

    if (nWeather == WEATHER_RAIN)
    {
        nSky = SKYBOX_GRASS_STORM;
        nFog = 20;
    //Debug line *********************
//    SendMessageToPC(oPC,"It's raining");

    }
    else if (nWeather == WEATHER_CLEAR)
    {
            int nRand = Random(10);
            if (nRand<2) //Foggy day - set appropriate settings
            {
                nFog = 20;
                nSky = SKYBOX_NONE;
    //Debug line *********************
//    SendMessageToPC(oPC,"It's foggy");

            }
            else if (nRand<4) //Overcast day - set appropriate settings
            {
                nFog = 10;
                nSky = SKYBOX_ICY;
    //Debug line *********************
//    SendMessageToPC(oPC,"It's overcast");

            }
            else //standard day
            {
                nFog = 5;
                nSky = SKYBOX_GRASS_CLEAR;
    //Debug line *********************
//    SendMessageToPC(oPC,"It's a nice day");

            } // end of random ifs
    } // end of weather type ifs
    SetSkyBox(nSky,oArea);
    SetFogAmount(FOG_TYPE_SUN,nFog,oArea);
    SetFogAmount(FOG_TYPE_MOON,nFog,oArea);
//    SendMessageToPC(GetFirstPC(),"Number: "+IntToString(nRand));
//    SendMessageToPC(GetFirstPC(),"Weather: "+IntToString(nFog));
}

// The StoreMyWeather function stores the local weather on the PC, so you can use it in the next area if desired.
// The GetMyWeather function restores the weather to the current area.
/*  Inputs are:
        oPC = the character to store/retrieve the weather.
        oArea = the area's weather you wish to store or set
        */

void StoreMyWeather(object oPC, object oArea)
{
    SetLocalInt(oPC,"nFog",GetFogAmount(FOG_TYPE_SUN,oArea));
    SetLocalInt(oPC,"nSky",GetSkyBox(oArea));
    SetLocalInt(oPC,"nWeather",GetWeather(oArea));
    //debug line ****************************
    //SendMessageToPC(oPC,"Stored: "+IntToString(GetLocalInt(oPC,"nFog"))+" Fog");
    //SendMessageToPC(oPC,"Stored: "+IntToString(GetLocalInt(oPC,"nWeather")));
}
void GetMyWeather(object oPC, object oArea)
{
    int nFog = GetLocalInt(oPC,"nFog");
    int nSky =GetLocalInt(oPC,"nSky");
    int nWeather = GetLocalInt(oPC,"nWeather");
    SetSkyBox(nSky,oArea);
    SetFogAmount(FOG_TYPE_SUN,nFog,oArea);
    SetFogAmount(FOG_TYPE_MOON,nFog*2,oArea);
    SetWeather(oArea,nWeather);
    //debug line ****************************
   //SendMessageToPC(oPC,"Retrieved: "+IntToString(nFog)+" Fog");
    //SendMessageToPC(oPC,"Retrieved: "+IntToString(nWeather));
}

// Function refreshes (rests) the party and removes summoned/dominated creatures
void Refresh(object oPC)
{
    ForceRest(oPC);
    object oAssociate1 = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    object oAssociate2 = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    object oAssociate3 = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    object oAssociate4 = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    object oAssociate5 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,1);
    object oAssociate6 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,2);
    object oAssociate7 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,3);
    object oAssociate8 = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC,4);
    ForceRest(oAssociate1);
    ForceRest(oAssociate3);
    ForceRest(oAssociate5);
    ForceRest(oAssociate6);
    ForceRest(oAssociate7);
    ForceRest(oAssociate8);
    if (GetIsObjectValid(oAssociate4)) DestroyObject(oAssociate4);
    if (GetIsObjectValid(oAssociate2)) RemoveHenchman(oAssociate2);
}

// Function records the PC's alignment score.
/* Inputs are:
        oPC         The PC to score. Thos function is on the current PC only
        Max         Maximum available for this quest
        All others  What this alignment scored for this call
*/

void ScoreAlign(object oPC,int Max=1, int LG=1,int NG=1,int CG=1,int LN=1,int TN=1,int CN=1,int LE=1,int NE=1,int CE=1)
{
    SetLocalInt(oPC,"AllScore",GetLocalInt(oPC,"AllScore")+Max);
    int nScore;
    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
             if (GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL)  nScore = LG;
        else if (GetAlignmentLawChaos(oPC) == ALIGNMENT_NEUTRAL) nScore = NG;
        else if (GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC) nScore = CG;
    }
    else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL)
    {
             if (GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL) nScore = LN;
        else if (GetAlignmentLawChaos(oPC) == ALIGNMENT_NEUTRAL) nScore = TN;
        else if (GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC) nScore = CN;
    }
    else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
    {
             if (GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL) nScore = LE;
        else if (GetAlignmentLawChaos(oPC) == ALIGNMENT_NEUTRAL) nScore = NE;
        else if (GetAlignmentLawChaos(oPC) == ALIGNMENT_CHAOTIC) nScore = CE;
    }

    SetLocalInt(oPC,"MyScore",GetLocalInt(oPC,"MyScore")+nScore);
    //SendMessageToPC(oPC,"Score: "+IntToString(nScore));
    SendMessageToPC(oPC,"Alignment "+IntToString(GetLocalInt(oPC,"MyScore"))+" out of "+IntToString(GetLocalInt(oPC,"AllScore")));
}

// Used for checking all of the party are in the same area/close. Not sure if the mod will be multiplayer compatible
// but it pays to plan!
int GetIsPartyTogether(object oPC)
{
  object oFirstMember = oPC;
  object oPartyMember = GetFirstFactionMember(oFirstMember, TRUE);
  int iTogether = TRUE;

  while (GetIsObjectValid(oPartyMember) == TRUE)
  {
    if(iTogether == TRUE)
    {
      if(GetArea(oFirstMember) != GetArea(oPartyMember))
      {
        iTogether = FALSE;
      }
      else
      {
        if(GetDistanceBetween(oFirstMember, oPartyMember) > 20.0)
          iTogether = FALSE;
      }
    }
    oPartyMember = GetNextFactionMember(oFirstMember, TRUE);
  }
  return iTogether;
}

// Gets the number of shards the PC is carrying

int GetShards(object oTarget)
{
    int nNumItems = 0;
    object oItem = GetFirstItemInInventory(oTarget);

    while (GetIsObjectValid(oItem))
    {
        if (GetStringLeft(GetTag(oItem),5) == "Shard")
        {
            nNumItems = nNumItems + GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oTarget);
    }

   return nNumItems;
}

//Checks oPC's party for a certain henchman by tag sHenchTag
int GetInParty(string sHenchTag, object oPC)
{
     int i;
     object oHench;
     while (GetIsObjectValid(oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC, ++i)))
         if (GetTag(oHench) == sHenchTag)
            return TRUE;
     return FALSE;
}


// This function takes all associates belonging to the PC and the PC and applies the same effect to them
// It takes all henchmen (up to 4), and the first animal companion, familiar and summoned creature.
/*  Inputs are:
        oPC = PC to whom we wish to apply the effect (and their companions).
        eEffect = effect to apply.
        nDur = Duration type
        fDur = Duration
        */

void EffectAll(object oPC, effect eEffect, int nDur, float fDur)
{
    object oAssoc = GetFirstFactionMember(oPC, FALSE);
    int i;
    for (i=1; i < 6; i++)
      do
         ApplyEffectToObject(nDur,eEffect, oAssoc, fDur);
      while (GetIsObjectValid(oAssoc = GetNextFactionMember(oPC, FALSE)));

    ApplyEffectToObject(nDur,eEffect, oPC, fDur);
}

//Gale:
//Returns the specified henchman that is not a horse (nPosition)
object ReturnHenchman(object oPC, int nPosition)
{

   int nHenchNum;
   object oHenchman;
   int i;

   while (GetIsObjectValid(oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC,++i)))
     if (DLA_GetIsDLAHorse(oHenchman)==FALSE && GetCurrentHitPoints(oHenchman)>0) //If it's NOT a horse and not dead
       if (++nHenchNum == nPosition) //increment henchman count and check whether this is the one looked for
          return oHenchman; // if so, return the object

    return OBJECT_INVALID;
}


// Makes a creature as an action
void ActionCreateCreature(string sCreature, location lLoc, string sNewTag="",int nVis = FALSE)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLoc, nVis,sNewTag);
}

// Makes a placeable as an action
void ActionCreatePlace(string sPlace, location lLoc, string sNewTag="", int nVis = FALSE)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sPlace, lLoc, nVis,sNewTag);
}

//Travel execution functions were moved here so they can be called from dialogue or trigger
void DoTravelNoInn(object oPC)
{
    int nTime = GetTimeHour();
    object oWaypoint = GetWaypointByTag(GetLocalString(oPC,"sDestination"));
    SetTime(nTime+GetLocalInt(oPC,"nTravelTime")/2,0,0,0);     //quicker if we don't use inns
    AssignCommand(oPC,JumpToLocation(GetLocation(oWaypoint)));
//    if (GetIsObjectValid(oWaypoint))     SendMessageToPC(oPC,"Valid waypoint");
//    SendMessageToPC(oPC,"WP is "+ GetLocalString(oPC,"sDestination"));
}

void DoTravelInn(object oPC)
{
    int nTime = GetTimeHour();
    object oWaypoint = GetWaypointByTag(GetLocalString(oPC,"sDestination"));
    SetTime(nTime+GetLocalInt(oPC,"nTravelTime"),0,0,0);
    TakeGoldFromCreature(GetLocalInt(oPC,"nTravelCost"),oPC,TRUE);
    AssignCommand(oPC,JumpToLocation(GetLocation(oWaypoint)));
    Refresh(oPC);
//    if (GetIsObjectValid(oWaypoint))     SendMessageToPC(oPC,"Valid waypoint");
//    SendMessageToPC(oPC,"WP is "+ GetLocalString(oPC,"sDestination"));
}

// Give PC a knightly reputation
void GiveKnightReputation(object oPC, string sRep)
{
    if (GetLocalString(oPC,"sKnightsRep") != sRep) // don't give the same reputation twice
    {
        //(message): You have gained a new reputation:
        SendMessageToPC(oPC,GetStringByStrRef(16797872)+ " " + sRep);
        SetCustomToken(1053,sRep+" ");
        SetLocalString(oPC,"sKnightsRep",sRep);
        SetLocalInt(oPC,"nHasRep",1);
    }
}

//Gets the racial variant of Jonas to match the PC
// inputs are race desired and location to spawn
//Gale 19 April 2006: Changing to return the creature created, and allow
//setting a custom Tag for it.
object JonasRace(int nRace, location lLoc, string sTag="Jonas")
{
    object oJonas;
    switch (nRace)
    {
        case (RACIAL_TYPE_DWARF):
            oJonas = CreateObject(OBJECT_TYPE_CREATURE,"jonasdwarf",lLoc,FALSE,sTag);
        break;
        case (RACIAL_TYPE_ELF):
            oJonas = CreateObject(OBJECT_TYPE_CREATURE,"jonaself",lLoc,FALSE,sTag);
        break;
        case (RACIAL_TYPE_GNOME):
            oJonas = CreateObject(OBJECT_TYPE_CREATURE,"jonasgnome",lLoc,FALSE,sTag);
        break;
        case (RACIAL_TYPE_HALFELF):
            oJonas = CreateObject(OBJECT_TYPE_CREATURE,"jonashalfelf",lLoc,FALSE,sTag);
        break;
        case (RACIAL_TYPE_HALFLING):
            oJonas = CreateObject(OBJECT_TYPE_CREATURE,"jonashalfling",lLoc,FALSE,sTag);
        break;
        case (RACIAL_TYPE_HALFORC):
            oJonas = CreateObject(OBJECT_TYPE_CREATURE,"jonashalforc",lLoc,FALSE,sTag);
        break;
        case (RACIAL_TYPE_HUMAN):
            oJonas = CreateObject(OBJECT_TYPE_CREATURE,"jonashuman",lLoc,FALSE,sTag);
        break;

    }
    SetName(oJonas,"Jonas");
    return oJonas;
}

// make sure we actually got the PC, not a DM etc
int GetIsDefPC(object oPC)
{
    if (GetIsPC(oPC) && GetIsDM(oPC)==FALSE && GetIsDMPossessed(oPC) == FALSE)
    return TRUE;
    return FALSE;
}

//Gale 21 March, 2006:
//Removes 1 unity of the item with the tag sTag on oOwner inventory.
//Removes the plot flag before destroying it, if needed be.
//Returns a boolean meaning if the item was destroyed or not.
//(in case the creature don't have the item)
int RemoveOneFromStackableItem(object oOwner, string sTag)
{
    object oItem = GetItemPossessedBy(oOwner, sTag);
    if (!GetIsObjectValid(oItem)) return 0;
    int nStack = GetItemStackSize(oItem);

    if (nStack > 1)
        SetItemStackSize(oItem, nStack - 1 );
    else
    {
        SetPlotFlag(oItem, FALSE);
        DestroyObject(oItem);
    }
    return 1;
}

/*
    Modified By : gaoneng erick
    Modified On : may 7, 2006

    fixes : party wasn't properly reequipping items
*/
// start modification

// gaoneng : added helm to the list too :)
// calling creature unequips helm, main hand and offhand
void UnequipItems()
{
    object self = OBJECT_SELF;
    object helm      = GetItemInSlot(INVENTORY_SLOT_HEAD),
           handright = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND),
           handleft  = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    ClearAllActions();
    if (GetIsObjectValid(helm))
    {
        SetLocalObject(self, "oHelm", helm);
        ActionUnequipItem(helm);
    }
    if (GetIsObjectValid(handright))
    {
        SetLocalObject(self, "oArmed", handright); // variable names preserved from old functions for compatibilitiy
        ActionUnequipItem(handright);
    }
    if (GetIsObjectValid(handleft))
    {
        SetLocalObject(self, "oLArmed", handleft);
        ActionUnequipItem(handleft);
    }
}

// gaoneng : check if new items in slot, if so, store those and abort force equip
// calling creature reequips helm, main hand and offhand if slots are empty
void ReequipItems()
{
    object self = OBJECT_SELF;
    object helm      = GetItemInSlot(INVENTORY_SLOT_HEAD),
           handright = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND),
           handleft  = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    ClearAllActions();
    if (GetIsObjectValid(helm)) SetLocalObject(self, "oHelm", helm);
    else ActionEquipItem(GetLocalObject(self, "oHelm"), INVENTORY_SLOT_HEAD);
    if (GetIsObjectValid(handright)) SetLocalObject(self, "oArmed", handright);
    else ActionEquipItem(GetLocalObject(self, "oArmed"), INVENTORY_SLOT_RIGHTHAND);
    if (GetIsObjectValid(handleft)) SetLocalObject(self, "oLArmed", handleft);
    else ActionEquipItem(GetLocalObject(self, "oLArmed"), INVENTORY_SLOT_LEFTHAND);
}

// Disarm party if the PC is not a knight - does 2 henchies as well.
void DisarmParty(object oPC)
{
//    if (GetLocalInt(oPC,"nMainPlot")>4) return;   // a knight - exit routine
    if (GetIsDefPC(oPC))
    {
        object oHench1 = ReturnHenchman(oPC,1);
        object oHench2 = ReturnHenchman(oPC,2);

// added by erick : no need to dupe lines
        AssignCommand(oPC, UnequipItems());
        AssignCommand(oHench1, UnequipItems());
        AssignCommand(oHench2, UnequipItems());
     }
}

// Rearm party if the PC is not a knight
void RearmParty(object oPC)
{
    if (GetLocalInt(oPC,"nMainPlot")>4) return;  // a knight - exit routine
    //Get Henchies
    object oHench1 = ReturnHenchman(oPC,1);
    object oHench2 = ReturnHenchman(oPC,2);

// added by erick : no need to dupe lines
    AssignCommand(oPC, ReequipItems());
    AssignCommand(oHench1, ReequipItems());
    AssignCommand(oHench2, ReequipItems());
}

// end modification by gaoneng

//check if oPC is mobile/capable of movement under at least limited willpower
int GetIsMobile(object oPC)
{
        effect eEffect = GetFirstEffect(oPC);
        //Search for negative effects that stop free choice movement - including dominate type effects
        // does NOT include fear or slow.
        while(GetIsEffectValid(eEffect))
        {
            if (GetEffectType(eEffect) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eEffect) == EFFECT_TYPE_CHARMED ||
                GetEffectType(eEffect) == EFFECT_TYPE_CONFUSED ||
                GetEffectType(eEffect) == EFFECT_TYPE_DAZED ||
                GetEffectType(eEffect) == EFFECT_TYPE_DOMINATED ||
                GetEffectType(eEffect) == EFFECT_TYPE_PETRIFY ||
                GetEffectType(eEffect) == EFFECT_TYPE_STUNNED ||
                GetEffectType(eEffect) == EFFECT_TYPE_TIMESTOP)
                {
                    return FALSE;
                }
            eEffect = GetNextEffect(oPC);
        }
    return TRUE;
}

//Used to prevent dropping of plot items (Dradjeel)
void RetakeItem(object oPC, object oItem, object oPoss)
{
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectCutsceneImmobilize(), oPC, 0.1);
            AssignCommand(oPC, ClearAllActions(TRUE));
            if (GetIsObjectValid(oPoss))
            {
                AssignCommand(oPC, ActionTakeItem(oItem, oPoss));
            }
            else
            {
                AssignCommand(oPC, ActionPickUpItem(oItem));
            }
            AssignCommand(oPC, ActionDoCommand(SetCommandable(TRUE)));
            AssignCommand(oPC, SpeakString("Best to keep this, it might be useful later."));
            AssignCommand(oPC, SetCommandable(FALSE));
}

void BeHappy(object oPC)
{
        object oHench;
        int i;
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPC);
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPC);
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPC);
        for (i = 1; GetIsObjectValid(oHench = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC, i)); i++)
        {
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oHench);
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oHench);
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oHench);
        }
}

//Syrsnein 9 May 2006:
// Removes all effects on oCreature that were placed there by oOwner and returns
//  the number of effects removed
int RemoveEffectsByCreator(object oCreature, object oOwner)
{
    int i = 0;
    effect eEffect = GetFirstEffect(oCreature);
    while (GetIsEffectValid(eEffect))
    {
        if (GetEffectCreator(eEffect)==oOwner)
        {
            RemoveEffect(oCreature, eEffect);
            i++;
        }
        eEffect = GetNextEffect(oCreature);
    }
    return i;
}
//Vulcano 24 May 2006:
// resets camera angle on transitions
void DLA_SetAreaTransCameraFacing(object oPC, object oDestination, int nTransCam = CAMERA_TRANSITION_TYPE_SNAP, object oSource=OBJECT_SELF)
{
    object oArea = GetArea(oDestination);
    int nFacing = GetLocalInt(oSource,"nNewAreaCameraFacing");
    if(!nFacing)
    {
        return;
    }
    if(GetArea(oPC)!=oArea)
    {
        DelayCommand(0.2,DLA_SetAreaTransCameraFacing(oPC,oDestination,nTransCam,oSource));
        return;
    }
    DelayCommand(0.5, AssignCommand(oPC, SetCameraFacing(IntToFloat(nFacing),-1.0f,-1.0f,nTransCam)));
}

//Modified 13th June to message not floatie & defaults to true
int GetSkillCheckSucceeded(object oObject, int nSkill, int nDC, int bFeedback=TRUE)
{
    int nRanks = GetSkillRank(nSkill, oObject);
    int nDie = d20();
    int bReturn;
    string sRoll = "Skill check: 1d20("+IntToString(nDie)+") + "+IntToString(nRanks)+" = " + IntToString(nRanks+nDie) + " ";
    if(nRanks+nDie>=nDC)
    {
        sRoll += "vs DC "+IntToString(nDC)+" = **Success**";
        bReturn = TRUE;
    }
    else
    {
        sRoll += "vs DC "+IntToString(nDC)+" = **Failure**";
        bReturn = FALSE;
    }
    if(bFeedback)    SendMessageToPC(oObject,sRoll);

    return bReturn;
}

// Uncomment only to test compile
// void main() {}
