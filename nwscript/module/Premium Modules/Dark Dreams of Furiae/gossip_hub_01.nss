#include "ddf_util"

// Gossip Consts
const float GOSSIP_DELAY = 4.0;
const string GOSSIP_INDEX = "iGossip";
const string GOSSIP_TIMER = "iGossipTimer";

// Day 1 Text
const string D0_00_00 = "Nice weather we're having today, yeah?";
const string D0_00_01 = "Just roll the dice and stop trying to distract me.";

const string D0_01_00 = "I swear, if you try and cheat me, I'll rip off your arms and wave at you with them as you bleed out.";
const string D0_01_01 = "Why Thrashgar, are you flirting with me?";
const string D0_01_02 = "Maybe.";

const string D0_02_00 = "Didn't one o' them Coranos buy that pier over yonder you've been working near?";
const string D0_02_01 = "Yeah, fired all the workers and brought in their own.";

const string D0_03_00 = "Ya know, I think the nobles hate them devils as much as we do.";
const string D0_03_01 = "What makes ya say?";
const string D0_03_02 = "Well, last week I saw one o' them--";
const string D0_03_03 = "Shut up! I think I saw that bloke's eyes glow! Could be one o' them!";

const string D0_04_00 = "S'a wonder we never get hauled in for dicing out here.";
const string D0_04_01 = "Well, the Guard's alright. They can be reasoned with. It's the devils ya gotta watch out for.";
const string D0_04_02 = "That's the truth.";

const string D0_05_00 = "Them nobles should come on down here and see what a real day's work is like.";
const string D0_05_01 = "Ha! They'd just send one o' their servants down and make 'em describe it to them.";

const string D0_06_00 = "Wonder what them nobles eat out there in the Teeth.";
const string D0_06_01 = "Angel farts and laughter.";
const string D0_06_02 = "Hey, I seen some bottles come in labeled just that. Don't jest.";

const string D0_07_00 = "You read the latest Sentinel? Viscount Watson is gunna be mighty unhappy about that.";
const string D0_07_01 = "You know I ain't got my letters.";
const string D0_07_02 = "Well, we're workin' on it. You'll have 'em soon enough.";
const string D0_07_03 = "'Preciate it.";

// Day 2 Text
const string D1_00_00 = "You see that wheel of flaming eyes roll by the other day?";
const string D1_00_01 = "It's name is Karl, with a *k*.";
const string D1_00_02 = "How do ya know?";
const string D1_00_03 = "It... spoke ta me, I guess? I dunno, I heard music, threw up, and then I knew it's name was Karl, with a *k*.";

const string D1_01_00 = "Whaddya think is going on with that warehouse?";
const string D1_01_01 = "Not sure. Probably some revolutionary plan gone wrong.";

const string D1_02_00 = "Hey, stop trying to palm the dice. I see what you're doing.";
const string D1_02_01 = "Can't slip one past ya, now can I Jerkins?";

const string D1_03_00 = "I think I'm gunna get on one o' these ships one day. See where it takes me.";
const string D1_03_01 = "From the talk I hear, you could end up anywhere from Elysium to Avernus. I'll stay right here, thank you kindly.";

// Day 3 Text
const string D2_00_00 = "Can ya believe Furiae has been here ten years already?";
const string D2_00_01 = "I rightly cannot, Thrashgar.";

const string D2_01_00 = "Gotta chance ta talk to one o' them lizardmen what came in on the last shipment. Know what he told me?";
const string D2_01_01 = "What's that?";
const string D2_01_02 = "Our world has a name. Oerth. Would you fancy that?";
const string D2_01_03 = "Didn't know worlds had names. Didn't know a lot of stuff til we got out here.";

const string D2_02_00 = "I don't like being called a prime, ya know what I mean? It's always said like they're lookin' down on us.";
const string D2_02_01 = "True, true. But I like it out here. Just hoping for the chance to punch an angel in a bar fight.";
const string D2_02_02 = "Not like to happen with the devils having their hand around Furiae's throat, but it's a good dream.";


// Day 4 Text
const string D3_00_00 = "Did you hear what happened to the Coranos? Murdered to the last. Well, except for the ones in the Navy. They get the coin now. Probably hired 'em.";

const string D3_01_00 = "I heard there was quite the commotion out in the Teeth yesterday. Don't know what it was, but them nobles deserve anything they get.";

const string D3_02_00 = "Some kind of party out in the Teeth last night?";

const string D3_03_00 = "Damn shop got robbed last night. Most of the Guard where out in the Teeth doing gods know what for the nobles.";

const string D3_04_00 = "Hey, where's that gnome that was out here?";
const string D3_04_01 = "I think I saw someone grab him. I sure weren't gunna get involved. Town like this, he probably did somethin' to deserve it.";

// Day 5 Text
const string D4_00_00 = "Such a sad thing to happen to the Coranos... everyone in the villa, murdered.";
const string D4_00_01 = "Ehh serves them bastards right.";

const string D4_01_00 = "Not sure about the quality of the productions of the Lifeblood Theater after the Vivadan family takes control of it.";
const string D4_01_01 = "You think there will be more murder onstage, or less?";

const string D4_02_00 = "What is happening in this city recently? You'd think with the City Guard, the Harmonium, and the blasted devils, we'd be safer, but no. Exploding building, murder in the Teeth... what's next? Dragons? Hags? Demons?";

const string D4_03_00 = "I'll tell you what, ain't this much nonsense happening back home.";
const string D4_03_01 = "Are we thinking about the same 'back home'? The Great Kingdom? The Flanaess? The place where dragons, and danger, and death are just a way of life? That 'back home'?";
const string D4_03_02 = "Okay, well if ya put it that way.";

// Day 6 Text
const string D5_00_00 = "No, I haven't been sleeping well either. I mean *whispers* I thought the worldwine would help, but it only made it worse.";

const string D5_01_00 = "Hmmm... Isn't Ulan usually out barking today?";

const string D5_02_00 = "Was over to the Sea Market yesterday evenin'. The fishmonger seems pleased with himself. I wonder what happened? I actually heard him whistling. It was terrifying.";

const string D5_03_00 = "Is it just me, or do the City Guard seem rather tense lately?";


void Gossip(float delay, string text, object speaker)
{
    if (delay == 0.0)
    {
        AssignCommand(speaker, SpeakString(text));
    }
    else
    {
        DelayCommand(delay, AssignCommand(speaker, SpeakString(text)));
    }
}

void main()
{
    int nEvent = GetUserDefinedEventNumber();

    if (nEvent == EVENT_HEARTBEAT)
    {
        // TODO: Once the actual NPCs are placed fixed these tags! - Paul
        object oJerkins = GetObjectByTag("JerkinsSit");
        object oThrashgar = GetObjectByTag("ThrashgarSit");

        // If either object doesn't exist then don't play any gossip
        if (oJerkins == OBJECT_INVALID || oThrashgar == OBJECT_INVALID)
        {
            return;
        }

        // If either object is in a conversation then don't play any gossip
        if (IsInConversation(oJerkins) || IsInConversation(oThrashgar))
        {
            return;
        }

        // have to subtract one, because the game actually starts on "day 1", but
        // we originally had it 0 indexed...
        int iCurrentDay = GetCurrentDay() - 1;//  GetLocalInt(GetModule(), "DDF_CURRENT_DAY");
        int iGossipIndex = GetLocalInt(oJerkins, GOSSIP_INDEX);
        int iGossipTimer = GetLocalInt(oJerkins, GOSSIP_TIMER);

        //SendMessageToPC(GetFirstPC(), "Index " + IntToString(iGossipIndex) + " Timer " + IntToString(iGossipTimer));

        // We need to wait another heartbeat before we can play gossip
        if (iGossipTimer > 0)
        {
            SetLocalInt(oJerkins, GOSSIP_TIMER, --iGossipTimer);
            return;
        }

        // We can now play gossip, play the proper day and index
        if (iCurrentDay == 0)
        {
            if (iGossipIndex == 0)
            {
                Gossip(GOSSIP_DELAY * 0, D0_00_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D0_00_01, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if (iGossipIndex == 1)
            {
                Gossip(GOSSIP_DELAY * 0, D0_01_00, oThrashgar);
                Gossip(GOSSIP_DELAY * 1, D0_01_01, oJerkins);
                Gossip(GOSSIP_DELAY * 2, D0_01_02, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 3);
            }
            else if (iGossipIndex == 2)
            {
                Gossip(GOSSIP_DELAY * 0, D0_02_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D0_02_01, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if (iGossipIndex == 3)
            {
                Gossip(GOSSIP_DELAY * 0, D0_03_00, oThrashgar);
                Gossip(GOSSIP_DELAY * 1, D0_03_01, oJerkins);
                Gossip(GOSSIP_DELAY * 2, D0_03_02, oThrashgar);
                Gossip(GOSSIP_DELAY * 3, D0_03_03, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 4);
            }
            else if (iGossipIndex == 4)
            {
                Gossip(GOSSIP_DELAY * 0, D0_04_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D0_04_01, oThrashgar);
                Gossip(GOSSIP_DELAY * 2, D0_04_02, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 3);
            }
            else if (iGossipIndex == 5)
            {
                Gossip(GOSSIP_DELAY * 0, D0_05_00, oThrashgar);
                Gossip(GOSSIP_DELAY * 1, D0_05_01, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if (iGossipIndex == 6)
            {
                Gossip(GOSSIP_DELAY * 0, D0_06_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D0_06_01, oThrashgar);
                Gossip(GOSSIP_DELAY * 2, D0_06_02, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 3);
            }
            else if (iGossipIndex == 7)
            {
                Gossip(GOSSIP_DELAY * 0, D0_07_00, oThrashgar);
                Gossip(GOSSIP_DELAY * 1, D0_07_01, oJerkins);
                Gossip(GOSSIP_DELAY * 2, D0_07_02, oThrashgar);
                Gossip(GOSSIP_DELAY * 3, D0_07_03, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 4);
            }

            // Advance to the next gossip
            SetLocalInt(oJerkins, GOSSIP_INDEX, ++iGossipIndex % 8);
        }
        else if (iCurrentDay == 1)
        {
            if (iGossipIndex == 0)
            {
                Gossip(GOSSIP_DELAY * 0, D1_00_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D1_00_01, oThrashgar);
                Gossip(GOSSIP_DELAY * 2, D1_00_02, oJerkins);
                Gossip(GOSSIP_DELAY * 3, D1_00_03, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 4);
            }
            else if (iGossipIndex == 1)
            {
                Gossip(GOSSIP_DELAY * 0, D1_01_00, oThrashgar);
                Gossip(GOSSIP_DELAY * 1, D1_01_01, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if (iGossipIndex == 2)
            {
                Gossip(GOSSIP_DELAY * 0, D1_02_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D1_02_01, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if (iGossipIndex == 3)
            {
                Gossip(GOSSIP_DELAY * 0, D1_03_00, oThrashgar);
                Gossip(GOSSIP_DELAY * 1, D1_03_01, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }

            // Advance to the next gossip
            SetLocalInt(oJerkins, GOSSIP_INDEX, ++iGossipIndex % 4);
        }
        else if (iCurrentDay == 2)
        {
            if(iGossipIndex == 0)
            {
                Gossip(GOSSIP_DELAY * 0, D2_00_00, oThrashgar);
                Gossip(GOSSIP_DELAY * 1, D2_00_01, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if(iGossipIndex == 1)
            {
                Gossip(GOSSIP_DELAY * 0, D2_01_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D2_01_01, oThrashgar);
                Gossip(GOSSIP_DELAY * 2, D2_01_02, oJerkins);
                Gossip(GOSSIP_DELAY * 3, D2_01_03, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if(iGossipIndex == 2)
            {
                Gossip(GOSSIP_DELAY * 0, D2_02_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D2_02_01, oThrashgar);
                Gossip(GOSSIP_DELAY * 2, D2_02_02, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }

            // Advance to the next gossip
            SetLocalInt(oJerkins, GOSSIP_INDEX, ++iGossipIndex % 3);
        }
        else if (iCurrentDay == 3)
        {
            if (iGossipIndex == 0)
            {
                Gossip(GOSSIP_DELAY * 0, D3_00_00, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 1);
            }
            else if (iGossipIndex == 1)
            {
                Gossip(GOSSIP_DELAY * 0, D3_01_00, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 1);
            }
            else if (iGossipIndex == 2)
            {
                Gossip(GOSSIP_DELAY * 0, D3_02_00, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 1);
            }
            else if (iGossipIndex == 3)
            {
                Gossip(GOSSIP_DELAY * 0, D3_03_00, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 1);
            }
            else if (iGossipIndex == 4)
            {
                int iQuillOnStreet = GetLocalInt(GetModule(), "ddf_quill_on_street");
                if (iQuillOnStreet == TRUE)
                {
                    Gossip(GOSSIP_DELAY * 0, D3_04_00, oJerkins);
                    Gossip(GOSSIP_DELAY * 1, D3_04_01, oThrashgar);
                    SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
                }
            }

            // Advance to the next gossip
            SetLocalInt(oJerkins, GOSSIP_INDEX, ++iGossipIndex % 5);
        }
        else if (iCurrentDay == 4)
        {
            if (iGossipIndex == 0)
            {
                Gossip(GOSSIP_DELAY * 0, D4_00_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D4_00_01, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if (iGossipIndex == 1)
            {
                Gossip(GOSSIP_DELAY * 0, D4_01_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D4_01_01, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if (iGossipIndex == 2)
            {
                Gossip(GOSSIP_DELAY * 0, D4_02_00, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }
            else if(iGossipIndex == 3)
            {
                Gossip(GOSSIP_DELAY * 0, D4_03_00, oJerkins);
                Gossip(GOSSIP_DELAY * 1, D4_03_01, oThrashgar);
                Gossip(GOSSIP_DELAY * 2, D4_03_02, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 2);
            }

            // Advance to the next gossip
            SetLocalInt(oJerkins, GOSSIP_INDEX, ++iGossipIndex % 4);
        }
        else if (iCurrentDay == 5)
        {
            if (iGossipIndex == 0)
            {
                Gossip(GOSSIP_DELAY * 0, D5_00_00, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 1);
            }
            else if (iGossipIndex == 1)
            {
                Gossip(GOSSIP_DELAY * 0, D5_01_00, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 1);
            }
            else if (iGossipIndex == 2)
            {
                Gossip(GOSSIP_DELAY * 0, D5_02_00, oThrashgar);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 1);
            }
            else if (iGossipIndex == 3)
            {
                Gossip(GOSSIP_DELAY * 0, D5_03_00, oJerkins);
                SetLocalInt(oJerkins, GOSSIP_TIMER, 1);
            }

            // Advance to the next gossip
            SetLocalInt(oJerkins, GOSSIP_INDEX, ++iGossipIndex % 4);
        }
    }
}


