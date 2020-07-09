#include "ddf_journal"

void main()
{
    SetLocalInt(GetModule(), "ddf_assassination_article_read", TRUE);
    UpdateJournal(GetPCSpeaker());
}
