/*
    DLA_OBJFINALPED.nss
    OnClose script for finale pedestals
    "gaoneng" Erick            March 20, 2006

    Checks for gems in the pedestals. If all gems are in the correct pedestals,
    platform rises to allow access to center island.
*/

/*
    tags/resrefs of related stuff
    1 - RUBY     2 - EMERALD  3 - DIAMOND  4 - SAPPHIRE
    GolemGem1    GolemGem2    GolemGem3    GolemGem4          // the golem gems
    CBPedestal1  CBPedestal2  CBPedestal3  CBPedestal4        // the pedestals
    wcColumn1    wcColumn2    wcColumn3    wcColumn4          // the platforms
    gn_gema1     gn_gema2     gn_gema3     gn_gema4           // the gems placeables
    gn_gemb1     gn_gemb2     gn_gemb3     gn_gemb4           // the lightshafts placeables
    wcBlocker                                                 // the blocker
*/

/*
    **** Change History *******************************************************

    Erick, March 20th - Rewrote script. Previous version by Mirko/B W-Husey.
        changes include :-
        rewrote for clarity, neatness and general efficiency
        added gems visual update
        added locks to pedestals
        dumped string-based lockstates checking and replaced with flagsets
        dumped mismatched function types
        fixed screenshake sequence so it lasts longer (old : 3 seconds; new : 12 seconds)
        altered rising platforms sequence (old : all rise at the same time;
            new : platforms rise sequentially, so there's progressive visual flow)

    B W-Husey, March 25th - Modified to include the code to release Jonas from
                            the paralysis effects - solve sequence

    Erick, March 27th - Reassigned Jonas sequence, it was using mismatched functions

    B W-Husey April 2nd - changed effect to remove to cutscene paralysis, modified how Jonas' factions work
    so he starts in a state where ambient enemies won't attack him

    B W-Husey 9th - Remove immobilise also.

    B W-Husey 25th April - Jonas doesn't talk if he's dead
*/


#include "NW_I0_GENERIC"
#include "cu_functions"

// returns the location to create the gem and lightshaft placeables
// this is the same as the pedestal's location, but at a height of 1.58
location gn_GemPlcLoc();

// destroy the gem/lightshaft placeable, if any
void gn_RemoveGem();

// visually update the gem placeable to match the inserted gem item
// creates a shaft of light if the inserted gem is the correct one
// returns TRUE for correct gem inserted
int gn_UpdateGem(string idgem, string idped);

// loops through the area and apply appropriate action to objects
// includes raising platforms, destroying blocker, shaking screen on PCs, and locking pedestals
// this gets called when all gems are in the right place
void gn_Solve();

// assigns the platform placeables to rise
void gn_RaisePlatform(string tag);

// locks the pedestals permanently
void gn_LockPedestal(string tag);

// shake it baby!
void gn_Shake();

void main()
{
    object self = OBJECT_SELF;
    object gem = GetFirstItemInInventory(),
           junk = GetNextItemInInventory();

    string taggem = GetTag(gem);
    string taggembase = GetStringLeft(taggem, 8);

    object area = GetArea(self);
    string idped = GetStringRight(GetTag(self), 1);
    int key = FloatToInt(pow(2.0, StringToFloat(idped) - 1.0)); // get the current lock (i.e. pedestal)
    int lock = GetLocalInt(area, "GN_FINALSTATE");  // get the current lock states (of all four pedestals)
    int flagstate = lock & key; // check if this lock is unlocked

    if (GetIsObjectValid(junk) || taggembase != "GolemGem")
    {   // if there is more than 1 item in pedestal, or item is not golem gem
        gn_RemoveGem(); // destroy gem placeable
        if (flagstate) lock ^= key; // and lock this lock if it was unlocked before
        SetLocalInt(area, "GN_FINALSTATE", lock);
        return;
    }

    int match = gn_UpdateGem(GetStringRight(taggem, 1), idped); // check if gem matches pedestal

    if ((flagstate && !match) || (!flagstate && match)) lock ^= key; // toggles the lock on/off accordingly
    SetLocalInt(area, "GN_FINALSTATE", lock);
    if (lock == 15)
    {
        //Vulc June 12, 2006:  added camera snap to see it
        SetCameraMode(GetFirstPC(),CAMERA_MODE_TOP_DOWN);
        AssignCommand(GetFirstPC(),SetCameraFacing(20.0f));
        AssignCommand(area, gn_Solve()); // if all gemkeys are unlocked, start "solved" sequence
    }
}

void gn_RaisePlatform(string tag)
{
    if (tag == "wcColumn1" || tag == "wcColumn2" ||
        tag == "wcColumn3" || tag == "wcColumn4")
        DelayCommand(StringToFloat(GetStringRight(tag, 1)) * 2.0, // delay the activation anim according to tag,
                     ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE)); // "progressive unfolding"
}                                                                        // rather than everything rising together

void gn_LockPedestal(string tag)
{
    if (tag == "CBPedestal1" || tag == "CBPedestal2" ||
        tag == "CBPedestal3" || tag == "CBPedestal4")
        {
            object self = OBJECT_SELF;
            SetLocked(self, TRUE);
            SetLockKeyRequired(self, TRUE);
            SetLockKeyTag(self, "GN_NOSUCHKEY");
//            CreateObject(OBJECT_TYPE_PLACEABLE, "gn_gemb" + GetStringRight(tag, 1), GetLocalLocation(self, "GN_LOC"));
        }
}

void gn_Shake()
{
    int i;
    for (i = 0; i < 4; i++)
    {
        DelayCommand(IntToFloat(i * 3),
                     ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                         EffectVisualEffect(VFX_FNF_SCREEN_SHAKE),
                                         OBJECT_SELF));
    }
}

void gn_FreeJonas()
{
    object pc = OBJECT_SELF;
    object jonas = GetObjectByTag("Jonas");

    //Clear the paralysed state of Jonas. Depending on whether he has the ring, hostile or not.
    effect e = GetFirstEffect(jonas);
    int etype;
    while (GetIsEffectValid(e))
    {
        etype = GetEffectType(e);
        if (etype == EFFECT_TYPE_CUTSCENE_PARALYZE || etype == EFFECT_TYPE_VISUALEFFECT || etype == EFFECT_TYPE_CUTSCENEIMMOBILIZE) RemoveEffect(jonas, e);
        e = GetNextEffect(jonas);
    }
//    RemoveEffectOfType(oJonas, EFFECT_TYPE_PARALYZE);
//    RemoveEffectOfType(oJonas, VFX_DUR_PARALYZE_HOLD); // Erick sez - should use EFFECT_TYPE_* constansts

    switch (GetLocalInt(jonas, "nFree")) // freedom state of Jonas 0 = bewitched, 1 = free of WL
    {
        case 1:         //Jonas does not attack
        {
            SetLocalInt(jonas, "nFree", 2);
            ChangeToStandardFaction(jonas,STANDARD_FACTION_MERCHANT);
            AddJournalQuestEntry("QRing", 55, pc);
            break;
        }
        default :       //Jonas attacks
        {

            if (GetIsDead(jonas)==FALSE) // if Jonas is dead stop here
            {
                SetLocalInt(jonas, "nCanDie", 1); // Jonas can be killed
                SetLocalInt(jonas, "nFree", 3);
                ChangeToStandardFaction(jonas,STANDARD_FACTION_HOSTILE);
                ScoreAlign(pc,10,5,3,0,10,5,5,10,10,10);            //Who gets alignment points for this
//            SetIsTemporaryEnemy(pc); // Erick sez - this doesn't do anything
                SetIsTemporaryEnemy(pc, jonas); // Erick sez - you want to make pc an enemy of jonas
//            DetermineCombatRound(); // Erick sez - this doesn't do anything either
                 AssignCommand(jonas,SpeakOneLinerConversation("jonas2"));
                AssignCommand(jonas, DetermineCombatRound()); // Erick sez - this might do something, if anything at all. *shrugs*
                AddJournalQuestEntry("QRing", 50, pc);
            }
            break;
        }
    }
}

// Erick 27 March - reassigned "free jonas" sequence. It was referencing wrong objects
// Solve sequence - modified B W-Husey 25th March to release Jonas
void gn_Solve()
{
    object self = OBJECT_SELF; // refers to area here
    object plc = GetFirstObjectInArea(self);
    string tag, tagbase;
    while (GetIsObjectValid(plc))
    {
        tag = GetTag(plc);
        tagbase = GetStringLeft(tag, 8);

        if (tagbase == "wcColumn") AssignCommand(plc, gn_RaisePlatform(tag));
        else if (tagbase == "CBPedest") AssignCommand(plc, gn_LockPedestal(tag));
        else if (tag == "wcBlocker") DestroyObject(plc, 6.0);
        else if (GetIsPC(plc))
        {
            AssignCommand(plc, gn_Shake());
            AssignCommand(plc, gn_FreeJonas());
        }

        plc = GetNextObjectInArea(self);
    }
}

location gn_GemPlcLoc()
{
    object self = OBJECT_SELF;
    if (GetLocalInt(self, "GN_USED")) return GetLocalLocation(self, "GN_LOC");
    SetLocalInt(self, "GN_USED", TRUE);
    location loc = Location(GetArea(self),
                            GetPosition(self) + Vector(0.0, 0.0, 1.58),
                            GetFacing(self));
    SetLocalLocation(self, "GN_LOC", loc);
    return loc;
}

int gn_UpdateGem(string idgem, string idped)
{
    object self = OBJECT_SELF;
    location loc = gn_GemPlcLoc();

    object gemplc = GetLocalObject(self, "GN_GEM");
    if (GetStringRight(GetTag(gemplc), 1) != idgem)
    {   // if existing gem != new gem , destroy old gem and create new one
        if (GetIsObjectValid(gemplc)) DestroyObject(gemplc);
        gemplc = CreateObject(OBJECT_TYPE_PLACEABLE, "gn_gema" + idgem, loc);
        SetLocalObject(self, "GN_GEM", gemplc);
    }

    object solplc = GetLocalObject(self, "GN_SOL");
    if (idgem != idped) // if id of gem matches id of placeble
    {
        if (GetIsObjectValid(solplc))
        {
            DestroyObject(solplc);
            DeleteLocalObject(self, "GN_SOL");
        }
        return FALSE; // idgem doesn't match idped
    }

    if (!GetIsObjectValid(solplc))
    {
        solplc = CreateObject(OBJECT_TYPE_PLACEABLE, "gn_gemb" + idgem, loc);
        SetLocalObject(self, "GN_SOL", solplc);
//        DestroyObject(sol, 3.0);
    }

    return TRUE; // idgem matches idped
}

void gn_RemoveGem()
{
    object gemplc = GetLocalObject(OBJECT_SELF, "GN_GEM"),
           solplc = GetLocalObject(OBJECT_SELF, "GN_SOL");
    if (GetIsObjectValid(gemplc))
    {
        DestroyObject(gemplc);
        DeleteLocalObject(OBJECT_SELF, "GN_GEM");
    }
    if (GetIsObjectValid(solplc))
    {
        DestroyObject(solplc);
        DeleteLocalObject(OBJECT_SELF, "GN_SOL");
    }
}

/*
void main()
{
    // get the value from the activated object's last char
    string sVal = GetStringRight(GetTag(OBJECT_SELF),1); //gets the number of this object from the right of the Tag
    string sModuleState = GetLocalString(GetModule(),"finalPillarState"); //Gets the 4 digit code for the state of the pedestals
    int iVal = StringToInt(sVal); //adjusted for getSubstring
    string sPillarState = GetSubString(sModuleState,iVal-1,1);  //Finds the correct status of this object from the 4 digit code
    string sState;
    object oPillar;
    object oPed;
    object oPC = GetLastClosedBy();
    object oLight;
    int shakeitbaby = 0;
    int i;
    string sRef = "plc_magicred";

    //Variables for detecting the gems
     object oItem = GetInventoryDisturbItem();
     string sKey = GetTag(oItem);
     string sKeyNum = GetStringRight(sKey,1);

    //*********Debug line**************
//    AssignCommand(OBJECT_SELF,SendMessageToPC(oPC,"Start Activated? "+sPillarState));


    //HERE IS WHERE ALL THE ACTIONS NEED TO GO - CHECKING THE OBJECT ADDED
    //If we removed an object, turn off the active stat
    if (GetInventoryDisturbType()==INVENTORY_DISTURB_TYPE_REMOVED)
    {
        if (GetStringLeft(sKey,8) =="GolemGem" && StringToInt(sKeyNum)== iVal)
        SetPlotFlag(oItem,TRUE);
         sPillarState = "0";   //switch states to 'off'
    }
    else if (GetInventoryDisturbType()==INVENTORY_DISTURB_TYPE_ADDED)
    {
        if (GetStringLeft(sKey,8) =="GolemGem" && StringToInt(sKeyNum)== iVal) //added the correct gem
        {
            SetPlotFlag(oItem,FALSE);
            sPillarState = "1";
        }
        else
        {
        //ADD CODE HERE if you want a bad effect for the wrong item
        }
    }

    //*********Debug lines**************
//    AssignCommand(OBJECT_SELF,SendMessageToPC(oPC,"Now Activated? "+sPillarState));
//    AssignCommand(OBJECT_SELF,SendMessageToPC(oPC,"Pedestal is: "+sVal));

    string sExample = sModuleState;
    sExample = GetSubString(sExample, 0, iVal -1 ) +   //get first iVal-1 digits from 4 digit code
        sPillarState +                                 // + our status (0 or 1)
        GetSubString(sExample, iVal, GetStringLength(sExample)-(iVal));//+  remainder of string from our position

    //*********Debug line**************
//    AssignCommand(OBJECT_SELF,SendMessageToPC(oPC,"4 Digit Code: "+sExample));

    SetLocalString(GetModule(),"finalPillarState",sExample);   //update the 4 digit code
    sModuleState = GetLocalString(GetModule(),"finalPillarState"); //Gets the 4 digit code for the state of the pedestals

    for (i = 1; i<5; i++) //Check all 4
    {
        //
        sState = GetSubString(sModuleState,i-1,1);
        //*********Debug line**************
//        AssignCommand(oPC,SendMessageToPC(oPC,"Pillar " + IntToString(i) + " State: " + sState));

        oPillar = GetNearestObjectByTag( ("wcColumn" + IntToString(i) ) );
        oPed =  GetObjectByTag( ("CBPedestal" + IntToString(i) ) );
        if (sState == "1")
        {
//            shakeitbaby = 1;
//            AssignCommand(oPillar,PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            oLight = CreateObject(OBJECT_TYPE_PLACEABLE,sRef,GetLocation(oPed)); //create and destroy visual clue
            AssignCommand(oLight,DestroyObject(OBJECT_SELF,2.0));
        }
        else AssignCommand(oPillar,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE)); //Remove - pillars will be locked up
    }

    // make the screen shake
    // this is fired if all are ACTIVATED

    if (sModuleState=="1111")
    {
        AssignCommand(GetNearestObjectByTag("wcColumn1"),PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        AssignCommand(GetNearestObjectByTag("wcColumn2"),PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        AssignCommand(GetNearestObjectByTag("wcColumn3"),PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        AssignCommand(GetNearestObjectByTag("wcColumn4"),PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        effect eFX = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFX,oPC,6.0);
        DestroyObject(GetObjectByTag("wcBlocker"));
        //Gems destroyed - pillars locked in up position
        DestroyObject(GetObjectByTag("GemGolem1"),0.1);
        DestroyObject(GetObjectByTag("GemGolem2"),0.1);
        DestroyObject(GetObjectByTag("GemGolem3"),0.1);
        DestroyObject(GetObjectByTag("GemGolem4"),0.1);
    }
}
