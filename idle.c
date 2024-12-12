#include <unistd.h>
#include <time.h>
#include <signal.h>
#include <stdlib.h>

static volatile int keep_running = 1;

void handle_signal(int sig) {
    keep_running = 0;
}

void _start() {
    // Set up signal handlers for SIGTERM and SIGINT
    struct sigaction sa;
    sa.sa_handler = handle_signal;
    sa.sa_flags = 0; // No special flags
    sigemptyset(&sa.sa_mask);
    sigaction(SIGTERM, &sa, NULL);
    sigaction(SIGINT, &sa, NULL);

    struct timespec ts = {1, 0}; // 1 second, 0 nanoseconds
    while (keep_running) {
        nanosleep(&ts, NULL);
    }

    // Exit cleanly
    _exit(0);
}
