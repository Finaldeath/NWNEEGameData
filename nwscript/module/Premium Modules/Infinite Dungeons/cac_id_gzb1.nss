#include "inc_id_liltimmy"

void main()
{
    // g'zhorb was the first inner circle
    SetLocalInt(GetModule(), "bFirstBoss", TRUE);

    // decide on the second inner circle
    int nInnerCircle = Random(2) + 1;

    if (nInnerCircle == 1) // harat
    {
        nInnerCircle = 1;
    } else // masterius
    {
        nInnerCircle = 3;
    }

    // set the second inner circle
    lt_SetSecondBoss(nInnerCircle);
    SetDungeonParameters(2, nInnerCircle);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
}
