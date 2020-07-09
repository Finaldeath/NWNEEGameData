#include "nw_i0_generic"

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;

void SpeakAmbientText()
{
    string sText;
    int n = d6();
    if      (n == 1) sText = "*grunt*";
    else if (n == 2) sText = "*snort*";
    else if (n == 3) sText = "Yarg!";
    else if (n == 4) sText = "Glak!";
    else if (n == 5) sText = "Barg Yarg!";
    else if (n == 6) sText = "Grag Muk!";
    SpeakString(sText);
}

void PlayAmbientSounds()
{
    string sSnd;
    int n = d6();
    if      (n == 1)  sSnd = "it_armorplate";
    else if (n == 2)  sSnd = "c_orc_slct";
    else if (n == 3)  sSnd = "it_blademedium";
    else if (n == 4)  sSnd = "c_orc_atk1";
    else if (n == 5)  sSnd = "c_orc_atk2";
    else if (n == 6)  sSnd = "it_bladesmall";
    PlaySound(sSnd);
}

void main()
{
    if (GetLocalInt(OBJECT_SELF, "HF_DISABLE_AM") != 0)
    {
        return;
    }

    int nUser = GetUserDefinedEventNumber();
    if (nUser == EVENT_HEARTBEAT)
    {
        if (d2() == 1)
        {
            PlayAmbientSounds();
            DelayCommand(3.0, PlayAmbientSounds());
        }
        /*
        if (d6() == 1)
        {
            SpeakAmbientText();
        }
        */
    }
    else if (nUser == EVENT_USER_DEFINED_POSTSPAWN)
    {
        SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);
    }
}
