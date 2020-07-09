//::///////////////////////////////////////////////
//:: Name x2_def_userdef
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On User Defined Event script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "ddf_util"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void StartIntroConversation(object oPC, object oQuil);
void SpeakRandomLine();

void main()
{
    int nUser = GetUserDefinedEventNumber();

    //if(nUser == EVENT_HEARTBEAT ) //HEARTBEAT
    if(nUser == 1001 || nUser == EVENT_HEARTBEAT)
    {
        string sTag = GetStringUpperCase(GetTag(OBJECT_SELF));
        //if(sTag == "DDF_QUILIAN_INTRO")
        if(FindSubString(sTag, "QUILLIAN") > -1 && GetLocalInt(GetModule(), "dlg_quill_001_done") == FALSE && IsInConversation(OBJECT_SELF) == FALSE)
        {
            //debug("Quilian Heartbeat...");
            //if(IsInConversation(OBJECT_SELF) == FALSE && GetLocalInt(GetModule(), "dlg_quill_001_done") == FALSE)
            if(FALSE)
            {
                //debug("Not in a conversation");

                int bFound = FALSE;
                int nNth = 1;
                object oPlayerInSight = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                                           PLAYER_CHAR_IS_PC,
                                                           OBJECT_SELF,
                                                           nNth);//,
                                                           //CREATURE_TYPE_PERCEPTION,
                                                           //PERCEPTION_SEEN);

                if(GetIsObjectValid(oPlayerInSight) == TRUE && GetLocalString(GetModule(), "ddf_player_name") != GetName(oPlayerInSight))
                {
                    debug("Moving to talk to " + GetName(oPlayerInSight));
                    SetLocalString(GetModule(), "ddf_player_name", GetName(oPlayerInSight));

                    //DelayCommand(5.0, StartIntroConversation(oPlayerInSight, OBJECT_SELF));
                    ClearAllActions();
                    ActionMoveToObject(oPlayerInSight);
                    ActionStartConversation (oPlayerInSight);
                    //ExecuteScript("quill_def_onconv", OBJECT_SELF);
                }
            }
        }
        else if(FindSubString(sTag, "MERCHANT") > -1)
        {
            // Is a merchant. Random something here.
            SpeakRandomLine();
        }

    }
    else if(nUser == EVENT_PERCEIVE || nUser == 1002) // PERCEIVE
    {
        // something for quillian..
        string sTag = GetStringUpperCase(GetTag(OBJECT_SELF));

        SendMessageToPC(GetFirstPC(), "Perceive event " + sTag);
        /*
        if(FindSubString(sTag, "QUILIAN_INTRO") > 99999)
        {
            if(IsInConversation(OBJECT_SELF) == FALSE)
            {
                debug("Not in a conversation");

                int bFound = FALSE;
                int nNth = 1;
                object oPlayerInSight = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                                           PLAYER_CHAR_IS_PC,
                                                           OBJECT_SELF,
                                                           nNth);//,
                                                           //CREATURE_TYPE_PERCEPTION,
                                                           //PERCEPTION_SEEN);

                debug("found a player: " + IntToString(GetIsObjectValid(oPlayerInSight)));

                while (GetIsObjectValid(oPlayerInSight) && bFound == FALSE)
                {
                    if(GetLocalInt(oPlayerInSight,"Stop_Convo" + GetTag(OBJECT_SELF)) == FALSE)
                    {
                        bFound = TRUE;
                    }
                    else
                    {
                        nNth++;
                        oPlayerInSight = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                                                            PLAYER_CHAR_IS_PC,
                                                            OBJECT_SELF,
                                                            nNth);//,
                                                            //CREATURE_TYPE_PERCEPTION,
                                                            //PERCEPTION_SEEN);
                    }
                }

                debug( "bfound: " + IntToString(bFound) + " is valid: " + IntToString(GetIsObjectValid(oPlayerInSight)) );

                if(bFound)
                {
                    DelayCommand(5.0, StartIntroConversation(oPlayerInSight, OBJECT_SELF));
                    //ActionMoveToObject(oPlayerInSight);
                    //ActionStartConversation (oPlayerInSight);
                }
            }
        }
        */

    }
    else if(nUser == EVENT_END_COMBAT_ROUND) // END OF COMBAT
    {

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

    }
    else if(nUser == EVENT_DISTURBED) // DISTURBED
    {

    }
    else if (nUser == EVENT_USER_DEFINED_PRESPAWN)
    {

    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {

    }


}

void StartIntroConversation(object oPC, object oQuil)
{
    AssignCommand(oQuil, ActionMoveToObject(oPC, TRUE));
    AssignCommand(oQuil, ActionStartConversation (oPC));
}

void SpeakRandomLine()
{
    int nConvoNumber = d20();
    int nD100 = d100();
    float temp;
    int temp2;
    string temp3;
    object oChair;
    switch(nConvoNumber) {
        case 1:
            AssignCommand(OBJECT_SELF, ActionSpeakString("G'day to ye, friend!"));
            break;
        case 2:
            AssignCommand(OBJECT_SELF, ActionSpeakString("Hail to you, dear friend."));
            break;
        case 3:
            if(GetIsNight())
                AssignCommand(OBJECT_SELF, ActionSpeakString("What a nice night it is tonight."));
            else
                AssignCommand(OBJECT_SELF, ActionSpeakString("You can't ask for a nicer day than today."));
            break;
        case 4:
            AssignCommand(OBJECT_SELF, ActionSpeakString("I like coconuts!"));
            break;
        case 5:
            AssignCommand(OBJECT_SELF, ActionSpeakString("Hello, my name is " + GetName(OBJECT_SELF)));
            break;
        case 6:
            AssignCommand(OBJECT_SELF, ActionSpeakString("Ohhh... I'm so tired."));
            break;
        case 7:
            ActionSpeakString("Watch this!");
            ActionCastFakeSpellAtObject(SPELL_FIREBALL, OBJECT_SELF);
            break;
        case 8:
            ActionSpeakString("I feel like walking around for a while.");
            ActionRandomWalk();
            break;
        case 9:
            ActionSpeakString("I grow tired of this body.");
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectPolymorph(POLYMORPH_TYPE_BALOR), OBJECT_SELF, 7.5);
            break;
        case 10:
            ActionSpeakString("Some day, I want to have " + IntToString(d20()) + " children!");
            break;
        case 11:
            temp = IntToFloat(nD100);
            temp2 = FloatToInt(FeetToMeters(temp));
            temp3 = IntToString(temp2);
            ActionSpeakString("Did you know that " + IntToString(nD100) + " feet is " + temp3 + " meters?");
            break;
        case 12:
            temp = IntToFloat(nD100);
            temp2 = FloatToInt(YardsToMeters(temp));
            temp3 = IntToString(temp2);
            ActionSpeakString("Did you know that " + IntToString(nD100) + " yards is " + temp3 + " meters?");
            break;
        case 13:
            ActionSpeakString("I need to sit down.");
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(OBJECT_SELF), 2.5);
            oChair = CreateObject(OBJECT_TYPE_PLACEABLE, "chair001", GetLocation(OBJECT_SELF));
            ActionSit(oChair);
            break;
        case 14:
            ActionSpeakString("How are you today, friend?");
            break;
        case 15:
            ActionSpeakString("I just heard a great joke!");
            ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 1.5);
            break;
        case 16:
            ActionSpeakString("It's always the same around here.");
            break;
        case 17:
            ActionSpeakString("I can count to 100.");
            ActionWait(0.7);
            for (nD100 = 1; nD100 <= 100; nD100++) {
                ActionSpeakString(IntToString(nD100));
                ActionWait(0.3);
            }
            break;
        case 18:
            nD100 = GetGender(OBJECT_SELF);
            if (nD100 == GENDER_FEMALE)
                temp3 = "woman?";
            else if (nD100 == GENDER_MALE)
                temp3 = "man?";
            ActionSpeakString("Who's the " + temp3);
            ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1);
            break;
        case 19:
            ActionSpeakString("All in a day's work, my friend.");
            break;
        case 20:
            ActionSpeakString("Your lucky number for today is " + IntToString(nD100));
            break;
    }
}


