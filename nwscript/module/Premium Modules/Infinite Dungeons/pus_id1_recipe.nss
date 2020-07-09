#include "inc_id1_score"
#include "inc_id1_text"

string GetGemType(int nGemType);
string GetGemQuality(int nGemQuality);

void main()
{
    DebugMessage("");

    // get the player
    object oPC = GetItemActivator();
    DebugMessage("Player for recipe is " + GetPCIdentifier(oPC));

    // get own tag
    string sTag = GetTag(OBJECT_SELF);
    DebugMessage("Recipe tag is " + sTag);

    int nGemType;
    int nGemQuality;
    int nGemNum;

    string sString = "This recipe requires the following components:";

    // decode recipe
    int nCount = 1;
    string sSubTag = GetSubString(sTag, 11 + (nCount - 1) * 3, 3);;
    DebugMessage("String is " + sSubTag);
    while ((nCount <= 7) && (sSubTag != ""))
    {
        DebugMessage("String " + IntToString(nCount) + " is " + sSubTag);

        if (sSubTag != "")
        {
            // get component requirements
            nGemType = DecodeAlphaNumeric(GetSubString(sSubTag, 0, 1));
            nGemQuality = DecodeAlphaNumeric(GetSubString(sSubTag, 1, 1));
            nGemNum = DecodeAlphaNumeric(GetSubString(sSubTag, 2, 1));
            DebugMessage("Decoded numbers are " + IntToString(nGemType) + " " + IntToString(nGemQuality) + " " + IntToString(nGemNum));
            sString = AddLineBreak(sString);
            sString += IntToString(nGemNum) + " " + GetGemQuality(nGemQuality) + " " + GetGemType(nGemType);
        }

        // check next requirement
        nCount++;
        sSubTag = GetSubString(sTag, 11 + (nCount - 1) * 3, 3);
        DebugMessage("String is " + sSubTag);
    }

    // spit out text to player
    AssignCommand(oPC, SpeakString(sString, TALKVOLUME_WHISPER));
}

string GetGemType(int nGemType)
{
    string sString = "ERROR";

    if (nGemType == 1)
    {
        sString = "Sea Pearl";
    } else if (nGemType == 2)
    {
        sString = "Gold Scale Gem";
    } else if (nGemType == 3)
    {
        sString = "Shadow Scale Gem";
    } else if (nGemType == 4)
    {
        sString = "Twilight Star";
    } else if (nGemType == 5)
    {
        sString = "Daeva's Tear";
    } else if (nGemType == 6)
    {
        sString = "Crystalline Blood Gem";
    } else if (nGemType == 7)
    {
        sString = "Bronze Scale Gem";
    } else if (nGemType == 8)
    {
        sString = "Gorgon's Eye Gem";
    } else if (nGemType == 9)
    {
        sString = "Blood Pearl";
    } else if (nGemType == 10)
    {
        sString = "Crystalline Gold Gem";
    } else if (nGemType == 11)
    {
        sString = "Rust Tear Gem";
    } else if (nGemType == 12)
    {
        sString = "Emerald Scale Gem";
    } else if (nGemType == 13)
    {
        sString = "Deep Amethyst";
    } else if (nGemType == 14)
    {
        sString = "Golden Tear Gem";
    } else if (nGemType == 15)
    {
        sString = "Abyssal Ice";
    } else if (nGemType == 16)
    {
        sString = "Demon's Heart Shard";
    }

    return sString;
}

string GetGemQuality(int nGemQuality)
{
    string sString = "ERROR";

    if (nGemQuality == 1)
    {
        sString = "Dark";
    } else if (nGemQuality == 2)
    {
        sString = "Dim";
    } else if (nGemQuality == 3)
    {
        sString = "Shiny";
    } else if (nGemQuality == 4)
    {
        sString = "Glowing";
    } else if (nGemQuality == 5)
    {
        sString = "Radiant";
    }

    return sString;
}

