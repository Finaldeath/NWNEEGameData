/////////////////////////////////////////////////
//  BOG Fully Flexible Teleport system 1.0
/////////////////////////////////////////////////
//  Author: Baron of Gateford
//  Date: 06-12-2004
//
//  You now only need this ONE script to handle teleports.
//  All paramters are set via local variables set on the object that is going to teleport the PC.
//
//  Via local variables you can choose whether to;
//  teleport player out of conversation, trigger or placeable
//  teleport player with or without companions (if teleporting within same area)
//  teleport player alone or the whole party (players)
//  Make the player say a one liner when being teleported.
//  Send a message to the Player to let them know what happened.
//  Choose from 5 visual effects to play when the player is teleported.
//
//  Installation Instructions
//  -------------------------
//
//  Place this script on the one of the following script slots (depending on who/what teleports the PC)
//  Onused - for placeables that when used teleport the PC
//  OnEnter - for triggers that teleport the PC when the PC enters them.
//  Action Taken(of conversation) - when the PC is teleported via a conversation node (called from either NPC or Placeable).
//
//  Now set the variables on the object performing the teleport (NPC/Trigger/placeable)
//
//  Variable instructions.
//  ----------------------
//  The following lists the variables that need to be set-up in order for this teleport system to work.
//  They need to be set on either the placeable,trigger, or NPC that will teleport the PC.
//
//      To set variables on an object;
//      Open up the toolset, right mouse click the object.
//      select 'variables' from the pop up menu.
//
//  TeleType (int)
//     0 = objects (onused)
//     1 = trigger (onenter)
//     2 = coversation
//  This variable is MANDATORY, and lets the script know what kind of object is being used.
//  e.g. if this teleport script is placed on the actions taken slot of a conversation, then set this variable to 2.
//       if this teleport script is placed on the OnEnter slot of a trigger, then set this variable to 1.
//  It will default to onused if it is not set.
//
//  TeleDest (string)
//     Tag of waypoint to be teleported to.
//  This is MANDATORY. The value of this string must be the TAG of the waypoint to be teleported to.
//
//  TeleParty (int)
//     0 = self
//     1 = whole party
//  Set this variable to 1 to teleport the PC and the entire party.
//  It will default to just the PC if it is not set.
//
//  TeleHench (int)
//     0 = self
//     1 = pc and henchman/asociates
//  Set this variable to 1 if you are teleporting within the same area and want all henchmen/associates to be teleported too.
//  It will default to just the PC if it is not set.
//
//  TeleSay (string)
//     Speech pc says when leaving (to let other players know what is happening)
//  Enter the text in this string variable to the text you want the PC to say when he gets teleported.
//  e.g. "I'm going to the Wizards lab", or "I am going down this hole" etc.
//  The PC will not say anything if not set.
//
//  TeleMessage (string)
//     Message sent to pc to describe what happened
//  Enter the text in this string variable to the message you want to send to the PC to describe what happened
//  e.g. "You arrive at the wizards lab", or "You climb down the hole" etc.
//
//  TeleVisual (int)
//     0 = No visual effect
//     1 = Summon monster 1 - Large white explosion that turns to smoke.
//     2 = Summon monster 2 - Purple glyph with white lines moving around purple spots.
//     3 = Summon monster 3 - Blue glyph with orange light on floor and white rising light.
//     4 = Implosion        - Yellow/black "black hole" type look.
//     5 = Summon undead    - Small white cloud.
//  Set this variable to the values listed above for the corresponding visual effect to be used when the PC is teleported.
//  If the variable is set to a value greater than 5 then the VFX used is Summon Monster 1.
//  The VFX will only be used on actual player characters (not henchmen/familiars etc.)
//
///////////////////////////////////////////////

void JumpAssociate(object i_oPC, int i_type, object i_oWP)
{
    object oAssociate = GetAssociate(i_type, i_oPC);
    if(GetIsObjectValid(oAssociate))
        AssignCommand(oAssociate, JumpToObject(i_oWP));
}

void main()
{
    //lula specific code
    object oLula=GetObjectByTag("db_lula");
    SetLocalInt(GetModule(),"lula_met",3);
    DestroyObject(oLula,1.5);

    object oPC;
    //Get the type of object used for the teleport function
    int iTeletype = GetLocalInt(OBJECT_SELF,"TeleType");
    if (iTeletype == 3)
       {
        oPC = GetLastClosedBy();
       }
    else if (iTeletype == 2)
       {
        oPC = GetPCSpeaker();     // for conversations
       }
    else if (iTeletype == 1)
       {
        oPC = GetEnteringObject();  // for triggers
       }
    else
       {
        oPC = GetLastUsedBy();    // for items/objects (default if Teletype int not set)
       }
    // set TeleParty to 1 if you want to teleport the whole party of the player, wherever every member is:
    int iTeleportWholeParty = GetLocalInt(OBJECT_SELF,"TeleParty");
    // set TeleHench to 1 if you want the Associates of the player to be teleported as well, otherwise to 0:
    int iTeleportAssociateToo = GetLocalInt(OBJECT_SELF,"TeleHench");
    //Get the destination waypoint tag (or object) from the local variables set
    string sTeleDest = GetLocalString(OBJECT_SELF,"TeleDest");
    object oDWP = GetObjectByTag(sTeleDest);
    // Make the player say something on his departure (so others will now that he teleported, not crashed):
    string sGoodbye = GetLocalString(OBJECT_SELF,"TeleSay");
    // Enter the message being sent to the player when teleport starts:
    string sTeleportmessage = GetLocalString(OBJECT_SELF,"TeleMessage");
    // The visual effect to be played when teleport happens
    effect eVis;
    int iTeleVisual = GetLocalInt(OBJECT_SELF,"TeleVisual");
    if (iTeleVisual == 1)
        {
         eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        }
    if (iTeleVisual == 2)
        {
         eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2);
        }
    if (iTeleVisual == 3)
        {
         eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
        }
    if (iTeleVisual == 4)
        {
         eVis = EffectVisualEffect(VFX_FNF_IMPLOSION);
        }
    if (iTeleVisual == 5)
        {
         eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        }
    if (iTeleVisual > 5)
        {
         eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        }
    // Don't start Teleport at all if activator isn't a player or DM
    if(!GetIsPC(oPC))
        return;

    if (iTeleportWholeParty == 1)
        {
        object oFM = GetFirstFactionMember(oPC);
        // Step through the party members.
        while(GetIsObjectValid(oFM))
            {
            //only use the visual effect if the local variable has been set
            if (iTeleVisual > 0)
                {
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oFM);
                }
            //only let the PC say something if the local variable has been set
            if (sGoodbye != "")
                {
                 AssignCommand(oFM, ActionSpeakString(sGoodbye));
                }
            //only send a message to the PC if the local variable has been set
            if (sTeleportmessage != "")
                {
                 SendMessageToPC(oFM, sTeleportmessage);
                }
            AssignCommand(oFM,  DelayCommand(1.0, JumpToObject(oDWP)));
            if (iTeleportAssociateToo == 1)
                {
                // now send the players companions over as well:
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_ANIMALCOMPANION, oDWP));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_DOMINATED, oDWP));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_FAMILIAR, oDWP));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_HENCHMAN, oDWP));
                DelayCommand(2.0, JumpAssociate(oFM, ASSOCIATE_TYPE_SUMMONED, oDWP));
                }
            // Select the next member of the faction and loop.
            oFM = GetNextFactionMember(oFM);
            }
        }
    else
       {
        //only use the visual effect if the local variable has been set
        if (iTeleVisual == 1)
           {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
           }
        //only let the PC say something if the local variable has been set
        if (sGoodbye != "")
           {
           AssignCommand(oPC, ActionSpeakString(sGoodbye));
           }
        //only send a message to the PC if the local variable has been set
        if (sTeleportmessage != "")
           {
           SendMessageToPC(oPC, sTeleportmessage);
           }
        AssignCommand(oPC, DelayCommand(1.0, JumpToObject(oDWP)));
        if (iTeleportAssociateToo == 1)
            {
            // now send the players companions over as well:
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_ANIMALCOMPANION, oDWP));
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_DOMINATED, oDWP));
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_FAMILIAR, oDWP));
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_HENCHMAN, oDWP));
            DelayCommand(2.0, JumpAssociate(oPC, ASSOCIATE_TYPE_SUMMONED, oDWP));
            }
        }
}

