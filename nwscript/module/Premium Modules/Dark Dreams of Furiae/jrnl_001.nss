#include "ddf_util"


const string S1 = "Teddy seems to work for a woman named Aladara, who was a spiritual advisor to a member of the Corano family named Farasano. He doesn't seem to know anything about worldwine, however.";
const string S2 = "Teddy is now dead; he won't be of any more use.";
const string S3 = "With Quillian out of the picture, Harasi has had to deal directly with Aladara to obtain worldwine for distribution -- though they seem concerned about what to do without the alchemist. ";
const string S4 = "Ulan seems concerned that Harasi is making moves on the entire worldwine operation.";

void SetToken(int nIndex, string sValue);
int GetTokenValue(int nIndex);

void main()
{

}

void UpdateJournalEntry(int nIndex)
{
    // Did you learn about ALADARA via talking to TEDDY
    // module var "ddf_aladara_via_teddy"
    if(TRUE) SetToken(0, S1); // 6100
    else SetToken(0, "");


    // Is TEDDY dead?
    // module var "ddf_teddy_alive"
    if(TRUE) SetToken(1, S2); //6101
    else SetToken(1, "");

    // Did you learn about ALADAR via her notes?
    // module var "ddf_aladara_via_notes"
    if(TRUE) SetToken(2, S3); // 6102
    else SetToken(2, "");

    // Did you learn about ALADARA via ULANs notes?
    // module var "ddf_aladara_via_ulan_notes"
    if(TRUE) SetToken(3, S4);
    else SetToken(3, "");

}

void SetToken(int nIndex, string sValue)
{
    SetCustomToken(GetTokenValue(nIndex), sValue);
}

int GetTokenValue(int nIndex)
{
    return TKN_BASE + TKN_JOURNAL + nIndex;
}
