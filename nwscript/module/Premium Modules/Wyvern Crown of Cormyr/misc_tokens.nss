// February 2006
// B W-Husey
// All the presets for the custom tokens are now here so they can be called from anywhere.


void main()
{

    //Set custom tokens - all those set at the start use 1050 + (except 1051 - better planning required next time!)
        if (GetGender(OBJECT_SELF)==GENDER_MALE)
        {
        SetCustomToken(1050,"gentleman");
        SetCustomToken(1052,"laddy");
        SetCustomToken(1054,"brother");

        }
        else
        {
        SetCustomToken(1050,"lady");
        SetCustomToken(1052,"lassy");
        SetCustomToken(1054,"sister");

        }
        // Size dependant tokens (dwarves in small as they use different lists/pheno for jousting)
        if (GetCreatureSize(OBJECT_SELF)!=CREATURE_SIZE_SMALL && GetRacialType(OBJECT_SELF)!=RACIAL_TYPE_DWARF)
        {
        SetCustomToken(1061,"Sir Azar Truesilver");
        SetCustomToken(1062,"Sir Drake Huntcrown");
        SetCustomToken(1063,"Sir Reginald Huntsilver");
        SetCustomToken(1064,"Sir Baradin Hawklin");
        SetCustomToken(1065,"Lady Morgana Wyvernspur");
        SetCustomToken(1066,"Sir Blakeney Hawklin");
        SetCustomToken(1067,"Lady Arianne FitzCormaeril");
        SetCustomToken(1068,"Sir Giolin Wyvernspur");
        }
        else
        {
        SetCustomToken(1061,"Bandobras Tolman");
        SetCustomToken(1062,"Baldo Tolman");
        SetCustomToken(1063,"Stren Sternhelm");
        SetCustomToken(1064,"Hathnor Thunderbrow");
        SetCustomToken(1065,"Rose Greenwood");
        SetCustomToken(1066,"Inuman Insar");
        SetCustomToken(1067,"Lady Arianne FitzCormaeril");
        SetCustomToken(1068,"Millas Hoffin");
        }
        SetCustomToken(1053,"");
        SetCustomToken(1013,"");
        SetCustomToken(1020,"");
        SetCustomToken(1021,"");
        string sDeity = GetDeity(OBJECT_SELF);
        SetCustomToken(1056,sDeity);

        if (!GetLocalInt(GetModule(),"bNoVersionJournal"))
        { // add journal entry
             AddJournalQuestEntry("version",1,GetPCSpeaker(),TRUE,TRUE,TRUE);
        } // add journal entry
}



