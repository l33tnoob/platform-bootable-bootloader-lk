#include <string.h>
#include <arch/ops.h>
#include <dev/mrdump.h>

#include "aee.h"
#include "kdump.h"

static struct mrdump_control_block *mrdump_cb = NULL;

static void mrdump_query_bootinfo(void)
{
    if (mrdump_cb == NULL) {
        struct mrdump_control_block *bufp = (struct mrdump_control_block *)MRDUMP_CB_ADDR;
        if (memcmp(bufp->sig, "MRDUMP01", 8) == 0) {
            voprintf_debug("Boot record found at %p\n", bufp);
            mrdump_cb = bufp;
            bufp->sig[0] = 'X';
            aee_mrdump_flush_cblock();
        }
	else {
            voprintf_debug("No boot record found at %p[%02x%02x]\n", bufp, bufp->sig[0], bufp->sig[1]);
        }
    }
}

struct mrdump_control_block *aee_mrdump_get_params(void)
{
    mrdump_query_bootinfo();
    return mrdump_cb;
}

void aee_mrdump_flush_cblock(void)
{
    if (mrdump_cb != NULL) {
        arch_clean_cache_range(mrdump_cb, sizeof(struct mrdump_control_block));
    }
}
