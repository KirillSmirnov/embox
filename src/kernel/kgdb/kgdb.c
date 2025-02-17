/**
 * @file
 * @brief
 *
 * @author Aleksey Zhmulin
 * @date 13.06.23
 */
#include <stddef.h>
#include <assert.h>
#include <string.h>
#include <stdbool.h>

#include <drivers/diag.h>
#include <kernel/printk.h>
#include <debug/gdbstub.h>
#include <debug/breakpoint.h>

static int default_bpt_type;

static void kgdb_read(char *dst, size_t nbyte) {
	int i;

	do {
		dst[0] = diag_getc();
	} while (dst[0] != '$');

	for (i = 1; i < nbyte; i++) {
		dst[i] = diag_getc();
		if ((dst[i] == '#') && (i + 3 < nbyte)) {
			nbyte = i + 3;
		}
	}
}

static void kgdb_write(const char *src, size_t nbyte) {
	while (nbyte--) {
		diag_putc(*src++);
	}
}

static void kgdb_bpt_handler(struct bpt_context *ctx) {
	static bool connected = false;

	struct gdb_packet pkt;
	int cmd;

	bpt_disable_all();

	if (connected) {
		gdb_process_cmd(GDB_CMD_CONT, &pkt);
		kgdb_write(pkt.buf, pkt.size);
	}
	else {
		connected = true;
	}

	for (;;) {
		kgdb_read(pkt.buf, sizeof(pkt.buf));
		kgdb_write("+", 1);

		cmd = gdb_process_packet(&pkt, ctx);

		if (cmd == GDB_CMD_CONT) {
			break;
		}

		if (cmd == GDB_CMD_DETACH) {
			connected = false;
			bpt_remove_all();
			break;
		}

		kgdb_write(pkt.buf, pkt.size);
	}

	bpt_remove(default_bpt_type, GDB_BPT_CTX_PC(ctx));
	bpt_enable_all();
}

#if 0
static bool kgdb_break_required(void) {
	while (diag_kbhit()) {
		if (diag_getc() == GDB_INTERRUPT_CHAR) {
			return true;
		}
	}

	return false;
}
#endif

void kgdb_start(void *entry) {
	struct bpt_env env;

	printk("Remote debugging using diag\n");

	bpt_env_init(&env, kgdb_bpt_handler, true);
	bpt_env_restore(&env);

	if (bpt_set(BPT_TYPE_SOFT, entry)) {
		default_bpt_type = BPT_TYPE_SOFT;
	}
	else {
		assert(bpt_set(BPT_TYPE_HARD, entry));
		default_bpt_type = BPT_TYPE_HARD;
	}
}
