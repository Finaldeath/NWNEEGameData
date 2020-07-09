#include "ddf_journal"
void main()
{
    SetLocalInt(GetModule(), "dlg_quill_002_done", TRUE);
    UpdateJournal(GetPCSpeaker());
}
