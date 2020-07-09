#include "inc_id1_debug"
// object GetNextCPU()
#include "inc_id1_utility"

const int ID1_STEP_SIZE = 20;
const int ID1_LOOK_AHEAD = 50;

void main()
{
    // get the currently examine 2da
    int nDialog = GetLocalInt(GetModule(), "nQueueMax");

    // starting position
    int nStart = GetLocalInt(GetModule(), "nQueueMin");
    int nCount = 0;

    string s2DA;
    string sRead;
    int bEmpty = FALSE;
    int nNum;
    int nAttitude;

    object oMicroCPU;

    while ((bEmpty == FALSE) && (nCount < ID1_STEP_SIZE))
    {
        bEmpty = TRUE;

        // read appropriate 2da
        switch  (nDialog)
        {
            case 0: // random lines
                s2DA = "random_lines";

                sRead = Get2DAString(s2DA, "PERSONAL_REFERENCE_A", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotPersonalReferenceSingularNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotPersonalReferenceSingularNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotPersonalReferenceSingular" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotPersonalReferenceSingular" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "PERSONAL_REFERENCE_B", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotPersonalReferencePluralNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotPersonalReferencePluralNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotPersonalReferencePlural" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotPersonalReferencePlural" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "ADVERB", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAdverbNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAdverbNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAdverb" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAdverb" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_WANT_SINGULAR", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbWantSingularNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbWantSingularNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbWantSingular" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbWantSingular" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_WANT_PLURAL", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbWantPluralNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbWantPluralNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbWantPlural" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbWantPlural" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "PREP_PHRASE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotPrepPhraseNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotPrepPhraseNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotPrepPhrase" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotPrepPhrase" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_LIVING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbLivingNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbLivingNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbLiving" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbLiving" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_FETCH", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbFetchNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbFetchNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbFetch" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbFetch" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_KILL", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbKillNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbKillNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbKill" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbKill" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_EXPLORE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbExploreNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbExploreNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbExplore" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbExplore" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_SEE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbSeeNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbSeeNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbSee" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbSee" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "NOUN_THERE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotNounThereNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotNounThereNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotNounThere" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotNounThere" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_REWARD", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbRewardNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbRewardNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbReward" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbReward" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_SPEAK_TO", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbSpeakToNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbSpeakToNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbSpeakTo" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbSpeakTo" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "VERB_USE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotVerbUseNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotVerbUseNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotVerbUse" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotVerbUse" + IntToString(nNum) + " to " + sRead);
                }

                break;

            case 1: // pleasant lines
            case 2: // neutral lines
            case 3: // fearful lines
            case 4: // hostile lines
                if (nDialog == 1)
                {
                    s2DA = "random_pleasant";
                } else if (nDialog == 2)
                {
                    s2DA = "random_neutral";
                } else if (nDialog == 3)
                {
                    s2DA = "random_fearful";
                } else if (nDialog == 4)
                {
                    s2DA = "random_hostile";
                }

                nAttitude = nDialog;

                sRead = Get2DAString(s2DA, "GREETING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "GreetingNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "GreetingNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Greeting" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Greeting" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "INTRODUCTION", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "IntroductionNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "IntroductionNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Introduction" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Introduction" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "NAME", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "NameNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "NameNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Name" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Name" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "PAYMENT", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "PaymentNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "PaymentNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Payment" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Payment" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "CONFIRMATION", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "ConfirmationNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "ConfirmationNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Confirmation" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "GOOD_RESPONSE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "GoodResponseNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "GoodResponseNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "GoodResponse" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "GoodResponse" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "FAREWELL", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "FarewellNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "FarewellNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Farewell" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Farewell" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "BAD_RESPONSE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "BadResponseNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "BadResponseNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "BadResponse" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "BadResponse" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "RETURN", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "ReturnNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "ReturnNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Return" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "COMPLETE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "CompleteNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "CompleteNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Complete" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Complete" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "INCOMPLETE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "IncompleteNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesPlotAttitude" + IntToString(nAttitude) + "IncompleteNum", nNum);
                    SetLocalString(GetModule(), "sLinesPlotAttitude" + IntToString(nAttitude) + "Incomplete" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesPlotAttitude" + IntToString(nAttitude) + "Incomplete" + IntToString(nNum) + " to " + sRead);
                }

                break;

            case 5: // hostile merchant
            case 6: // friendly merchant
                if (nDialog == 5)
                {
                    s2DA = "merch_hostile";
                    nAttitude = 1;
                } else
                {
                    s2DA = "merch_friendly";
                    nAttitude = 2;
                }

                sRead = Get2DAString(s2DA, "GREETING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "GreetingNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "GreetingNum", nNum);
                    SetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Greeting" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesMerchantAttitude" + IntToString(nAttitude) + "Greeting" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "OFFER", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "OfferNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "OfferNum", nNum);
                    SetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Offer" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesMerchantAttitude" + IntToString(nAttitude) + "Offer" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "GOOD", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "GoodNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "GoodNum", nNum);
                    SetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Good" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesMerchantAttitude" + IntToString(nAttitude) + "Good" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "SHOW", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "ShowNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "ShowNum", nNum);
                    SetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Show" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesMerchantAttitude" + IntToString(nAttitude) + "Show" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "FAREWELL", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "FarewellNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesMerchantAttitude" + IntToString(nAttitude) + "FarewellNum", nNum);
                    SetLocalString(GetModule(), "sLinesMerchantAttitude" + IntToString(nAttitude) + "Farewell" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesMerchantAttitude" + IntToString(nAttitude) + "Farewell" + IntToString(nNum) + " to " + sRead);
                }

                break;

            case 7: // hireling
                s2DA = "hireling";

                sRead = Get2DAString(s2DA, "GREETING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingGreetingNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingGreetingNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingGreeting" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingGreeting" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "BEEN_LIVED", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingBeenLivedNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingBeenLivedNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingBeenLived" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingBeenLived" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "TIME", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingTimeNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingTimeNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingTime" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingTime" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "ADVENTURER", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingAdventurerNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingAdventurerNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingAdventurer" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingAdventurer" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "USEFUL", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingUsefulNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingUsefulNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingUseful" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingUseful" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "HIRING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingHiringNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingHiringNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingHiring" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingHiring" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "ASK", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingAskNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingAskNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingAsk" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingAsk" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "TREASURE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingTreasureNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingTreasureNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingTreasure" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingTreasure" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "REFUSED", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingRefusedNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingRefusedNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingRefused" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingRefused" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "ACCEPTED", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHirelingAcceptedNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHirelingAcceptedNum", nNum);
                    SetLocalString(GetModule(), "sLinesHirelingAccepted" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHirelingAccepted" + IntToString(nNum) + " to " + sRead);
                }

                break;

            case 8: // caster
                s2DA = "random_caster";

                sRead = Get2DAString(s2DA, "GREETING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesCasterGreetingNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesCasterGreetingNum", nNum);
                    SetLocalString(GetModule(), "sLinesCasterGreeting" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesCasterGreeting" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "DESCRIPTION", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesCasterDescriptionNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesCasterDescriptionNum", nNum);
                    SetLocalString(GetModule(), "sLinesCasterDescription" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesCasterDescription" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "QUESTION", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesCasterQuestionNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesCasterQuestionNum", nNum);
                    SetLocalString(GetModule(), "sLinesCasterQuestion" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesCasterQuestion" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "HEALING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesCasterHealingNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesCasterHealingNum", nNum);
                    SetLocalString(GetModule(), "sLinesCasterHealing" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesCasterHealing" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "REMAINDER", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesCasterRemainderNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesCasterRemainderNum", nNum);
                    SetLocalString(GetModule(), "sLinesCasterRemainder" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesCasterRemainder" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "SPELLS", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesCasterSpellsNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesCasterSpellsNum", nNum);
                    SetLocalString(GetModule(), "sLinesCasterSpells" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesCasterSpells" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "CAST", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesCasterCastNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesCasterCastNum", nNum);
                    SetLocalString(GetModule(), "sLinesCasterCast" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesCasterCast" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "FAREWELL", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesCasterFarewellNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesCasterFarewellNum", nNum);
                    SetLocalString(GetModule(), "sLinesCasterFarewell" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesCasterFarewell" + IntToString(nNum) + " to " + sRead);
                }

                break;

            case 9: // monster seller
                s2DA = "random_seller";

                sRead = Get2DAString(s2DA, "GREETING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesSellerGreetingNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesSellerGreetingNum", nNum);
                    SetLocalString(GetModule(), "sLinesSellerGreeting" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesSellerGreeting" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "ASKING", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesSellerAskingNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesSellerAskingNum", nNum);
                    SetLocalString(GetModule(), "sLinesSellerAsking" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesSellerAsking" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "PURCHASE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesSellerPurchaseNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesSellerPurchaseNum", nNum);
                    SetLocalString(GetModule(), "sLinesSellerPurchase" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesSellerPurchase" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "POOR", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesSellerPoorNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesSellerPoorNum", nNum);
                    SetLocalString(GetModule(), "sLinesSellerPoor" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesSellerPoor" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "BOUGHT", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesSellerBoughtNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesSellerBoughtNum", nNum);
                    SetLocalString(GetModule(), "sLinesSellerBought" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesSellerBought" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "GOODBYE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesSellerGoodbyeNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesSellerGoodbyeNum", nNum);
                    SetLocalString(GetModule(), "sLinesSellerGoodbye" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesSellerGoodbye" + IntToString(nNum) + " to " + sRead);
                }

                break;

            case 10: // combat oneliners
                s2DA = "random_combat";

                sRead = Get2DAString(s2DA, "Hostile", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesHostileNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesHostileNum", nNum);
                    SetLocalString(GetModule(), "sLinesHostile" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesHostile" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "Allies", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesAlliesNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesAlliesNum", nNum);
                    SetLocalString(GetModule(), "sLinesAllies" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesAllies" + IntToString(nNum) + " to " + sRead);
                }

                break;

            case 11: // dungeon names
                s2DA = "dungeon_name";

                sRead = Get2DAString(s2DA, "ADJECTIVE", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesDungeonAdjectiveNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesDungeonAdjectiveNum", nNum);
                    SetLocalString(GetModule(), "sLinesDungeonAdjective" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesDungeonAdjective" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "SUBJECT", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesDungeonSubjectNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesDungeonSubjectNum", nNum);
                    SetLocalString(GetModule(), "sLinesDungeonSubject" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesDungeonSubject" + IntToString(nNum) + " to " + sRead);
                }

                sRead = Get2DAString(s2DA, "OBJECT", nStart + nCount);
                if (sRead != "")
                {
                    bEmpty = FALSE;

                    nNum = GetLocalInt(GetModule(), "nLinesDungeonObjectNum");
                    nNum++;
                    SetLocalInt(GetModule(), "nLinesDungeonObjectNum", nNum);
                    SetLocalString(GetModule(), "sLinesDungeonObject" + IntToString(nNum), sRead);
                    DebugMessage("  Set sLinesDungeonObject" + IntToString(nNum) + " to " + sRead);
                }

                break;
        }

        nCount++;
    }

    // if it did not end on a blank line
    if (bEmpty == FALSE)
    {
        // advance to next set of lines
        SetLocalInt(GetModule(), "nQueueMin", nStart + nCount);

        DelayCommand(0.01, ExecuteScript("exe_id1_catdiagw", GetNextCPU()));
    } else // if it ended on a blank line
    {
        // reset 2da start
        SetLocalInt(GetModule(), "nQueueMin", 0);

        // advance to next 2da
        nDialog++;
        SetLocalInt(GetModule(), "nQueueMax", nDialog);
        DebugMessage("Attitude lines.");

        if (nDialog <= 11)
        {
            DelayCommand(0.01, ExecuteScript("exe_id1_catdiagw", GetNextCPU()));
        } else
        {
            DelayCommand(0.01, ExecuteScript("exe_id1_catalog", GetNextCPU()));
        }
    }
}
